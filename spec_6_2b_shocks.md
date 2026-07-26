# SPEC 6.2b — SLICE 2: SHOCK LỚN, QUỸ KHẨN CẤP, EVENT NHIỄU, LỚP VÀNG
*Soạn 24/07/2026, sau khi 6.2a đóng tại commit `bf6f97d`. Căn cứ: `design_core_loop_v2.md` mục 4 (trục A), mục 7 (slice plan) + quyết định đã chốt: thua được nhưng HIẾM (chỉ khi chồng nhiều sai lầm); đa dạng hóa dời từ 6.2a sang đây.*

## 0. Mục tiêu thiết kế của slice

6.2a tạo được chu kỳ giá và trừng phạt panic-sell. Nhưng câu hỏi "**giữ bao nhiêu tiền mặt là đủ?**" — bài học số 1 của tài chính cá nhân VN — hiện chưa có răng: không có shock thì all-in mỗi tháng chẳng thiệt gì. Slice 2 thêm RĂNG:
- **Shock lớn hiếm** (viêm ruột thừa, mất việc, **dịch bệnh** — shock hệ thống: mất thu nhập + viện phí + thị trường sụp cùng lúc) → ai không giữ quỹ khẩn cấp bị buộc bán tài sản Ở GIÁ HIỆN TẠI (có thể là đáy) hoặc vay nóng lãi cắt cổ.
- **Bảo hiểm y tế = khoản đầu tư phòng thủ** (card đầu tiên trong tab Đầu tư): phí nhỏ đều đặn đổi lấy cắt đuôi rủi ro y tế.
- **Event nhiễu tâm lý** đánh vào FOMO/panic đúng lúc thị trường sốt/sụp — cám dỗ có thật, người chơi tự chọn.
- **Vàng**: nơi trú ẩn không crash sâu nhưng không sinh passive → đánh đổi an toàn/tốc độ.
- Kèm: **milestone passive 25/50/75%** (rẻ, tăng cảm giác tiến bộ — pattern crossing có sẵn).

Nguyên tắc xuyên suốt: mọi nội dung mới đi qua **event engine + JSON config** hiện có (không hardcode, không màn hình mới); tiền tính qua usecase market dùng chung (một-công-thức-một-nguồn).

## 1. Mở rộng engine (generic, config-driven)

### 1.1 EventTrigger — 3 điều kiện mới (file `event_definition.dart`)
```
maxCash: double?                 // trigger khi state.cash < maxCash (vd 0 = đang âm tiền)
minMarketDrawdown: {classId: String, value: double}?   // drawdown lớp ≥ value
minMarketTrailingRatio: {classId: String, value: double}? // trailingRatio lớp ≥ value
```
`_isTriggerSatisfied` trong `GenerateEventUseCase` đọc `state.market` (đã có sẵn trong GameState — không cần inject gì thêm).

### 1.2 EventEffect — 6 hiệu ứng mới (file `event_effect.dart` + `ApplyEventOptionUseCase`)
```
salarySuspendedMonths: int       // treo lương N tháng (mất việc)
marketSellAllClassIds: [String]  // bán TOÀN BỘ holding các lớp — ở giá hiện tại, chịu phí 3%
marketBuyCashFraction: {classId, fraction}      // mua lớp X bằng fraction × cash hiện có
marketBuyDiscount: {classId, amount, discount}  // mua 'amount' đồng ở giá price×(1−discount) — flash-sale;
                                                // clamp amount ≤ cash; nếu cash < 1tr coi như bỏ qua (debugPrint)
cashIfInsured: double?           // thay thế 'cash' khi state.hasHealthInsurance == true
                                 // (viện phí có bảo hiểm — cùng event, hai mức đau)
forceMarketCrash: {classIds: [String], minMonths, maxMonths}
                                 // ép các lớp vào regime crash (dịch bệnh → thị trường sụp).
                                 // Cần Random → inject Random vào ApplyEventOption (giống GenerateEvent).
```
BẮT BUỘC: `ApplyEventOption` áp các hiệu ứng mua/bán bằng cách GỌI `SellMarketAssetUseCase`/`BuyMarketAssetUseCase` (inject thêm 2 usecase vào ApplyEventOption) — cấm viết lại công thức units/phí. Riêng `marketBuyDiscount` truyền giá đã chiết khấu → cần overload/tham số `priceOverride` trong BuyMarketAssetUseCase (default null = giá thị trường).

