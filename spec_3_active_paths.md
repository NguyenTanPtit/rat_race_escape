# SPEC 3 — SLICE 3: NGÂN HÀNG, ĐÒN BẨY, ĐẦU TƯ BẢN THÂN
*Soạn 28/07/2026, sau khi 2.5 đóng tại `52b58f7`. Căn cứ: design_core_loop_v2.md mục 4 (trục D, E) + 3 món treo: lãi tiền gửi (từ 2.5), bài học lương-vs-vật-giá (rút khỏi 2.5), tham vọng "kỹ năng ≥20%" (treo từ 6.2a).*

**[CHỦ DỰ ÁN ĐÃ DUYỆT 28/07/2026]:** (1) vay thế chấp lãi 10%/năm, LTV ≤50%, credit ≥700; (2) TRẢ LẠI khoảng hở lương 3,0% vs vật giá 3,5%, course là vũ khí bù; (3) bot Đòn-Bẩy-Liều phải CHẾT ≥ nửa số seed — liều có án tử.

## 0. Mục tiêu thiết kế

Slice 1-2.5 xây xong đường **passive** (thị trường + phòng thủ + lạm phát). Slice 3 mở hai đường **active** — làm chủ đồng tiền thay vì chỉ gom nhặt:
1. **Ngân hàng**: tiền gửi có lãi (tiền mặt có nơi trú ẩn một phần) + vay thế chấp chủ động (nợ TỐT — công cụ khuếch đại của người kỷ luật, án tử của người liều).
2. **Nâng cấp bản thân**: khóa học tăng lương vĩnh viễn — vũ khí chống lại vật giá.
3. Nhờ có vũ khí, **trả lại khoảng hở lương** (3,0% < vật giá 3,5%) đã rút khỏi 2.5: người không nâng cấp bản thân bị vật giá bỏ lại từ từ.
4. **Đo lại tham vọng "kỹ năng ≥20%"**: đòn bẩy là lever tác động lên TOÀN danh mục đúng lúc đáy — ứng viên số 1 để kỹ năng tạo khoảng cách lớn (kết luận 6.2a: không có đòn bẩy thì bất khả).

Mở khóa 2 tab đang khóa trên BottomNav: **Ngân hàng**, **Nâng cấp**. (Tab "Tài sản" vẫn khóa — backlog.)

## 1. Ngân hàng — tab mới

### 1.1 Tiền gửi tiết kiệm
- `GameState.savingsBalance` (double, netWorth += nó). Gửi/rút TỨC THỜI, không kỳ hạn (đơn giản slice này).
- Lãi `savingsAnnualRate` (config, VN: **4,5%/năm**) cộng vào savings mỗi tháng trong `CalculateCashflow` (rate/12, lãi kép). Lạm phát KHÔNG nhân savings — lãi 4,5% − vật giá 3,5% = thực +1%/năm: **hơn hẳn két (−3,5%) nhưng thua xa index (11%)**. Vai trò đúng đời: chỗ để QUỸ KHẨN CẤP, không phải đường làm giàu.
- Cảnh báo tiền mặt trong Recap Tết đổi thông điệp: nếu cash lớn mà savings trống → "chuyển vào tiết kiệm cũng đỡ mất X".
- Usecase: `DepositSavings` / `WithdrawSavings` (chặn âm, chặn > cash/savings).

### 1.2 Vay thế chấp (nợ tốt — chủ động)
- `TakeBankLoanUseCase(state, amount)`. Điều kiện:
  - `creditScore ≥ 700` (config `bankLoanMinCredit`) — credit lần đầu có CÔNG DỤNG thật.
  - Hạn mức: tổng dư nợ ngân hàng ≤ **50% giá trị thị trường danh mục** (LTV, config) — phải CÓ tài sản thế chấp, không vay tay không.
- Lãi `bankLoanAnnualRate` (config, đề xuất **10%/năm**), minPayment = 2%/tháng dư nợ (dùng entity Loan sẵn có, trả nợ qua PayDebt sẵn có).
- **Vì sao 10% là con số vàng**: yield index tại mệnh giá 11% → vay mua lúc thường chỉ lời 1% (mỏng, chưa kể rủi ro); nhưng mua ĐÁY crash −30% → yield-on-cost 15,7% → margin 5,7% + giá hồi. Đòn bẩy chỉ đáng dùng khi thị trường cho cơ hội = quyết định thú vị đúng nghĩa, không phải nút bấm miễn phí.
- Đường thua thành hiện thực (đã chốt "thua khi chồng sai lầm"): vay max + mua sốt + crash + shock y tế → minPayment đè + forced sell đáy + vay nóng → debtSpiral/bankruptcy.

## 2. Nâng cấp bản thân — tab mới

- Config `courses` trong scenario JSON (3 khóa, giá LẠM PHÁT theo năm — học sớm rẻ hơn):

