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

### Task 0 — Fix bugs hiện có + Migrate Freezed 3 (BẮT BUỘC làm đầu tiên)

Codebase hiện tại có các bug logic đã được xác định. Sửa từng mục dưới đây, mỗi mục kèm unit test khóa hành vi đúng.

**0.1. Bug lãi suất sai đơn vị 100 lần (`process_loans_usecase.dart`):**
- Code đang tính `principalAmount * (interestRatePerYear / 12)` nhưng factory truyền lãi suất dạng phần trăm (`5.5` nghĩa là 5.5%/năm). Kết quả lãi bị nhân 100 lần.
- Chốt convention: `interestRatePerYear` LUÔN là phần trăm (5.5 = 5.5%/năm). Sửa công thức thành `principalAmount * (interestRatePerYear / 100 / 12)`.
- Thêm assert/validate: `interestRatePerYear >= 0 && interestRatePerYear < 100`.
- Test tính tay BẮT BUỘC (ghi cách tính trong comment): nợ gốc 30,000, lãi 5.5%/năm, trả tối thiểu 300/tháng → sau tháng 1: lãi = 30,000 × 0.055/12 = 137.50; dư nợ mới = 30,000 + 137.50 − 300 = 29,837.50. Chạy tiếp 12 tháng, assert dư nợ cuối ≈ 27,972 (sai số < 1).

**0.2. Bug "nợ ma" — loan trả hết vẫn trừ tiền vĩnh viễn (`process_loans_usecase.dart`):**
- Loan có principal = 0 vẫn nằm trong list và vẫn bị trừ `minimumMonthlyPayment` mỗi tháng.
- Tháng tất toán: nếu (dư nợ + lãi tháng) < min payment thì chỉ trả đúng phần còn nợ, không trừ nguyên min payment.
- Loan sau khi tất toán (dư nợ ≤ 0.01) phải bị loại khỏi `GameState.loans`.
- Test: loan dư nợ 250, lãi 12%/năm, min payment 300 → tháng đó chỉ bị trừ 250 + 2.50 = 252.50, tháng sau list loans rỗng và cash không đổi.

**0.3. Bug ngưỡng phá sản hardcode theo tiền tệ (`game_engine_cubit.dart`):**
- `cash < -10000` đang dùng chung cho cả VND lẫn USD — vô nghĩa (âm 10,000 VND không phải phá sản).
- Thay bằng ngưỡng tương đối: `cash < -(bankruptcyMonthsThreshold × monthlyExpenses)` với `bankruptcyMonthsThreshold` mặc định = 3, đọc được từ scenario config sau này (để dạng hằng số có tên, KHÔNG magic number).

**0.4. Chuyển logic Win/Loss từ Cubit xuống Domain:**
- Tạo `CheckGameStatusUseCase` trong `domain/usecases/`, gắn vào CUỐI pipeline của `ProcessNextMonthUseCase`.
- `ProcessNextMonthUseCase` đổi kiểu trả về từ `Either<Failure, GameState>` sang `Either<Failure, TurnResult>`:
```dart
@freezed
sealed class TurnResult with _$TurnResult {
  const factory TurnResult.continued(GameState state) = TurnContinued;
  const factory TurnResult.won(GameState state) = TurnWon;
  const factory TurnResult.lost(GameState state, GameOverReason reason) = TurnLost;
}
enum GameOverReason { burnout, bankruptcy, debtSpiral, poorAtRetirement }
```
- Cài đủ điều kiện theo GDD: THẮNG khi passive income ≥ monthly expenses; THUA khi stress ≥ 100 (burnout), phá sản (mục 0.3), hoặc tuổi ≥ 65 mà chưa thắng (poorAtRetirement).
- Cubit chỉ còn map `TurnResult` → `GameEngineState`, KHÔNG chứa business rule. Lý do dùng enum thay chuỗi lý do: UI sẽ map enum → chuỗi đã localize (ARB), không hardcode tiếng Anh trong domain.
- Test đủ 4 nhánh của `CheckGameStatusUseCase`.

**0.5. `passiveIncome` chuyển từ field lưu sẵn thành computed getter:**
- Xóa field `passiveIncome` khỏi `GameState`. Thêm getter: `double get passiveIncome => assets.fold(0, (sum, a) => sum + a.monthlyPassiveIncome);`
- Sửa mọi chỗ đang dùng field cũ. Lý do: tránh lệch dữ liệu khi mua/bán asset, và điều kiện Thắng phụ thuộc trực tiếp con số này.

**0.6. Thêm calendar month + flags vào `GameState`:**
- Thêm `@Default(1) int startCalendarMonth` và getter `int get calendarMonth => ((startCalendarMonth - 1 + currentMonth - 1) % 12) + 1;` (cần cho event theo mùa như "Tết Nguyên Đán" tháng 1-2).
- Thêm `@Default({}) Set<String> flags` (cần cho cơ chế bẫy ẩn như `owns_old_car` ở Task 2).
- Test getter calendarMonth với các case biên (start tháng 12, qua năm mới).

