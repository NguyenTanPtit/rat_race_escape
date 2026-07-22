# SPEC 6.2a — MARKET SLICE 1
*Dựa trên `design_core_loop_v2.md` (đã chốt mục 8). Soạn 22/07/2026.*

## 0. Phát hiện tiền đề
Nav "Đầu tư" đang `isLocked: true`, `GameEngineCubit` KHÔNG có hành động mua/bán nào — usecase 6.1 chỉ bot dùng trong test. Slice 1 = engine thị trường + mở khóa trục đầu tư cho người chơi thật.

## 1. Mô hình giá (domain)

**Hai lớp tài sản** (config trong `vn_provincial.json`, mục `marketClasses` — cấm hardcode):

| Tham số | `index_fund` (quỹ index) | `land` (đất) |
|---|---|---|
| name | "Quỹ Index" | "Đất nền" |
| annualYieldRate (cổ tức/thuê, %/năm trên GIÁ GỐC 1.0) | 8.0 | 2.5 |
| monthlyDrift (trend %/tháng) | 0.3 | 0.55 |
| monthlyVolatility (nhiễu ±%/tháng) | 2.0 | 4.5 |
| crashChance (/tháng, chỉ khi normal) | 0.008 | 0.011 |
| crashMonthlyDrift | −4.5 | −7.5 |
| crashMinMonths / MaxMonths | 5 / 10 | 6 / 12 |
| boomChance (/tháng, chỉ khi normal) | 0.010 | 0.014 |
| boomMonthlyDrift | +2.5 | +5.5 |
| boomMinMonths / MaxMonths | 6 / 12 | 6 / 12 |

*(Số liệu khởi điểm — sẽ tune ở bước bot, chỉ sửa JSON.)*

**Cập nhật giá mỗi tháng** (`UpdateMarketUseCase`, nhận `Random` inject như `GenerateEventUseCase`):
```
1. Nếu regime == normal: roll crashChance → vào crash (regimeMonthsLeft = randInt[min,max]);
   nếu không, roll boomChance → vào boom (tương tự).
2. drift = theo regime (normal dùng monthlyDrift).
3. noise = (random.nextDouble()*2 − 1) × monthlyVolatility.
4. price *= (1 + (drift + noise)/100); floor tối thiểu 0.15.
5. peakPrice = max(peakPrice, price). regimeMonthsLeft−−; về normal khi hết.
6. recentPrices: push price, giữ tối đa 12 phần tử (trailing 12 tháng).
```
Thứ tự RNG cố định: crash roll → boom roll → noise, mỗi class theo thứ tự khai báo trong config. Regime là ẨN với người chơi — UI chỉ thấy giá.

**Trạng thái lưu trong GameState** (mới, JSON-serializable, qua Hive như cũ):
```dart
Map<String, MarketClassState> market; // key = classId
MarketClassState { price(=1.0), peakPrice(=1.0), regime(normal/boom/crash),
                   regimeMonthsLeft(0), passivePerUnitMonthly, recentPrices: List<double> }
```
`passivePerUnitMonthly` = annualYieldRate/100/12 (nạp từ config qua GameStateFactory — đúng pattern ScenarioConfig → Factory → GameState). Save cũ không có key `market` → default {} → UpdateMarket bỏ qua, không crash (di trú tự nhiên).

## 2. Asset & mua/bán

`Asset` thêm: `@Default(0.0) double units`, `String? marketClassId`. Asset legacy (event tặng, xe cũ…) giữ nguyên (`marketClassId == null`, giá trị = `baseValue`).

- **Giá trị thị trường** (getter trên GameState — một-công-thức-một-nguồn, UI dùng chung):
  `assetMarketValue(a) = a.marketClassId == null ? a.baseValue : a.units × market[classId].price`
  `netWorth` đổi sang dùng giá thị trường.
- **`BuyMarketAssetUseCase(state, classId, amount)`**: units = amount/price; passive cộng thêm = units × passivePerUnitMonthly (→ mua ĐÁY được yield-on-cost cao hơn — cơ chế thưởng bắt đáy). GỘP holding: mỗi classId tối đa 1 Asset (units +=, baseValue += amount cost-basis, passive +=). Chặn amount ≤ 0 hoặc > cash.
- **`SellMarketAssetUseCase(state, classId, amountValue)`**: bán một phần theo giá trị; unitsSold = amountValue/price (clamp ≤ units đang có); nhận về amountValue × (1 − assetSellFeeRate); trừ units, trừ baseValue & passive THEO TỶ LỆ units bán. Bán hết → xóa Asset.
- Win condition không đổi (passive ≥ outflow); passive per-unit cố định nên không nhảy theo giá — giữ qua crash vẫn có dòng tiền (phao tâm lý, đúng thiết kế).
- `BuyAssetUseCase`/`SellAssetUseCase` cũ GIỮ NGUYÊN cho asset legacy.