### 1.3 GameState + CalculateCashflow
- GameState thêm `@Default(0) int salarySuspendedMonths`.
- `CalculateCashflowUseCase`: nếu `salarySuspendedMonths > 0` → tháng đó lương = 0 và giảm field đi 1 (giảm trong `ProcessNextMonth` cùng chỗ reset leisure để khỏi đụng công thức — chọn 1 chỗ, ghi rõ trong walkthrough).
- UI màn chính: khi đang treo lương, dòng "Lương" hiện `0 ₫ (mất việc, còn N tháng)` — dùng chung getter, không tự tính.

### 1.4 Bảo hiểm y tế — khoản đầu tư phòng thủ
- ScenarioConfig: `healthInsurancePremiumMonthly` (VN: 300.000 ₫/tháng) → factory → GameState.
- GameState: `@Default(false) bool hasHealthInsurance`.
- `CalculateCashflow`: trừ premium khi đang có bảo hiểm; màn chính hiện TÁCH DÒNG "Bảo hiểm y tế −300k" (giống "Gửi về quê" — điểm nhấn giáo dục).
- Cubit: `toggleHealthInsurance()` (usecase nhỏ `ToggleHealthInsuranceUseCase`, CheckGameStatus sau khi áp, auto-save).
- `ApplyEventOption`: nếu effect có `cashIfInsured` và state có bảo hiểm → dùng giá trị đó thay `cash`.
- **UI: card "Bảo hiểm y tế" đứng ĐẦU danh sách màn Đầu tư** (theo yêu cầu chủ dự án: mua bảo hiểm là một quyết định đầu tư): trạng thái Đang có/Chưa có, phí/tháng, mô tả "Giảm ~80% viện phí khi biến cố sức khỏe", nút Mua/Hủy. Mua/hủy tự do (không lách được vì event bất ngờ); nếu bot tìm ra cách lách → cân nhắc waiting period ở 6.3.
- Bài học mã hóa: phí nhỏ đều đặn (~3% lương) đổi lấy cắt đuôi rủi ro — "đầu tư" không chỉ là mua tài sản sinh lời.

### 1.5 Stop-condition milestone (cubit, pattern crossing sẵn có)
`passiveIncome / totalMonthlyOutflow` crossing 0.25 / 0.50 / 0.75 → dừng tua + `milestoneInfo` (session-only, giống marketStopInfo) → SnackBar/celebration đơn giản ("🎉 Thu nhập thụ động đã gánh 25% chi phí!"). KHÔNG thêm dialog phức tạp ở slice này.

## 2. Nội dung mới trong `vn_provincial.json` + `events_vi.json`

### 2.1 Lớp Vàng (marketClasses += 1) — UI Invest tự render, không sửa Dart
| Tham số | `gold` |
|---|---|
| name / type | "Vàng" / stock (hoặc thêm AssetType.gold nếu rẻ) |
| annualYieldRate | **0.0** (không passive — trú ẩn thuần) |
| monthlyDrift | 0.35 |
| monthlyVolatility | 2.5 |
| crashChance / crashMonthlyDrift / min/max | 0.005 / **−2.5** / 4 / 8 (KHÔNG crash sâu — đặc tính trú ẩn) |
| boomChance / boomMonthlyDrift / min/max | 0.010 / +2.5 / 6 / 10 |
| meanReversion | 0.025 |

Lưu ý UI: yield 0 → dòng "Thu nhập ~0%/năm" trông cụt; thêm nhánh hiển thị "Không sinh thu nhập — trú ẩn giá trị" khi annualYieldRate == 0 (sửa nhỏ InvestScreen, có widget test).

