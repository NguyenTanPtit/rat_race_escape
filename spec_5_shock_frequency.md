# SPEC 5 — SLICE 5: TẦN SUẤT SỐC & NHÂN QUẢ STRESS→ỐM (gộp 6.3)

*Soạn 16/08/2026, từ phản hồi chơi thật của chủ dự án sau Slice 3-4: "người dùng all-in vào tài sản, giữ trong người vài triệu nhưng chả có sự kiện nào tiêu tốn cả." Chủ dự án đã chốt cơ chế + thời điểm 16/08/2026.*

## 0. Chẩn đoán (số đo từ vn_provincial.json hiện hành)

Cơ chế phạt đệm mỏng ĐÃ có và sắc (T+N, vay nóng 40%, debt crush, treo lương) — nhưng xúc xắc gần như không bao giờ đổ:

| Sốc | Tần suất hiện tại |
|---|---|
| Mất việc (w0.4) | **1 lần mỗi ~12 năm** |
| Ruột thừa (w0.5) | 1 lần mỗi ~9,5 năm |
| Dịch bệnh (0.6%/tháng) | 1 lần mỗi ~14 năm |
| **Gộp mọi sốc lớn** | **~1 lần mỗi 3,8 năm** → ván thắng 15 năm gặp ~4 cú, ván may gặp 1-2 |

## 1. Quyết định đã chốt (16/08/2026)

1. **KHÔNG gian lận xúc xắc theo ví** (tăng xác suất sốc khi cash thấp): dạy bài học sai về đời thật, người chơi phát hiện sẽ mất lòng tin, phạt hai lần cùng một lỗi. Xúc xắc công bằng với mọi người — chỉ kẻ không đệm mới đau khi nó đổ.
2. **Tăng tần suất sốc toàn cục** + thêm sốc trung bình mới.
3. **Nhân quả stress→ốm**: event y tế điều kiện minStress — ai cày side job triền miên (chính là dân all-in đệm mỏng) sẽ ốm nhiều hơn. Trung thực như tiền lệ hà-tiện→đau-bao-tử.
4. Làm ở **slice riêng sau khi đóng Slice 4**, gộp 6.3 (cooldown event + bản đồ độ khó) — cùng vùng event, tune một lần.

## 2. Phạm vi

### 2.1 Tune tần suất (con số ĐỀ XUẤT — chốt bằng bots, không chốt bằng cảm tính)
- `e_job_loss`: weight 0.4 → **1.2** (~1 lần/4 năm sau tuổi 25 — đúng đời VN hơn).
- 2 event sốc trung bình mới:
  - **Hỏng xe nặng** (`e_bike_repair_major`, w0.8): −4/−8tr tùy option, không cashIfInsured (BH y tế không che xe) — đánh thẳng vào quỹ khẩn cấp.
  - **Người nhà nhập viện** (`e_family_hospital`, w0.6): −10/−25tr — CỐ Ý không có cashIfInsured: bảo hiểm y tế CỦA MÌNH không che người nhà, chỉ quỹ khẩn cấp đỡ được. Đây là bài học riêng: có những sốc không mua bảo hiểm cá nhân được.
- Cân nhắc nhẹ `baseEventChance` 0.2 → 0.22-0.25 nếu weights chưa đủ (đo trước).

### 2.2 Nhân quả stress→ốm
- Event mới **kiệt sức nhập viện** (`e_overwork_collapse`): trigger `minStress: 70`, weight ~1.5 khi đủ điều kiện, −3/−8tr + cashIfInsured (−0.6/−1.6tr) + stress thay đổi theo option. Cày 2 side job liên tục → stress cao → dính thường xuyên; sống cân bằng thì gần như không gặp.
- Không đổi công thức stress engine — chỉ thêm event điều kiện (tiền lệ minStress đã có ở e_over_saving).

### 2.3 Chất lượng event (6.3 cũ)
- **`cooldownMonths`** trên EventDefinition: sự kiện vừa nổ thì N tháng sau mới được nổ lại (dịch bệnh 24, mất việc 12, ruột thừa 12, sốc mới 6-12) — hết cảnh dính dịch 2 lần sát nhau (hạn chế đã biết từ 6.2b). Trigger check trong GenerateEvent, cần lưu `lastFiredMonth` per event id trong GameState (map `eventLastFired`).
- **Bản đồ độ khó 20 seed**: bảng seed × (số sốc, tổng thiệt hại, tháng thắng DCA) in từ sweep — công cụ nhìn seed nào nghiệt để tune công bằng cảm nhận.

### 2.4 Bots & gates (đổi kinh tế → chạy lại TẤT CẢ)
- Scorer bot: dạy 2 event mới + kiệt sức (cashIfInsured đã hiểu sẵn).
- **Mọi gate hiện hành phải giữ**: DCA-chuẩn thắng 3/3 + sweep 20/20 (có BH + quỹ 3 tháng savings — chính là hành vi được thưởng); Kỷ Luật ≤1.05; Không-Học, Đòn-Bẩy như cũ; Đòn-Bẩy-Liều chết ≥ nửa seed (dễ hơn — sốc dày hơn).
- **Đo và BÁO CÁO** (không ép số trước): khoảng cách noReserve/DCA và fomo/DCA kỳ vọng TĂNG (hiện 3.02) — nếu tăng, đó là bằng chứng cơ chế đạt mục tiêu "đệm mỏng đau thường xuyên hơn". Nếu DCA-chuẩn rớt seed → chẩn đoán cô lập biến (tắt từng event mới) rồi báo cáo, không tự xoay.

## 3. Trình tự nộp
1. **5a**: cooldownMonths engine + test (không đổi số) — nền cho tune.
2. **5b**: 3 event mới + tune weight mất việc + i18n + scorer; chạy gates 3-seed.
3. **5c**: sweep 20 seed + bản đồ độ khó + tune vòng cuối; báo cáo số đo khoảng cách.
4. Nghiệm thu tay: chơi cảm nhận nhịp sốc (không còn "chả có gì xảy ra"), xem cooldown dịch hoạt động.

## 4. Ngoài phạm vi
Xúc xắc theo ví (đã bác) · lạm phát biến động theo năm · kỳ hạn tiết kiệm · thương lượng lương · polish · scenario khó 6.4.
