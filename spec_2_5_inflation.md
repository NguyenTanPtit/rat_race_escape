# SPEC 2.5 — LẠM PHÁT
*Soạn 26/07/2026, sau khi 6.2b đóng tại commit `10e319e`. Căn cứ: `design_core_loop_v2.md` mục 7 (Slice 2.5) — chủ dự án yêu cầu 24/07/2026.*

## 0. Vấn đề đang có

Engine hiện đo mọi thứ bằng "tiền thật đứng yên": chi phí sống 10,5tr ở tháng 1 vẫn là 10,5tr ở năm thứ 30. Hệ quả:
- **Ôm tiền mặt không bị phạt gì.** Giữ 200tr trong két 20 năm không mất một xu → game không có sức ép nào chống lại thói quen phổ biến nhất của người trẻ VN.
- Bài học "tiền mặt nằm im là tiền đang chết" — lý do số 1 người ta *phải* đầu tư — chưa tồn tại trong game.

## 1. Mô hình: chỉ số lạm phát, áp MỖI TẾT

Thêm `inflationIndex` vào GameState (khởi điểm 1.0). Mỗi khi bước sang tháng calendarMonth == 1 (Tết — trùng điểm Recap, người chơi đang dừng đọc số liệu), `ApplyInflationUseCase` nhân:

| Đại lượng | Hệ số |
|---|---|
| monthlyExpenses, monthlyRent, familySupportExpense, healthInsurancePremiumMonthly | × (1 + inflationAnnualRate) |
| baseSalary | × (1 + salaryGrowthAnnualRate) |
| monthlyPassiveIncome của MỌI asset (cổ tức/tiền thuê tăng danh nghĩa) | × (1 + inflationAnnualRate) |
| inflationIndex | × (1 + inflationAnnualRate) |
| **cash, pendingProceeds** | **KHÔNG nhân — đây chính là bài học** |

**GIÁ tài sản KHÔNG lạm phát** (giữ ở giá trị thực): quyết định thiết kế có chủ đích — mọi tín hiệu thị trường (drawdown, trailingRatio, "% so với đầu kỳ", ngưỡng crash/boom) giữ nguyên ý nghĩa thực, không bị nhiễu bởi lạm phát danh nghĩa. Để bù, **BuyMarketAsset nhân passive theo inflationIndex hiện tại** (`units × passivePerUnitMonthly × inflationIndex`) → người mua muộn nhận cùng thu nhập thực như người mua sớm với cùng số units. Bất biến: **lợi suất THỰC không đổi theo thời gian**, chỉ tiền mặt bị bào mòn.

Tham số `vn_provincial.json`: `inflationAnnualRate: 0.035` (VN ~3,5%/năm), `salaryGrowthAnnualRate: 0.03`.

**Rủi ro đã biết (mục 3 xử lý):** lương tăng 3% chậm hơn chi phí 3,5% → thặng dư từ lương teo dần (11tr − 10,5tr = 500k ban đầu; sau ~10 năm về 0). Đó vừa là *sức ép giáo dục* ("lương không đuổi được vật giá, phải có passive income"), vừa là *rủi ro làm game bất khả thắng*. Bot quyết định con số cuối.

## 2. Hiển thị (bài học phải THẤY được)

- **YearlyRecap tại Tết** thêm khối lạm phát: "📈 Vật giá năm nay +3,5% — chi phí sống giờ Xtr/tháng · Lương +3,0% → Ytr". Đây là nơi người chơi đang dừng đọc số → điểm dạy tốt nhất.
- Nếu người chơi đang giữ nhiều tiền mặt (cash > 3 tháng outflow) kèm dòng cảnh báo: "💸 Xtr tiền mặt của bạn mất Ytr giá trị năm nay."
- Không thêm màn hình mới, không thêm dialog mới.

## 3. Nghiệm thu định lượng

Giữ 5 gate của 6.2a/6.2b (DCA thắng 3/3 · Kỷ Luật ≤1.0 & mọi seed ≤1.05 · Đất-Tất-Tay ≥1.08 · FOMO ≥1.4 · DCA+Kỷ Luật không chết) — **PHẢI tune lại vì lạm phát dịch chuyển mọi mốc**. Nếu Gate 1 (DCA thắng) vỡ vì thặng dư teo, nâng `salaryGrowthAnnualRate` (tiến tới 3,5% = lương theo kịp vật giá; lạm phát khi đó chỉ phạt tiền mặt) và BÁO CÁO con số cuối, không âm thầm hạ gate khác.