### 2.2 Shock lớn (3 event mới)
- **e_appendicitis** — viêm ruột thừa. `weight 0.25` (hiếm, ~1-2 lần/ván). Options: "Bệnh viện tốt" (cash −25tr / **cashIfInsured −5tr**, stress +10) / "Bệnh viện thường" (cash −15tr / **cashIfInsured −3tr**, stress +20). Không né được — cả 2 option đều đau; có bảo hiểm thì đau nhẹ hơn hẳn.
- **e_job_loss** — công ty cắt giảm. `trigger {minAgeInMonths: 300}`, `weight 0.2`. Options: "Nhận trợ cấp, tìm việc từ từ" (salarySuspendedMonths 3, cash +1×lương — trợ cấp thôi việc, stress +15) / "Nhảy việc gấp" (salarySuspendedMonths 1, stress +25).
- **e_pandemic** — DỊCH BỆNH (shock hệ thống, yêu cầu chủ dự án 24/07/2026). `absoluteChance 0.004/tháng ≈ ~4,7%/năm` (knob "tỉ lệ mỗi năm" — chỉnh một số này trong JSON; kỳ vọng ~1-2 lần/ván). CẢ HAI option đều kèm `forceMarketCrash {classIds: [index_fund, land], minMonths 6, maxMonths 9}` — dịch đến thì thị trường sụp, KHÔNG né được phần này (vàng KHÔNG sụp — trú ẩn tỏa sáng đúng lúc). Options:
  - "Ở yên chống dịch, cắt giảm chi tiêu" (cash −5tr / **cashIfInsured −1tr**, stress +15)
  - "Vẫn ra ngoài làm thêm bất chấp" (cash −12tr / **cashIfInsured −3tr** — nhiễm bệnh, stress +25)
  Điểm giáo dục đắt nhất game: mất thu nhập + viện phí + tài sản sụp giá CÙNG LÚC — ai không có quỹ khẩn cấp sẽ phải bán đáy, ai có bảo hiểm + dự trữ coi dịch là đợt flash-sale khổng lồ. Hạn chế đã biết: chưa có cooldownMonths (6.3) nên lý thuyết có thể dính 2 lần gần nhau — xác suất rất thấp, chấp nhận.

### 2.3 Vay nóng khi âm tiền (van cưỡng bức)
- **e_out_of_cash** — `trigger {maxCash: 0}`, `absoluteChance 1.0` (luôn nổ khi đang âm tiền cuối tháng). Options: "Vay nóng 20tr" (addedLoans: 20tr, lãi 40%/năm, minPayment 1,7tr; credit −40; stress +10) / "Tự xoay" (stress +5 — người chơi tự bán tài sản trong màn Đầu tư). Event này là cách "buộc bán/vay nóng" hiện hình mà không cần UI mới; đồng thời là cái phễu mở đường thua debtSpiral cho người chồng sai lầm.

### 2.4 Event nhiễu tâm lý (3 event mới — mỗi cái một cám dỗ)
- **e_neighbor_brag** — trigger `{minMarketTrailingRatio: {land, 1.25}}`, weight 2.0 (nhiễu phải XUẤT HIỆN THƯỜNG khi sốt). "Hàng xóm khoe lời gấp đôi nhờ đất". Options: "All-in theo" (marketBuyCashFraction {land, 0.8}, stress −5 — sướng lúc mua!) / "Mặc kệ" (stress +8 — FOMO ngứa ngáy). Cả hai option đều có giá cảm xúc — đó là điểm giáo dục.
- **e_market_panic_news** — trigger `{minMarketDrawdown: {index_fund, 0.25}}`, weight 2.0. "Báo chí: 'Thị trường sụp đổ, nhà đầu tư tháo chạy'". Options: "Bán tháo hết" (marketSellAllClassIds [index_fund], stress −10 — nhẹ nhõm giả tạo) / "Đóng app, giữ nguyên" (stress +10).
- **e_distress_sale** — trigger `{minMarketDrawdown: {land, 0.30}}`, weight 1.0. "Người quen vỡ nợ, bán gấp lô đất rẻ hơn thị trường 20%". Options: "Mua giúp 30tr" (marketBuyDiscount {land, 30tr, 0.2}) / "Lực bất tòng tâm" (network −3). Flash-sale = phần thưởng cho người CÓ tiền mặt lúc đáy.

Text đầy đủ qua `events_vi.json` theo pattern textKey/labelKey hiện có, giọng đời thường như event cũ.

## 3. Nghiệm thu định lượng — thêm bot thứ 4 (gate mới quan trọng nhất của slice)

Giữ 3 gate cũ (DCA thắng 3/3 · Kỷ Luật avg ≤1.0, mọi seed ≤1.05 · FOMO avg ≥1.4). Bots cũ phải được dạy xử lý event mới theo scoring sẵn có (calculateOptionScore đọc effect mới: salarySuspended tính như mất N×lương; marketSellAll/marketBuy tính 0 điểm cash trực tiếp — bổ sung hàm score, ghi chú rõ).

**[CẬP NHẬT 26/07/2026 — sau tuning, chủ dự án đã duyệt cơ chế thanh khoản]**

**Cơ chế bổ sung: ĐỘ TRỄ THANH KHOẢN (T+N).** Phát hiện trong tuning: khi bán tài sản nhận tiền NGAY, danh mục đầu tư chính là quỹ khẩn cấp hoàn hảo → bot đệm-mỏng NHANH hơn DCA 9% bất kể shock — game thưởng sự liều. Fix: `settlementMonths` per class (index **T+1 tháng**, đất **T+2**, vàng **T+0** — bán tiệm vàng là có tiền, vai trò trú ẩn thành thật). Tiền bán chờ về nằm ở `GameState.pendingProceeds` (tính vào netWorth, KHÔNG tiêu được), đáo hạn trong CalculateCashflow. UI: "⏳ Tiền bán đang về" + ghi chú T+N trong dialog Bán.

