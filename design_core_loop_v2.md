# THIẾT KẾ V2 — CORE FUN CỦA RAT RACE ESCAPE
*Bản thiết kế trên giấy, soạn 22/07/2026 sau khi chủ dự án chơi trọn ván và kết luận "nhàm". CHƯA phải task code — cần chốt các câu hỏi mở ở mục 8 trước.*

## 1. Chẩn đoán: tại sao nhàm (có bằng chứng máy)

| Bằng chứng | Ý nghĩa |
|---|---|
| Bot DCA if-else vài dòng thắng ổn định cả 3 seed (42/7/2026) | Chiến lược tối ưu là CỐ ĐỊNH → người chơi không có gì để suy nghĩ |
| Kiểm kê 16 event trong `vn_provincial.json`: 6 event chỉ 1 option (chịu chi phí), số còn lại option "đúng" luôn hiển nhiên | Event là hương vị, không phải quyết định |
| Mua tài sản: giá cố định, lãi cố định | Không timing, không rủi ro → hành động auto |
| Thắng ở tháng 226–411 (19–34 năm in-game) chủ yếu bằng tua | Trải nghiệm = xem progress bar |
| Chỉ thua do bỏ bê (burnout/bankruptcy), không có đường thua do QUYẾT ĐỊNH đầu tư sai | Không có rủi ro thật → không có cảm xúc |

**Kết luận:** game hiện không có "quyết định thú vị" nào (trade-off thật + bất định thật + cả hai lựa chọn đều có lý). Nhàm là vấn đề cấu trúc, không phải cá nhân.

## 2. Core fun đề xuất

**Fantasy:** thoát vòng chuột đua bằng KỶ LUẬT tài chính trong một thế giới bất định — không phải bằng may mắn, không phải bằng lướt sóng.

**Cảm xúc mục tiêu:** sợ hãi khi thị trường sụp · tham lam/FOMO khi sốt giá · tiếc nuối khi bỏ lỡ đáy · tự hào khi kỷ luật được đền đáp.

**Nguyên tắc giáo dục = cơ chế, không phải text:** bài học phải được người chơi TỰ RÚT RA từ hậu quả trong game (như bẫy xe máy, bẫy tiết kiệm cực đoan đã làm đúng), insight card chỉ đặt tên cho bài học sau khi đã trải nghiệm.

**Nghịch lý phải xử lý khéo:** "bot DCA không được tối ưu" (chống nhàm) mâu thuẫn với bài học thật ngoài đời "DCA đều tay là chiến lược tốt". Giải quyết:

- DCA mù vẫn là đường THẮNG an toàn (bài học giữ nguyên) — nhưng chậm.
- **Panic-sell khi crash bị trừng phạt** (bán đáy, mất trắng phần giảm).
- **Người giữ quỹ khẩn cấp + mua thêm khi crash thắng nhanh hơn đáng kể.**
- **All-in không quỹ khẩn cấp + gặp shock → buộc bán tài sản ở giá hiện tại (có thể là đáy)** → chậm hơn hoặc thua.

→ Kỹ năng được game thưởng là **kỷ luật cảm xúc + quản lý thanh khoản**, không phải trading. Vừa vui vừa đúng bài học.

## 3. Kiểm kê quyết định hiện tại (decision audit)

| Quyết định | Trade-off? | Bất định? | Verdict |
|---|---|---|---|
| Xả stress (leisure) | Nhỏ (tiền↔stress) | Không | Hiển nhiên: stress cao thì xả |
| Side job | Nhỏ (tiền↔stress) | Không | Hiển nhiên: thiếu tiền thì cày |
| Mua tài sản | KHÔNG (giá/lãi cố định) | Không | Auto: dư tiền thì mua |
| Bán tài sản | Phí 3% | Không | Chỉ dùng khi kẹt |
| Event options | Đa số 1 option hoặc option đúng rõ | Có (khi nào ra event) | Hương vị |

**Điểm số: 0/5 quyết định "thú vị".** Mục tiêu V2: mỗi điểm dừng tua phải có ≥1 quyết định mà người chơi phải NGHĨ.

## 4. Năm trục quyết định mới

**A. An toàn vs Tăng trưởng (quỹ khẩn cấp)** — trục QUAN TRỌNG NHẤT, bài học số 1 của tài chính cá nhân VN.
Thêm shock lớn hiếm (viêm ruột thừa ~20–30tr, mất việc 2–3 tháng lương). Nếu cash không đủ: buộc bán tài sản Ở GIÁ THỊ TRƯỜNG HIỆN TẠI (có thể đang đáy) hoặc vay nóng (credit tụt mạnh). → Câu hỏi thường trực: "giữ bao nhiêu tiền mặt là đủ?"

**B. Chu kỳ thị trường (6.2 Market)** — nguồn bất định chính.
- Tài sản có giá biến động theo chu kỳ sốt–sụp nhiều năm + nhiễu tháng. Crash −30~50%, sốt +50~100% so với trend.
- Sự kiện NHIỄU đánh vào tâm lý: "hàng xóm khoe lãi đất ×2" (bẫy FOMO mua đỉnh), "báo đăng thị trường sụp đổ" (bẫy panic-sell đáy).
- Passive income (cổ tức/tiền thuê) tính trên GIÁ VỐN, không đổi theo giá thị trường → giữ qua crash vẫn có dòng tiền (đúng bản chất + là phao tâm lý).

**C. Quyết định tại điểm dừng crash/sốt** — nơi cảm xúc thành gameplay.
Crash → auto-advance DỪNG (stop-condition thị trường, backlog đã ghi) → 3 lựa chọn đều có lý: gồng giữ / bán cắt lỗ / múc thêm bằng tiền dự trữ. Sốt giá → tương tự: chốt lời / giữ / FOMO mua thêm.

