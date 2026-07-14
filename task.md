# PROMPT CHO CODING AGENT — Dự án "Rat Race Escape" (Financial Life Sim)

## BỐI CẢNH DỰ ÁN

Bạn là một senior Flutter developer làm việc trên game mô phỏng tài chính giáo dục "Rat Race Escape". Game theo lượt (1 turn = 1 tháng), người chơi quản lý 3 tài nguyên: Tiền (Cash/Net Worth), Stress (0-100%), Network Score, cùng Điểm tín dụng (300-850).

**Tech stack:** Flutter, Clean Architecture (data / domain / presentation), Bloc/Cubit, freezed cho entities và state.

**Core Loop mỗi tháng gồm 4 phase:**
1. Dòng tiền tự động: cộng lương + thu nhập thụ động (cổ tức, tiền cho thuê nhà); trừ chi phí sinh hoạt, tiền thuê nhà, trả góp ngân hàng/thẻ tín dụng.
2. Random Event Engine: sinh 1-2 sự kiện dựa trên tuổi, mức Stress, và Quốc gia/Bối cảnh.
3. Player Action: người chơi xử lý sự kiện, mua bán tài sản, trả nợ.
4. End Turn: tính lại Net Worth, tính lãi nợ, cập nhật Stress + tuổi, kiểm tra Win/Loss, sang tháng mới.

**Điều kiện Win:** Thu nhập thụ động >= Chi phí sinh hoạt.
**Điều kiện Loss:** Tiền < 0 và tín dụng chạm đáy (vỡ nợ); Stress đạt 100% (đột quỵ); nghèo ở tuổi 65 (Bad Ending).

**Cấu trúc code hiện có (đã hoàn thành):**
```
lib/features/
  banking/
  events/
  gameplay/
    data/                     # đang trống hoặc sơ khai
    domain/
      entities/               # asset, game_event, game_state, loan (freezed)
      factories/              # game_state_factory.dart
      repositories/           # ĐANG TRỐNG — cần bổ sung
      usecases/
        calculate_cashflow_usecase.dart
        generate_event_usecase.dart
        process_loans_usecase.dart
        process_next_month_usecase.dart
        update_metrics_usecase.dart
    presentation/
      cubit/                  # game_engine_cubit, game_engine_state (freezed)
      pages/                  # trống
      widgets/                # trống
```

## NGUYÊN TẮC BẮT BUỘC (áp dụng cho mọi task)

1. Tuân thủ nghiêm Clean Architecture: domain KHÔNG import gì từ data/presentation. Repository interface đặt ở `domain/repositories/`, implementation ở `data/repositories/`.
2. KHÔNG hardcode số liệu game balance (lương khởi điểm, xác suất sự kiện, mức phạt, lãi suất...) vào Dart code. Toàn bộ đưa vào file JSON config trong `assets/config/`.
3. Dùng freezed cho mọi entity/model/state mới, đồng bộ style với code hiện có.
4. Mọi usecase và logic tính toán tài chính PHẢI có unit test. Đây là game giáo dục tài chính — công thức sai là lỗi nghiêm trọng nhất.
5. Sau mỗi task: chạy `dart analyze` không lỗi, `flutter test` pass toàn bộ, chạy build_runner nếu có freezed/json_serializable mới.
6. Commit theo từng task, message rõ ràng (conventional commits: feat/fix/test/refactor).
7. Nếu phát hiện code hiện có mâu thuẫn với yêu cầu, dừng lại báo cáo và đề xuất phương án, không tự ý refactor lớn.

## DANH SÁCH TASK (làm tuần tự, hoàn thành + test xong task trước mới sang task sau)

### Task 1 — Repository interfaces + Persistence (save/load game)
- Tạo interface trong `gameplay/domain/repositories/`:
    - `GameStateRepository`: `saveGame(GameState)`, `loadGame()`, `hasSavedGame()`, `deleteSave()`.
    - `EventPoolRepository`: `loadEventPool(CountryId, ScenarioId)` — trả về danh sách GameEvent kèm điều kiện trigger (độ tuổi min/max, ngưỡng stress, tháng trong năm, xác suất).
    - `ScenarioConfigRepository`: `loadScenarioConfig(CountryId, ScenarioId)` — trả về thông số khởi đầu (lương, tiền thuê nhà, khoản gửi về quê, nợ ban đầu...).
- Implement persistence bằng **Hive** trong `gameplay/data/`: model Hive/JSON riêng (không đụng entity domain), mapper 2 chiều model ↔ entity.
- Setup **get_it** làm DI container, đăng ký toàn bộ repository + usecase. Tạo file `lib/core/di/injection.dart`.
- Unit test: save → load ra state giống hệt (round-trip test); load khi chưa có save trả về null/failure đúng thiết kế.