**0.7. Migrate cú pháp Freezed 2 → 3 (pubspec đã nâng `freezed: ^3.2.0`):**
- Thêm `abstract` vào mọi class Freezed thường (`Asset`, `GameEvent`, `EventOption`, `GameState`, `Loan`), thêm `sealed` vào mọi union (`GameEngineState`, `TurnResult`).
- Freezed 3 không sinh `when`/`map`/`mapOrNull` mặc định: thay `state.mapOrNull(playing: ...)` trong `GameEngineCubit` bằng Dart 3 pattern matching (`if (state is! GameEnginePlaying) return;` hoặc `switch`).
- Đổi tên các case union từ private (`_Playing`, `_GameOver`...) thành public (`GameEnginePlaying`, `GameEngineGameOver`...) để UI pattern-match được.
- Chạy `dart run build_runner build --delete-conflicting-outputs` sạch lỗi.

**0.8. Thêm serialization cho toàn bộ entity:**
- Thêm `fromJson`/`toJson` (json_serializable, đã có trong pubspec) cho `GameState`, `Asset`, `Loan`, `GameEvent`, `EventOption` — điều kiện tiên quyết cho save/load ở Task 1 và parse config ở Task 2.
- Test round-trip: `GameState.fromJson(state.toJson()) == state` với state có đủ assets, loans, flags.

**0.9. Dọn dẹp:**
- Chuyển class `Failure` từ `process_next_month_usecase.dart` ra `lib/core/error/failure.dart`.
- Bỏ `try/catch` bọc toàn bộ pipeline trong `ProcessNextMonthUseCase` (catch-all nuốt bug lập trình); chỉ giữ Either cho lỗi nghiệp vụ thật.
- Bỏ `emit(GameEngineState.loading())` trong `nextMonth()` (pipeline đồng bộ, emit loading chỉ gây nháy UI).
- Đồng bộ số liệu factory với GDD: nợ sinh viên Mỹ là $50,000 (không phải $30,000).

**Definition of Done cho Task 0:** `dart analyze` 0 lỗi; toàn bộ test pass; test tính tay ở 0.1 và 0.2 có comment giải thích công thức; không còn `mapOrNull`/`when` của Freezed trong codebase.

### Task 1 — Repository interfaces + Persistence (save/load game)
- Tạo interface trong `gameplay/domain/repositories/` (nếu đã tạo trước đó, liệt kê nguyên văn nội dung hiện tại trong plan để review):
  - `GameStateRepository`: `saveGame(GameState)`, `loadGame()`, `hasSavedGame()`, `deleteSave()`.
  - `EventPoolRepository`: `loadEventPool(CountryId, ScenarioId)` — trả về danh sách GameEvent kèm điều kiện trigger (độ tuổi min/max, ngưỡng stress, tháng trong năm, xác suất).
  - `ScenarioConfigRepository`: `loadScenarioConfig(CountryId, ScenarioId)` — trả về thông số khởi đầu (lương, tiền thuê nhà, khoản gửi về quê, nợ ban đầu...).
  - Plan phải ghi rõ signature đầy đủ từng method (kiểu trả về, tham số) — đây là hợp đồng domain ↔ data, deliverable chính của task.
- Implement persistence bằng **hive_ce** (đã có trong pubspec — KHÔNG dùng Isar hay Hive gốc, cả hai đều ngừng bảo trì) trong `gameplay/data/`: tận dụng `toJson`/`fromJson` từ Task 0.8 để lưu entity dưới dạng JSON string trong Hive box, không cần TypeAdapter riêng cho từng entity.
- Implementation tạm cho EventPool/ScenarioConfig (chờ Task 2): đặt tên `InMemory...` (KHÔNG dùng tiền tố `Mock` trong lib/), dữ liệu stub ở mức tối thiểu đủ compile + test, mỗi file có comment `// TODO(task-2): Replace with JSON-based implementation and DELETE this file.`
- Setup DI bằng **get_it + injectable**, tạo `lib/core/di/injection.dart` export `configureDependencies()`:
  - Convention: use case stateless và repository → `@lazySingleton`; Cubit → `@injectable` (factory — mỗi ván chơi một instance mới, KHÔNG singleton kẻo state ván cũ dính sang ván mới). Đăng ký cả `GameEngineCubit`.
  - Tạo `@module` đăng ký `Random` làm `@lazySingleton` — `GenerateEventUseCase` nhận `Random` qua constructor sẽ fail DI nếu thiếu. Giữ điểm inject này để Task 3 thay bằng `Random(seed)` trong simulation test.
- `main.dart`: gọi `WidgetsFlutterBinding.ensureInitialized()` TRƯỚC `await Hive.initFlutter()`, rồi mới `configureDependencies()`.
- Test:
  - Round-trip: save → load ra state giống hệt; load khi chưa có save trả về null/failure đúng thiết kế. Test Hive dùng thư mục temp (`Directory.systemTemp.createTemp`), tearDown gọi `Hive.deleteBoxFromDisk` + `Hive.close()`.
  - Smoke test DI: `configureDependencies()` rồi resolve `ProcessNextMonthUseCase`, `GameEngineCubit`, `GameStateRepository` từ container không throw.