**Bot mới: No-Reserve = "Đất-Tất-Tay"** — sai lầm kinh điển VN: all-in ĐẤT, đệm 1 tháng, không bảo hiểm. (Ghi chú trung thực: bot đệm-mỏng cầm INDEX đo được ≈ DCA vì quỹ index thanh khoản thật — đó là tài chính đúng, không phải bug; kẻ cần bài học là người chôn tiền vào đất.) Bots kỷ luật (DCA mù, Kỷ Luật) MUA bảo hIỂM từ tháng 1. Bot Kỷ Luật = thuần index (chu kỳ đất bị phí thanh khoản T+2 ăn hết lợi thế tốc độ — bỏ khỏi đường thắng chuẩn).
- **Gate 4:** No-Reserve/Đất-Tất-Tay CHẬM hơn DCA ≥ 8%. Thực tế: **2.284** — không bao giờ thoát vòng chuột đua (đất không tạo dòng tiền + kém thanh khoản), 1 seed chết burnout.
- **Gate 5 (thua hiếm):** DCA mù + Kỷ Luật KHÔNG được chết ở seed nào; No-Reserve/FOMO ĐƯỢC PHÉP chết.
- Premium bảo hiểm chốt **100k/tháng** (sát BHYT thật; 300k ban đầu làm bảo hiểm thành kèo lỗ — bài học sai). Viện phí: ruột thừa 35/20tr (BH: 6/4tr), dịch bệnh 8/15tr (BH: 2/4tr).

Tune shock frequency/độ đau cho đến khi Gate 1-4 đạt. Dự phòng nếu Gate 4 không tới 8%: tăng weight e_appendicitis hoặc độ sâu chi phí — shock phải đủ đau để dự trữ có nghĩa, nhưng DCA-3-tháng vẫn an toàn tuyệt đối (Gate 5).

## 4. Kiểm thử

- Unit: trigger mới (maxCash/drawdown/ratio đúng-sai biên), effect mới (treo lương giảm dần đúng; sellAll qua đúng usecase + phí; buyFraction clamp cash; buyDiscount giá override + clamp; cash < 1tr bỏ qua im lặng có debugPrint).
- Cubit: milestone crossing dừng tua 1 lần, không re-trigger, clear khi tua tiếp.
- Widget: InvestScreen hiển thị 3 lớp (vàng có dòng "không sinh thu nhập"); EventCard render event mới bình thường (không cần code mới — 1 smoke test).
- Bot: 4 bot × 3 seed + sweep 20 seed cập nhật (công cụ skip).
- Log MỘT lệnh chuẩn, timestamp mới, tên test grep được, dòng "Tổng test: N (trước 187, +x −y kèm lý do)".

## 5. Ngoài phạm vi (chống phình)
Đòn bẩy chủ động/thế chấp (Slice 3) · đầu tư bản thân (Slice 3) · avatar/phòng/audio (polish) · scenario khó 9,5tr (6.4) · đo lại tham vọng "kỹ năng ≥20%" (chờ Slice 3).

## 6. Trình tự nộp (tách nhỏ theo Nguyên tắc 8)
1. **6.2b-1 Engine:** 3 trigger + 6 effect (gồm cashIfInsured, forceMarketCrash) + salarySuspended + bảo hiểm (state/cashflow/usecase toggle) + tests. Nộp log.
2. **6.2b-2 Content:** vàng + 7 event JSON/i18n (3 shock + vay nóng + 3 nhiễu) + card Bảo hiểm & sửa yield-0 trong InvestScreen + milestone stop. Nộp log + screenshot.
3. **6.2b-3 Bots & tune:** bot No-Reserve + bots kỷ luật mua bảo hiểm + dạy bots xử lý event mới + tune đạt Gate 1-5 (gồm kiểm "bảo hiểm phải hời hơn không mua"). Nộp log + bảng số.
4. Nghiệm thu tay: chơi ~10 năm in-game, gặp ít nhất 1 shock + 1 event nhiễu + milestone 25%, thử mua/hủy bảo hiểm và ăn một cú viện phí ở cả hai trạng thái; kiểm cảm giác "đau mà công bằng".
