# SPEC 4 — SLICE 4: BẢNG ĐIỀU KHIỂN TÀI SẢN (tab cuối cùng)

*Soạn 08/08/2026, sau khi Slice 3 đóng tại `cf2c0fc` và chủ dự án nghiệm thu tay: "game thú vị và khó hơn rồi". Căn cứ: rà soát màn chính sau Slice 3 + chủ dự án chốt hướng 08/08/2026.*

## 0. Vấn đề (đo được, không phải cảm tính)

Sau 5 slice, người chơi phải quản lý: tiền mặt · tiết kiệm · 3 lớp tài sản (units, giá vốn, giá thị trường, thanh khoản T+N) · tiền đang về · 3 loại nợ · khóa học đang theo · bảo hiểm · stress/credit/network · lạm phát tích lũy. Nhưng màn chính chỉ hiển thị:

| Đang có | Đang THIẾU |
|---|---|
| Tháng/tuổi, stress/network/credit | **`passiveIncome` — chỉ số QUYẾT ĐỊNH THẮNG, không xuất hiện ở bất kỳ đâu** |
| Chi tiết dòng tiền (lương, sinh hoạt, trọ, quê, BH, nợ) | Số dư tiết kiệm · tiền đang về · danh mục đang giữ · lãi/lỗ |
| Con số tiền mặt | Tài sản ròng thật (**nhãn ghi "Tài sản ròng" nhưng truyền `gameState.cash`** — lỗi tầng lắp ráp) |
| Snackbar milestone 25/50/75% | Vị trí hiện tại trên đường tới đích (giữa các mốc là bóng tối) |

Hệ quả thiết kế: game thưởng **kỷ luật + quản lý thanh khoản**, nhưng người chơi không có dữ liệu để thực hành hai kỹ năng đó. Đây là lỗ hổng "đọc trạng thái", không phải thiếu cơ chế — nên slice này KHÔNG thêm cơ chế mới.

## 1. Mục tiêu

1. **Biến đích thắng thành thứ nhìn thấy được**: passive/outflow là thanh tiến độ, không phải bí mật.
2. **Một màn trả lời "tôi đang đứng đâu"**: tài sản ròng gồm những gì, danh mục lãi/lỗ ra sao, tháng này dư hay thiếu.
3. **Cảnh báo sớm những cái chết đã cài trong engine**: quỹ khẩn cấp mỏng, LTV chạm trần, nợ-đè (debt crush 3c), tiền mặt bị lạm phát ăn.
4. Mở khóa tab cuối cùng trên BottomNav — không còn ổ khóa nào.

## 2. Trình tự nộp

### 4a — Vá màn chính + chuẩn hóa định dạng tiền (đợt nhỏ, commit riêng, làm TRƯỚC)
Để chủ dự án chơi trọn ván với thông tin đúng ngay lập tức:

**4a.1 — Thiếu thông tin:**
- Sửa nhãn: MoneyDisplay nhận `gameState.netWorth` (nhãn "Tài sản ròng" nói đúng sự thật), thêm dòng phụ tiền mặt khả dụng.
- Thêm `_CashflowItem` **"Thu nhập thụ động"** (giá trị dương) vào khối chi tiết dòng tiền — người chơi lần đầu thấy đồng passive mình đang kiếm.
- Rút `structuralSurplus` thành getter trên GameState và cho **CheckGameStatus (debt crush) dùng chung với UI** — nguyên tắc một-công-thức-một-nguồn (mục 3 HANDOFF).

**4a.2 — Số tiền thô lọt ra UI (chủ dự án phát hiện khi chơi 08/08/2026):**
Bốn chỗ đang in thẳng `double` thay vì `MoneyFormat.format()`, ra chuỗi kiểu `1055069480.1234567` / `-5000000.0`:

| File | Chỗ | Hiện ra |
|---|---|---|
| `main_game_screen.dart` — `_CashflowItem` | **toàn bộ khối "Chi tiết dòng tiền"** (lương, sinh hoạt, trọ, gửi quê, BH, nợ) | `-5000000.0` |
| `main_game_screen.dart` — `_showMonthlySummary` | bảng tổng kết tháng: `cashDelta`, `netWorthDelta` | `+1234567.8900000001` |
| `win_screen.dart:63` | bảng thống kê cuối ván | `Net Worth: 1055069480.12` |
| `game_over_screen.dart:85` | bảng thống kê cuối ván | như trên |

Sửa: mọi số tiền đi qua `MoneyFormat.format()`. Lưu ý `format()` **đã tự gắn dấu trừ**, nên chỉ thêm tiền tố `+` cho số dương, tuyệt đối không dựng dấu `-` thủ công (sẽ ra `--5tr ₫`).
Kèm theo: đổi `'Net Worth:'` → **"Tài sản ròng:"** (game tiếng Việt; ARB đã có sẵn key `netWorth`), và thêm dòng **giá trị thực** `netWorth / inflationIndex` ở hai màn kết thúc — đây đúng chỗ để bài học lạm phát đóng đinh (bot Ôm-Tiền-Mặt kết ván 2,73 tỷ danh nghĩa = 622tr thực).

**Test 4a:** cập nhật `main_game_screen_test`, thêm test khẳng định (1) màn chính hiển thị passive + net worth, (2) **không còn chuỗi số thô** — assert theo định dạng `tr ₫`/`tỷ ₫` ở khối dòng tiền, bảng tổng kết tháng và 2 màn kết thúc. Test cuối này là hàng rào chống tái phát: bất kỳ số tiền mới nào quên format sẽ bị bắt.

### 4b — AssetScreen (thân slice)
Route `/assets`, mở khóa nav "Tài sản", 4 khối theo thứ tự dưới. Widget test 360dp bắt buộc (tiền lệ đã cứu 2 vụ tràn).