**D. Đầu tư vào bản thân (đường active).**
Khóa học/chứng chỉ: tốn tiền + stress vài tháng → tăng lương VĨNH VIỄN. Trade-off với đầu tư tài sản → hai build: career-first vs investor-first. (`e_invest_course` đã có mầm — nâng thành cơ chế chủ động.)

**E. Nợ tốt vs nợ xấu (đòn bẩy).**
Người chơi CHỦ ĐỘNG vay (thế chấp, cần credit cao) mua tài sản tạo dòng tiền. Đòn bẩy + crash + không quỹ khẩn cấp = bài học đắt nhất game. Đối lập với bẫy vay tiêu dùng (xe máy) đã có.

## 5. Nhịp & cột mốc

- **Milestone passive/chi phí 25% → 50% → 75%**: badge + auto-advance dừng + celebration. Chia hành trình 20 năm thành 4 chặng có cảm giác tiến bộ.
- **Tết = điểm quyết định năm**: Recap đã có; cân nhắc thêm 1 lựa chọn "mục tiêu năm tới" (nhẹ, optional).
- **Mục tiêu pacing:** người chơi kỷ luật + biết bắt đáy thắng ~15–18 năm (tháng ~180–220); bot DCA mù vẫn ~24 năm. Khoảng cách đó CHÍNH LÀ phần thưởng cho kỹ năng.

## 6. Thước đo nghiệm thu thiết kế (định lượng — đo bằng máy)

*[CẬP NHẬT 22/07/2026 sau sweep 20 seed — chủ dự án đã duyệt gate mới]*

Ba bot mô phỏng = integration test của 6.2 (`market_bots_simulation_test.dart`):

1. **Bot DCA mù**: PHẢI thắng cả 3 seed chuẩn (bài học "DCA đều tay là đủ" giữ nguyên). Thực tế 20/20 seed thắng, median ~18 năm — khớp pacing đã chốt.
2. **Bot Kỷ Luật** (dự trữ + bắt đáy index sâu + chu kỳ đất theo giá vốn): trung bình ≤ 1.0× DCA và KHÔNG seed nào > 1.05× — kỹ năng không bao giờ bị phạt. Thực tế avg 0.967, seed tốt nhất 0.896.
3. **Bot FOMO** (mua sốt, panic-sell khi sụp): trung bình ≥ 1.4× chậm hơn DCA và không chết giữa đời. Thực tế avg 2.11 — 18/20 seed nghèo đến lúc nghỉ hưu.

Nếu bất đẳng thức không đạt → tune lại, CHƯA nghiệm thu. (Đây cũng là hàng rào chống agent gian lận: kết quả bot là số, grep được.)

**Phát hiện thiết kế (kiểm chứng bằng 5 họ chiến lược bot + sweep 20 seed):** với đích thắng là passive income + cổ tức cố định trên đơn vị + giá hồi quy về trend + phí bán 3%, "time in market" thắng "timing" → DCA mù nằm trong ~5-10% của tối ưu; ngưỡng 20% cũ bất khả thi về cấu trúc. Khoảng cách kỹ năng thật của game là **kỷ luật vs cảm xúc (FOMO tốn gấp ~2 lần thời gian đời người)** — trùng đúng bài học tài chính thực.

**Treo cho Slice 3:** khi thêm đòn bẩy / lãi tiền gửi, ĐO LẠI xem kỹ năng chủ động có tạo được ≥ 20% không — tham vọng 20% chưa bỏ, chỉ chưa khả thi trong kinh tế Slice 1.

## 7. Phạm vi build đề nghị (sau khi chốt mục 8)

- **Slice 1 (6.2a):** 1 lớp tài sản giá biến động + chu kỳ crash/boom + stop-condition thị trường + dialog quyết định tại điểm dừng + 3 bot nghiệm thu + tune. ← lõi của fun, làm TRƯỚC.
- **Slice 2 (6.2b):** shock lớn + cơ chế buộc bán/vay nóng (trục A) + event nhiễu FOMO/panic + flash-sale bắt đáy + **đa dạng hóa: thêm lớp Vàng (trú ẩn — không cổ tức, không crash sâu; yêu cầu của chủ dự án 22/07/2026, dời từ 6.2a)** — có shock thì bài học đa dạng hóa mới có răng.
- **Slice 3:** đầu tư bản thân (D) + vay chủ động (E).
- Polish/6.3 xếp SAU khi loop được chứng minh vui bằng mục 6 + chơi tay.

## 8. Quyết định đã chốt (chủ dự án, 22/07/2026)

1. **Được thua vì đầu tư sai, nhưng HIẾM**: chỉ thua khi chồng nhiều sai lầm (all-in + đòn bẩy + không quỹ khẩn cấp + gặp crash). Sai một lần chỉ bị chậm lại. → Ràng buộc tune: bot FOMO đơn thuần (không đòn bẩy) phải CHẬM chứ không chết; đường chết vì đầu tư chỉ mở ra ở Slice 2–3 khi có đòn bẩy.
2. **Hai lớp tài sản ngay từ Slice 1**: quỹ index ổn định (biến động nhẹ, lãi khiêm tốn) vs đất/cổ phiếu biến động mạnh (crash sâu, sốt cao). Có ngay quyết định phân bổ + dạy đa dạng hóa.
3. **Nhịp thắng người chơi giỏi ~15–18 năm in-game** (tháng ~180–220); bot DCA mù giữ ~24 năm. Ít phải tune lại baseline nhất.