## 3. Cubit & stop-conditions (mở rộng LIST 6.5, cùng pattern crossing)

- `buyMarketAsset(classId, amount)` / `sellMarketAsset(classId, amount)`: gọi usecase, `_handleTurnResult`, auto-save — theo đúng mẫu `spendOnLeisure`.
- Stop-conditions mới trong autoAdvance (so oldState vs newState, per class):
  - **Crash**: drawdown = 1 − price/peakPrice CROSSING 0.20 và 0.40 (old<mốc && new≥mốc).
  - **Boom**: ratio = price / avg(recentPrices) CROSSING 1.25 (chỉ khi recentPrices đủ 12).
  - Chỉ kích hoạt khi người chơi ĐÃ có thể đầu tư (luôn đúng ở slice này) — không cần cờ.
- Khi dừng vì thị trường: emit thông tin `marketStopInfo` (classId, kiểu crash/boom, % thay đổi) vào GameEngineState.playing (field mới, session-only như pendingRecap — nếu 6.5 đã có pattern nào cho recap thì theo đúng pattern đó) → UI hiện `MarketDecisionDialog`.

## 4. UI (design system hiện có, không đổi token)

- **BottomNav**: mở khóa "Đầu tư" → mở route `/invest` (go_router).
- **InvestScreen**: mỗi lớp 1 GameCard: tên, giá hiện tại (so đầu kỳ %), badge "−X% từ đỉnh" khi drawdown ≥10%, sparkline 12 tháng (CustomPaint, theo mẫu chart netWorth trong YearlyRecap), holding (giá trị thị trường, vốn, lãi/lỗ %, thu nhập thụ động/tháng), nút Mua/Bán.
- **Dialog Mua/Bán**: theo mẫu LeisureDialog (nhập tiền, chặn vượt cash/holding, hiện phí bán 3%, MoneyFormat chung).
- **MarketDecisionDialog** (tại điểm dừng tua): tiêu đề theo kiểu ("📉 Đất nền sụt −35% từ đỉnh" / "📈 Quỹ Index tăng nóng +30% so với trung bình năm"), 3 nút: Múc thêm (mở dialog Mua) / Bán bớt (mở dialog Bán) / Gồng giữ (đóng). KHÔNG khuyên đúng-sai — người chơi tự chịu.
- Text UI qua ARB (`app_vi.arb`); tên lớp tài sản từ scenario JSON.

## 5. Nghiệm thu định lượng — 3 bot (`market_bots_simulation_test.dart`)

*[GATE CẬP NHẬT 22/07/2026, chủ dự án duyệt sau sweep 20 seed — chi tiết ở design_core_loop_v2.md mục 6]*

1. **Bot DCA mù**: mỗi tháng đầu tư (cash − 3×outflow) vào `index_fund` bất kể giá. PHẢI THẮNG cả 3 seed (42/7/2026).
2. **Bot Kỷ Luật** (DCA + bắt đáy index ≤85% trend bằng dự trữ + chu kỳ đất: mua ≤70% trend / bán nửa khi lãi +40% giá vốn, trần 40% danh mục): trung bình ≤ 1.0× DCA, KHÔNG seed nào > 1.05× — kỹ năng không bao giờ bị phạt. (Ngưỡng 20% cũ đã chứng minh bất khả thi về cấu trúc — time-in-market thắng timing; đo lại ở Slice 3 khi có đòn bẩy.)
3. **Bot FOMO**: chỉ mua khi ratio ≥1.25 (all-in trừ 1×outflow), panic-sell toàn bộ khi drawdown ≥20%: trung bình ≥ 1.4× CHẬM hơn DCA, KHÔNG chết giữa đời (thua hiếm — chưa có đòn bẩy).

File test kèm **SEED SWEEP 20 seeds** (skip mặc định, chạy `--run-skipped`) làm công cụ tune. Log một lệnh chuẩn (Nguyên tắc 9), timestamp mới, tên test grep được.

## 6. Ngoài phạm vi slice này
Shock lớn/quỹ khẩn cấp cưỡng bức (Slice 2), event nhiễu FOMO/panic (Slice 2), đòn bẩy + đường thua đầu tư (Slice 3), đầu tư bản thân (Slice 3), stopReason dialog tổng quát (đánh giá lại sau).