| id | Tên | Giá gốc | Thời gian | Stress/tháng | Tăng lương |
|---|---|---|---|---|---|
| course_english | Chứng chỉ tiếng Anh | 12tr | 6 tháng | +3 | **+8%** vĩnh viễn |
| course_pro | Chứng chỉ nghề nâng cao | 35tr | 12 tháng | +5 | **+15%** |
| course_master | Văn bằng sau đại học | 90tr | 24 tháng | +6 | **+25%** |

- Mechanic: trả tiền 1 lần → `studyingCourseId` + `studyingMonthsLeft`; mỗi tháng học +stress (trong UpdateMetrics hoặc ProcessNextMonth); xong → `baseSalary × (1+boost)`, vào `completedCourseIds` (mỗi khóa 1 lần, học 1 khóa 1 lúc). Snackbar "🎓 Tốt nghiệp — lương +X%".
- **Trả lại khoảng hở lương**: `salaryGrowthAnnualRate` 3,5% → **3,0%** (vật giá 3,5%). Gap −0,5%/năm ăn dần thặng dư; 1-2 khóa học bù được cả thập kỷ gap. Bài học: nguồn thu nhập chủ động cũng cần được ĐẦU TƯ.

## 3. Nghiệm thu định lượng (bots)

"Kỷ luật chuẩn" mới = bảo hiểm ngày 1 + dự trữ 3 tháng ĐỂ TRONG SAVINGS + học course_english sớm + DCA index.

| Gate | Bot | Yêu cầu |
|---|---|---|
| 1 | DCA-chuẩn | Thắng 3/3 + sweep 20/20, không chết |
| 2 | Kỷ Luật (chuẩn + bắt đáy 2 tháng đệm) | avg ≤1.0 × DCA, mọi seed ≤1.05 |
| 3 | **Kỷ Luật-Đòn-Bẩy** (như 2 + vay ≤50% LTV khi index ≤0.8×trend, trả dần khi hồi) | Nhanh hơn DCA ≥ **10%**; KHÔNG chết seed nào. **Đây là phép đo lại tham vọng 20%** — đo xong BÁO CÁO số thật, không ép |
| 4 | Không-Học (như DCA nhưng không course) | Chậm hơn DCA ≥ **8%** hoặc thua vài seed — course có giá trị |
| 5 | **Đòn-Bẩy-Liều** (vay max mua đất lúc sốt, không bảo hiểm, đệm 1 tháng) | Chết (bankruptcy/debtSpiral) ở **≥ nửa số seed** — án tử có thật |
| 6 | Tiết-Kiệm-Thuần (all savings, không bao giờ đầu tư) | THUA cả 3 seed — savings là trú ẩn, không phải đường thắng |
| 7-9 | Giữ: Ôm-Tiền-Mặt thua · Đất-Tất-Tay ≥1.08 · FOMO ≥1.4 | như cũ |

Lưu ý tune biết trước: gap lương 3,0/3,5 từng làm DCA-không-course chỉ thắng 17/20 (đo ở 2.5) — giờ đó là *tính năng* (gate 4), còn DCA-chuẩn CÓ course phải về lại 20/20.

## 4. Engine/UI tóm tắt
- GameState: `savingsBalance`, `savingsAnnualRate`, `completedCourseIds`, `studyingCourseId`, `studyingMonthsLeft`, cấu hình vay (minCredit/LTV/rate qua config→factory như mọi tham số).
- Usecases mới: DepositSavings, WithdrawSavings, TakeBankLoan, StartCourse (+ hoàn tất course & lãi savings trong pipeline).
- ApplyInflation: nhân thêm giá courses (lưu `courseCostIndex` hoặc tính giá = gốc × inflationIndex — chọn cách 2, khỏi thêm state); savings KHÔNG nhân.
- UI: BankScreen (card Tiết kiệm: số dư/lãi/gửi/rút · card Vay: hạn mức theo credit+LTV, dư nợ, nút vay/trả), UpgradeScreen (3 course card: giá hiện tại, thời gian, tăng lương, trạng thái Đang học/Đã xong), 2 nav item mở khóa, dòng "Lãi tiết kiệm" trong chi tiết dòng tiền, snackbar tốt nghiệp.
- Event scorer bots: dạy thêm nếu cần (không event mới trong slice này — giữ phạm vi).

## 5. Trình tự nộp (Nguyên tắc 8)
1. **3a Ngân hàng**: savings + lãi + vay thế chấp + BankScreen + tests + gates 1-2,6-9 xanh lại.
2. **3b Nâng cấp**: courses + gap lương 3,0 + UpgradeScreen + gate 4.
3. **3c Đòn bẩy bots**: gate 3 + 5, tune, **báo cáo số đo kỹ năng** (có chạm 20% không).
4. Nghiệm thu tay: gửi/rút/vay/trả, học một khóa và thấy lương nhảy, thử tự sát bằng đòn bẩy.

## 6. Ngoài phạm vi
Tab Tài sản (danh mục tổng) · kỳ hạn tiết kiệm/lãi phạt rút sớm · thương lượng lương qua event · scenario khó 6.4 · cooldownMonths 6.3 · avatar/audio polish.