### Task 2 — Event Pool & Scenario Config dạng JSON
- Tạo `assets/config/vn_provincial.json` cho bối cảnh **"Thanh niên tỉnh lẻ lên phố"** (bản miễn phí) gồm:
    - Thông số khởi đầu: tuổi 22, lương thấp, tiền thuê trọ hàng tháng, khoản "Trách nhiệm gia đình" tự động trừ hàng tháng gửi về quê.
    - Event pool tối thiểu 15 sự kiện, trong đó BẮT BUỘC có:
        - "Tết Nguyên Đán" (chỉ trigger tháng 1 hoặc 2): cộng Thưởng Tết, trừ mạnh chi phí mua sắm + lì xì.
        - "Đám cưới bạn thân" (tốn tiền phong bì, tăng Network).
        - Bẫy "Mua xe cũ giá rẻ": chọn xe mới trả góp vs xe cũ trả đứt; nếu chọn xe cũ, set flag ngầm tăng xác suất event "Xe hỏng giữa đường" lên 30% (tốn tiền sửa, trừ lương do đi trễ, tăng Stress).
        - Bẫy "Tiết kiệm thái quá": cắt hết chi tiêu giao lưu → Network về 0, đóng băng thăng chức, tăng xác suất event "Đau dạ dày" viện phí lớn.
- Schema JSON tự thiết kế nhưng phải hỗ trợ: điều kiện trigger (tuổi, stress, tháng, flag), trọng số xác suất, nhiều lựa chọn cho người chơi, hiệu ứng lên cash/stress/network/credit/flags, và `insightCardId` (tham chiếu bài học, dùng ở Task 4).
- Refactor `generate_event_usecase` để đọc từ `EventPoolRepository` thay vì nguồn hiện tại (nếu đang hardcode).
- Unit test: parse JSON đúng schema; filter điều kiện trigger đúng (event Tết không xuất hiện tháng 6); trọng số xác suất hoạt động (test thống kê với seed cố định).

### Task 3 — Simulation test cho Game Engine
- Viết integration test giả lập chạy `process_next_month_usecase` liên tục 200 tháng với các chiến lược bot khác nhau:
    - Bot "không làm gì": phải phá sản hoặc Bad Ending trong khoảng hợp lý, không được sống khỏe mãi.
    - Bot "trả nợ đúng hạn + đầu tư DCA đều": credit score phải tăng dần, net worth tăng theo lãi kép.
- Assert các bất biến (invariants): Stress luôn trong [0,100]; credit score trong [300,850]; tuổi tăng đúng 1/12 mỗi tháng; Net Worth = tổng tài sản − tổng nợ tại mọi thời điểm.
- Kiểm chứng công thức lãi kép và tính lãi vay bằng giá trị tính tay trong test (ví dụ: nợ 100tr lãi 12%/năm, sau 12 tháng trả tối thiểu thì dư nợ phải = X, ghi rõ cách tính trong comment).
- Nếu phát hiện logic hiện có sai hoặc balance vô lý, báo cáo chi tiết trước khi sửa.

### Task 4 — Insight Card System ("Góc nhìn Chuyên gia")
- Entity `InsightCard` (freezed): id, tiêu đề, nội dung bài học, khái niệm kinh tế (vd "Total Cost of Ownership", "Mental Accounting", "Paradox of Thrift"), điều kiện đã mở khóa.
- Nội dung card đặt trong `assets/config/insight_cards_vi.json`.
- Trigger: khi người chơi dính hậu quả từ các bẫy (event có `insightCardId`) hoặc hành vi xấu (trả thẻ tín dụng mức tối thiểu → card "Mental Accounting").
- Lưu danh sách card đã mở khóa vào save game. Cubit expose stream/state để UI hiển thị card khi mở khóa.
- Unit test cho trigger logic.

### Task 5 — UI Skeleton (chỉ bắt đầu khi Task 1-4 xong)
Code trong `gameplay/presentation/pages/` và `widgets/`, kết nối với `GameEngineCubit` qua BlocBuilder/BlocListener. Setup **go_router** cho điều hướng. Thứ tự màn hình:
1. **Main Game Screen:** hiển thị tháng/tuổi hiện tại, Cash, Net Worth, thanh Stress (progress bar đổi màu theo mức), Network score, Credit score, danh sách dòng tiền tháng này (thu/chi), nút "Kết thúc tháng".
2. **Event Dialog:** hiện sự kiện dạng card với các lựa chọn, hiển thị rõ hiệu ứng của từng lựa chọn (hoặc ẩn một phần nếu event là "bẫy").
3. **Monthly Summary:** tổng kết sau End Turn — biến động cash, stress, tài sản.
4. **Insight Card Screen:** giao diện dạng trang sách khi mở khóa bài học.
5. **New Game Screen:** chọn Quốc gia → Bối cảnh (hiện tại chỉ VN - "Thanh niên tỉnh lẻ" khả dụng, các lựa chọn khác hiển thị khóa 🔒).
6. **Win / Game Over Screen:** lý do kết thúc + thống kê cả đời chơi.
- UI ưu tiên đúng và đủ dữ liệu, chưa cần đẹp. Widget test cơ bản cho Main Game Screen (render đúng số liệu từ state mock).

### Task 6 (nếu còn thời gian) — MarketCubit
- Cubit riêng cho thị trường tài sản: danh sách asset có thể mua (cổ phiếu, nhà cho thuê...), giá biến động theo tháng đọc từ config, mua/bán cập nhật GameState qua usecase.

## ĐỊNH DẠNG BÁO CÁO SAU MỖI TASK
- Danh sách file đã tạo/sửa.
- Kết quả `dart analyze` và `flutter test` (số test pass).
- Các quyết định thiết kế đáng chú ý và trade-off.
- Vấn đề phát hiện trong code cũ (nếu có) + đề xuất.