**Gate 6 mới — bot Ôm-Tiền-Mặt** (`cashHoarder`): sống có kỷ luật (cày thêm, xả stress, trả nợ) nhưng KHÔNG BAO GIỜ đầu tư, giữ tất cả bằng tiền mặt.
- PHẢI thua `poorAtRetirement` (hoặc bankruptcy) ở cả 3 seed — không bao giờ thoát vòng chuột đua.
- Log kèm chẩn đoán **giá trị thực** (`netWorth / inflationIndex`) để thấy tiền bốc hơi bằng số, không phải bằng lời.

## 4. Kiểm thử
- Unit `ApplyInflationUseCase`: chỉ áp ở Tết; nhân đúng từng đại lượng; cash/pendingProceeds KHÔNG đổi; index tích lũy đúng sau N năm; scenario có rate 0 → no-op.
- Unit BuyMarketAsset: mua sau 2 năm lạm phát nhận passive nhân theo index (lợi suất thực bằng người mua sớm).
- Cubit/Widget: Recap hiện khối lạm phát + dòng cảnh báo tiền mặt.
- Bot: 5 gate cũ + Gate 6; sweep 20 seed cập nhật.
- Log MỘT lệnh chuẩn, timestamp mới, tên test grep được, dòng "Tổng test: N (trước 212, +x −y kèm lý do)".

## 4b. KẾT QUẢ THỰC TẾ (26/07/2026, sau khi code + tune)

**Tham số chốt: `inflationAnnualRate 0.035`, `salaryGrowthAnnualRate 0.035`** (lương THEO KỊP vật giá).
- Thử 3,0% lương (khoảng hở như spec dự kiến) → sweep 20 seed: **DCA chỉ thắng 17/20**. Chẩn đoán bằng cách TẮT lạm phát → DCA thắng lại 20/20 ⇒ thủ phạm đúng là khoảng hở lương, không phải shock của 6.2b. Theo đúng điều khoản dự phòng ở mục 3: nâng lương lên 3,5% và báo cáo. **Bài học "lương không đuổi được vật giá" bị RÚT khỏi slice này** — giữ lại cho Slice 3 (thương lượng lương / đầu tư bản thân), nơi người chơi có công cụ chống lại nó.
- Lạm phát giờ chỉ phạt **tiền mặt nằm im** — đúng lõi bài học, không làm game bất khả thắng.
- Bổ sung ngoài spec (nhất quán kinh tế): `leisureCostPerStressPoint` ×(1+lạm phát) và `sideJobIncome` ×(1+tăng lương) — nếu để đứng yên, xả stress dần thành miễn phí ⇒ lỗ hổng cuối game.

**6 gate cuối (log Sun Jul 26 20:05:32, 224 passed +1 skip):**
| Gate | Yêu cầu | Thực tế |
|---|---|---|
| 1. DCA mù thắng | 3/3 seed | ✅ 227/119/218 tháng · **sweep 20/20** |
| 2. Kỷ Luật không bị phạt | avg ≤1.0, mọi seed ≤1.05 | ✅ **0.988**; sweep avg 0.977, **max 1.000** (không tệ hơn DCA ở BẤT KỲ seed nào) |
| 3. Đất-Tất-Tay chậm | ≥1.08 | ✅ **2.766** |
| 4. FOMO chậm | ≥1.4 | ✅ **2.766** |
| 5. DCA + Kỷ Luật không chết | mọi seed, kể cả sweep | ✅ 20/20 cả hai |
| 6. Ôm-Tiền-Mặt thua | 3/3 seed | ✅ poorAtRetirement cả 3; ví dụ seed 42: danh nghĩa 2,73 tỷ nhưng **giá trị thực chỉ 622tr** (index 4.39) |

**Hai sửa lỗi phát sinh trong lúc tune (đều là lỗi của TEST/BOT, không phải engine):**
1. Bot Kỷ Luật chết burnout seed 500 vì bắt đáy xuống còn 1 tháng dự trữ → hết tiền xả stress trong crash dài. Sửa: dự trữ tối thiểu **2 tháng** khi bắt đáy. Sau 6.2b (shock + T+N), để lại 1 tháng không còn là "kỷ luật" — đây là sửa MÔ HÌNH chơi đúng, không phải gate-gaming.
2. `engine_simulation_test.calculateNetWorth` (mirror độc lập) còn dùng `baseValue`, không tính giá thị trường + pendingProceeds → lệch 4,89tr khi bot cũ nhận đất từ event flash-sale. Sửa mirror theo đúng một-công-thức-một-nguồn.

## 5. Ngoài phạm vi
Lãi tiền gửi ngân hàng (Slice 3 — lúc đó tiền mặt có nơi trú ẩn một phần) · đòn bẩy/thế chấp · thương lượng lương chủ động · lạm phát biến động theo năm (hiện dùng hằng số; ngẫu nhiên hóa để 6.3 nếu muốn).