### Task 2 — Event Pool & Scenario Config dạng JSON
- **Bước 0 (BẮT BUỘC, làm đầu tiên):** XÓA `InMemoryEventPoolRepository` và `InMemoryScenarioConfigRepository` (placeholder từ Task 1) sau khi implementation JSON hoạt động. Cuối task, chạy `grep -ri "InMemory\|TODO(task-2)" lib/` phải không còn kết quả. TUYỆT ĐỐI không để 2 implementation cùng tồn tại — DI chỉ được trỏ vào bản JSON.
- **Cảnh báo async DI:** nếu repository đọc asset JSON dùng `@preResolve` hoặc bất kỳ dependency async nào, injectable sẽ đổi `init()` thành `Future` — khi đó BẮT BUỘC đổi `configureDependencies()` trong `lib/core/di/injection.dart` thành `Future<void>` và thêm `await` tại `main.dart` + toàn bộ test setUp (kể cả DI smoke test). Quên `await` là lỗi im lặng: app chạy nhưng DI chưa xong, crash lúc resolve. Sau khi chạy build_runner, kiểm tra kiểu trả về của `init()` trong `injection.config.dart` và xác nhận mọi call-site khớp.
- **Mở rộng `ScenarioConfig`** (đã ghi nhận ở Task 1 là bản tối thiểu): thêm `monthlyExpenses`, `@Default([]) List<Loan> initialLoans`, `startAgeInMonths`, `startCalendarMonth`, `initialCreditScore`, `housingLevel`, `country`, `currency`, `bankruptcyMonthsThreshold`. Refactor `GameStateFactory` thành hàm build `GameState` từ `ScenarioConfig` (hoặc thay thế hẳn factory), số liệu chuyển hết vào JSON.
- Tách cấu trúc asset theo nguyên tắc **logic/số liệu tách khỏi text hiển thị** (chuẩn bị cho đa ngôn ngữ):
```
assets/config/
  scenarios/vn_provincial.json   # số liệu, xác suất, hiệu ứng, textKey — KHÔNG chứa text hiển thị
  i18n/events_vi.json            # map textKey -> title/description/label tiếng Việt
```
- Event/option trong scenario JSON tham chiếu text qua `textKey` (ví dụ `"textKey": "event_tet_holiday"`). `EventPoolRepository` ghép scenario + file i18n theo locale khi load. Lý do: thêm ngôn ngữ mới hoặc bán bản mở rộng Mỹ/Nhật chỉ cần thêm file JSON, không đụng logic.
- Nội dung `vn_provincial.json` cho bối cảnh **"Thanh niên tỉnh lẻ lên phố"** (bản miễn phí):
  - Thông số khởi đầu: tuổi 22, lương thấp, tiền thuê trọ hàng tháng, khoản "Trách nhiệm gia đình" tự động trừ hàng tháng gửi về quê, và ngưỡng phá sản `bankruptcyMonthsThreshold` (đọc từ config thay cho hằng số mặc định — xem Task 0.3).
  - Event pool tối thiểu 15 sự kiện, trong đó BẮT BUỘC có:
    - "Tết Nguyên Đán" (chỉ trigger tháng 1 hoặc 2 theo `calendarMonth`): cộng Thưởng Tết, trừ mạnh chi phí mua sắm + lì xì.
    - "Đám cưới bạn thân" (tốn tiền phong bì, tăng Network).
    - Bẫy "Mua xe cũ giá rẻ": chọn xe mới trả góp vs xe cũ trả đứt; nếu chọn xe cũ, set flag ngầm tăng xác suất event "Xe hỏng giữa đường" lên 30% (tốn tiền sửa, trừ lương do đi trễ, tăng Stress).
    - Bẫy "Tiết kiệm thái quá": cắt hết chi tiêu giao lưu → Network về 0, đóng băng thăng chức, tăng xác suất event "Đau dạ dày" viện phí lớn.
- Schema JSON tự thiết kế nhưng phải hỗ trợ: điều kiện trigger (tuổi, stress, `calendarMonth`, flag), trọng số xác suất, nhiều lựa chọn cho người chơi, hiệu ứng lên cash/stress/network/credit/flags (kể cả thêm Loan/Asset — xem `EventEffect`), và `insightCardId` (tham chiếu bài học, dùng ở Task 4).
- Việc mở rộng kiểu trả về của `EventPoolRepository.loadEventPool` để mang điều kiện trigger (thêm field vào `GameEvent` hoặc bọc trong `EventDefinition`) đã được ghi nhận là thay đổi có chủ đích từ Task 1 — nêu rõ lựa chọn trong plan.
- Refactor `generate_event_usecase` để đọc từ `EventPoolRepository` thay vì nguồn hiện tại (nếu đang hardcode).
- **Convention nhắc lại:** toàn bộ comment trong code viết bằng TIẾNG ANH (đã có comment tiếng Việt lọt vào ở các task trước — không lặp lại).
- Unit test: parse JSON đúng schema; ghép textKey → text đúng locale; filter điều kiện trigger đúng (event Tết không xuất hiện khi `calendarMonth` = 6); trọng số xác suất hoạt động (test thống kê với seed cố định qua `Random` đã đăng ký trong DI module).

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