### 4c — Gộp phản hồi ván chơi
Chủ dự án chơi trọn ván song song; mọi góp ý gom vào đây trước khi commit đóng slice.

## 3. AssetScreen — chi tiết 4 khối

### Khối 1: 🎯 Tiến trình thoát vòng chuột đua *(quan trọng nhất, đặt trên cùng)*
- Thanh ngang: `passiveIncome / totalMonthlyOutflow`, có vạch mốc 25 / 50 / 75 / 100%.
- Dòng số: "Thu nhập thụ động **4,2tr** / Chi phí tháng **18,4tr** — **23%**".
- Dòng thiếu hụt: "Còn thiếu **14,2tr**/tháng để thắng."
- Câu chốt luật chơi: *"Khi cột này đầy, bạn thoát vòng chuột đua."*
- ⚠️ Cảnh báo động: chi phí tăng mỗi Tết, nên % có thể TỤT dù passive tăng — nếu % tháng này thấp hơn lần Tết trước, nói thẳng: *"Vật giá đang chạy nhanh hơn thu nhập thụ động của bạn."* (Chỉ so mốc Tết gần nhất; **không** thêm field vào GameState — tính từ `inflationIndex` và passive hiện tại.)

### Khối 2: 💰 Tài sản ròng
Bảng cộng dồn, mỗi dòng có số tiền:
- Tiền mặt · Tiết kiệm (kèm "+X/tháng tiền lãi")
- Mỗi lớp đang giữ: tên, **giá trị thị trường**, giá vốn trung bình vs giá hiện tại → **lãi/lỗ %** (màu), **passive/tháng** của lớp đó, ghi chú thanh khoản ("bán xong T+2 tháng mới có tiền").
- Tiền đang về: từng khoản + số tháng còn lại ("KHÔNG tiêu được").
- − Tổng nợ (tách nợ ngân hàng / nợ nóng-thẻ).
- **= Tài sản ròng** (đậm) + dòng phụ **giá trị thực**: `netWorth / inflationIndex` kèm "sức mua theo giá năm đầu" — bài học lạm phát hiện ra bằng con số.

### Khối 3: 📊 Dòng tiền tháng này
- Vào: lương (ghi rõ "đang mất việc, còn N tháng" nếu treo) + thu nhập thụ động.
- Ra: sinh hoạt · trọ · gửi quê · bảo hiểm · trả nợ tối thiểu (kèm phần lãi).
- **= Thặng dư/thâm hụt** (màu). Đây là cùng công thức engine dùng, không tính lại trong UI.

### Khối 4: 🚨 Sức khỏe tài chính (chỉ hiện cảnh báo đang bật)
| Cảnh báo | Điều kiện | Thông điệp |
|---|---|---|
| Quỹ khẩn cấp mỏng | `(cash + savings) < 3 × outflow` | "Quỹ khẩn cấp: **1,2 tháng** — một cú sốc y tế là bán tháo đáy." |
| Nợ đè (debt crush) | `totalDueLoanPayment > structuralSurplus` | "Tiền trả nợ **vượt** thặng dư — nợ chỉ có thể phình. Đây là đường vỡ nợ." |
| LTV chạm trần | `totalBankDebt ≥ 0.9 × (LTV × danh mục)` | "Đã dùng **92%** hạn mức thế chấp — giá giảm là bị siết." |
| Tiền mặt chết | `cash > 3 × outflow` | "**45tr** nằm im — mỗi năm mất ~1,6tr sức mua." |

Không có cảnh báo nào bật → khối im lặng (đúng triết lý: giáo dục = cơ chế, không phải text giảng bài).

## 4. Nguyên tắc kỹ thuật (bắt buộc)

- **Mọi số tiền hiển thị PHẢI qua `MoneyFormat.format()`** — không interpolation `double` trực tiếp vào `Text`. (Nguyên tắc mới sau sự cố 4a.2.)
- **UI KHÔNG tự tính tiền.** Thiếu công thức thì thêm getter vào GameState, engine và UI dùng chung. Getter mới dự kiến: `structuralSurplus` (dùng lại trong debt crush), `emergencyFundMonths`, `passiveProgress`, `realNetWorth`, `averageCostPerUnit(asset)`, `unrealizedGainRate(asset)`.
- Presentation **cấm dựng GameState tay** — test dùng builder như `bank_ui_test`/`upgrade_ui_test`.
- Text tiếng Việt hardcode theo tiền lệ LeisureDialog; tên lớp tài sản lấy từ JSON.
- Widget test: đủ 4 khối cần viewport cao (bài học ListView lazy ở 3b-2) + **test riêng 360dp** cho tràn.
- So sánh double ngưỡng < 0.01.

## 5. Nghiệm thu

- **Máy**: chuỗi test giữ xanh, không giảm số test; log một lệnh, timestamp mới.
- **Tay** (bắt buộc, mục 8.6): mở tab Tài sản ở 4 thời điểm — mới bắt đầu (nghèo, 0 passive) · giữa game (có danh mục lãi + đang học) · lúc thị trường sập (lỗ đỏ, tiền đang về) · sát thắng (thanh gần đầy). Kiểm tra không tràn trên máy thật.
- **Không có gate bot mới**: slice này không đụng kinh tế. Nếu có getter được engine dùng lại (structuralSurplus), bots phải xanh y nguyên — chênh lệch là cờ đỏ.

## 6. Ngoài phạm vi

Biểu đồ lịch sử tài sản theo thời gian (cần buffer lịch sử — cân nhắc sau ván chơi) · sắp xếp/lọc danh mục · bán tài sản ngay trong màn này (giữ ở tab Đầu tư, tránh 2 đường vào một hành động) · polish avatar/audio/badge · scenario khó 6.4 · cooldown event 6.3.
