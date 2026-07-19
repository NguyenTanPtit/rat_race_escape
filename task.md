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
7. Nếu phát hiện code hiện có mâu thuẫn với yêu cầu, dừng lại báo cáo và đề xuất phương án, không tự ý refactor lớn. Tương tự với expected value trong test: nếu spec ghi một con số mà code cho kết quả khác, DỪNG và báo cáo mâu thuẫn — không tự điều chỉnh expected cho khớp code, không mềm hóa assertion.
8. KHÔNG để lại comment dạng độc thoại/tự vấn trong code ("Wait...", "Let's assume...", "for now..."); mọi câu hỏi thiết kế chưa chốt đưa vào mục Open Questions của plan. Toàn bộ comment viết bằng TIẾNG ANH. Comment mô tả hành vi phải cập nhật cùng lúc với hành vi — comment lỗi thời tệ hơn không có comment.
9. Mọi walkthrough phải có: timestamp của lần chạy test, raw log dán kèm (không phải đường dẫn máy cục bộ), và số liệu lấy TRỰC TIẾP từ lần chạy đó — không chép từ báo cáo cũ. Raw log BẮT BUỘC sinh bằng redirect (`flutter test --reporter expanded > run.log 2>&1`) và dán nguyên văn nội dung file — TUYỆT ĐỐI CẤM gõ lại, tái dựng, hay "format lại cho đẹp" log bằng tay/bằng trí nhớ: một log tái dựng là bằng chứng giả, tệ hơn không có log. Khai [MODIFY] cho file nào thì file đó phải tồn tại (kiểm tra trước khi khai).

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

### Task 2.5 — Apply Event Option (Phase 3: Player Action của Core Loop)
Đây là mảnh còn thiếu của vòng lặp gameplay: khi người chơi chọn một option của event, hiệu ứng phải được áp vào GameState trong domain layer — KHÔNG áp trong Cubit hay UI.

- **[NEW]** `domain/usecases/apply_event_option_usecase.dart`:
  - Input: `GameState` hiện tại + `EventOption` được chọn (hoặc eventId + optionId, tự resolve qua EventPoolRepository — nêu lựa chọn trong plan).
  - Áp toàn bộ `EventEffect` vào state: cash, stress (clamp 0-100), network, credit (clamp 300-850), thêm `addedLoans`/`addedAssets` vào inventory, cập nhật flags (added/removed), áp `salaryDelta`/`monthlyExpensesDelta` vào baseSalary/monthlyExpenses, và các hiệu ứng tỷ lệ bên dưới.
  - Clear `currentEventId` sau khi áp (event đã được xử lý).
  - Nếu effect có `insightCardId`: ghi nhận card mở khóa (tạm thời thêm vào một field/set trong GameState, ví dụ `unlockedInsightCardIds` — Task 4 sẽ xây hệ thống đầy đủ trên nền này).
  - Validate: option phải thuộc event đang active (`currentEventId`), nếu không → trả `Left(Failure)` — chặn UI bug hoặc gọi sai áp effect của event khác.
- **[MODIFY]** `EventEffect` — thêm hiệu ứng TỶ LỆ (proportional effects):
  - Lý do: game chạy 40+ năm đời người, mọi con số tuyệt đối trong event đều trượt giá khi lương người chơi tăng gấp 3-4 lần ("thưởng Tết 15tr" hay "đám cưới 500k" vô nghĩa ở tuổi 45). Hiệu ứng tỷ lệ tự cân bằng theo tiến trình.
  - Thêm 2 field (default 0.0): `cashBySalaryMultiplier` (cash thay đổi = hệ số × baseSalary hiện tại; dương là thưởng, âm là chi) và `cashByOutflowMultiplier` (cash thay đổi = hệ số × totalMonthlyOutflow hiện tại — dùng cho chi phí sinh hoạt đột biến).
  - Thứ tự áp trong usecase: tính phần tỷ lệ TRƯỚC dựa trên baseSalary/totalMonthlyOutflow tại thời điểm áp, cộng dồn với `cash` tuyệt đối, rồi mới áp `salaryDelta` (để "thưởng theo lương" không ăn theo mức lương vừa tăng trong cùng option).
  - Cập nhật event "Tết Nguyên Đán" trong `vn_provincial.json` theo đúng GDD (nhận Thưởng Tết + trừ mạnh chi tiêu): `cashBySalaryMultiplier: 1.0` (lương tháng 13) kết hợp chi tiêu Tết âm — ví dụ option "Ăn Tết lớn" (`cashBySalaryMultiplier: 1.0, cash: -12000000, network: +5, stress: -10`) vs "Ăn Tết tiết kiệm" (`cashBySalaryMultiplier: 1.0, cash: -5000000, network: -3, stress: +5`). Con số cụ thể được tune ở Task 3.
- **[MODIFY]** `GameEngineCubit`: thêm method `chooseEventOption(...)` gọi usecase trên, emit state mới. Sau khi áp option, KHÔNG tự động chạy next month — người chơi vẫn ở Phase 3, có thể tiếp tục mua bán tài sản trước khi bấm End Turn.
- Sau khi áp effect, chạy `CheckGameStatusUseCase` ngay (không đợi End Turn): một lựa chọn tồi có thể đẩy stress lên 100 hoặc cash xuyên ngưỡng phá sản giữa tháng — game over phải kích hoạt tức thì, nếu không người chơi ở trạng thái "đã chết nhưng vẫn đi lại được".
- Unit test:
  - Áp đủ từng loại effect (cash, stress có clamp, loan mới xuất hiện trong list, flag added/removed, salaryDelta).
  - Hiệu ứng tỷ lệ — test tính tay: baseSalary 15tr, option có `cashBySalaryMultiplier: 1.0, cash: -12tr` → cash tăng đúng +3tr. Test thứ tự áp: option có cả `cashBySalaryMultiplier: 1.0` và `salaryDelta: +2tr` với lương 15tr → phần thưởng tính trên 15tr (không phải 17tr), lương sau đó mới thành 17tr.
  - Option không thuộc event đang active → Left(Failure).
  - Effect đẩy stress lên 100 → kết quả trả về phải là lost(burnout) ngay trong lượt áp.
  - `currentEventId` bị clear sau khi áp thành công.

### Task 3 — Simulation test cho Game Engine
- Viết integration test giả lập chạy `process_next_month_usecase` liên tục 200 tháng với các chiến lược bot khác nhau. Khi event xuất hiện (`currentEventId != null`), bot dùng `ApplyEventOptionUseCase` (Task 2.5) để chọn option theo chiến lược của nó — vòng lặp mô phỏng phải đi qua đủ 4 phase như người chơi thật:
  - Bot "không làm gì": phải phá sản hoặc Bad Ending trong khoảng hợp lý, không được sống khỏe mãi.
  - Bot "trả nợ đúng hạn + đầu tư DCA đều": credit score phải tăng dần, net worth tăng theo lãi kép.
- Assert các bất biến (invariants): Stress luôn trong [0,100]; credit score trong [300,850]; tuổi tăng đúng 1/12 mỗi tháng; Net Worth = tổng tài sản − tổng nợ tại mọi thời điểm.
- Kiểm chứng công thức lãi kép và tính lãi vay bằng giá trị tính tay trong test (ví dụ: nợ 100tr lãi 12%/năm, sau 12 tháng trả tối thiểu thì dư nợ phải = X, ghi rõ cách tính trong comment).
- Nếu phát hiện logic hiện có sai hoặc balance vô lý, báo cáo chi tiết trước khi sửa.

### Task 3.5 — Van xả Stress + Tune Balance (dựa trên dữ liệu simulation)
Bối cảnh từ kết quả Task 3: stress hiện là "bánh cóc một chiều" — không có cơ chế giảm nào ngoài vài option event hiếm. Simulation chứng minh Do-Nothing bot chết vì burnout ở tuổi 30 dù không làm gì; nghĩa là mọi người chơi đủ lâu đều đột quỵ. GDD mục 4 ghi rõ "Stress... Giảm khi chi tiêu giải trí" — cơ chế này chưa từng được cài. Task này cài nó và dùng chính simulation Task 3 để tune.

**3.5.1 — [NEW] `domain/usecases/spend_on_leisure_usecase.dart`:**
- Input: `GameState` + số tiền chi (double). Thuộc Phase 3 (Player Action), gọi được nhiều lần trước End Turn nhưng tổng stress giảm mỗi tháng có TRẦN.
- Thang quy đổi đặt trong ScenarioConfig (KHÔNG hardcode — mỗi quốc gia chi phí giải trí khác nhau): `leisureCostPerStressPoint` (mặc định VN: 100000 = 100k/1 điểm stress) và `maxLeisureStressReliefPerMonth` (mặc định 20).
- GameState cần counter `leisureReliefUsedThisMonth` (reset về 0 trong ProcessNextMonthUseCase khi sang tháng) để enforce trần.
- Validate: amount > 0 và ≤ cash hiện có → nếu vi phạm trả `Left(Failure)`. Stress giảm = min(amount / leisureCostPerStressPoint, trần còn lại), làm tròn xuống; trừ cash đúng phần stress thực giảm (không "nuốt" tiền thừa — nếu trần còn 5 điểm mà người chơi đưa 2tr, chỉ trừ 500k).
- Sau khi áp, chạy `CheckGameStatusUseCase` (nhất quán với ApplyEventOptionUseCase — chi tiền có thể xuyên ngưỡng phá sản).
- `GameEngineCubit`: thêm method `spendOnLeisure(double amount)`, xử lý Left như chooseEventOption (giữ playing state, không emit error).
- Unit test: quy đổi đúng thang; trần tháng enforce qua nhiều lần gọi; tiền thừa không bị nuốt; amount > cash → Left; counter reset khi sang tháng; chi tiền xuyên ngưỡng phá sản → lost(bankruptcy) ngay.

**3.5.2 — Cập nhật DCA bot dùng van xả:**
- Chiến lược: khi `stress > 60` và cash > quỹ khẩn cấp, chi tiền xả về ~40 (qua SpendOnLeisureUseCase thật, không copyWith — đây là usecase domain thật, khác Phase 3 mô phỏng).
- Kỳ vọng cập nhật: DCA bot thắng ổn định hơn, KHÔNG còn phụ thuộc may mắn né option tăng stress.

**3.5.3 — Tune balance bằng simulation (thứ tự BẮT BUỘC: cài 3.5.1-3.5.2 xong mới tune):**
- Sửa bẫy "Mua xe" về thang GDD mục 10.1 (nguyên văn: trả góp 3tr/tháng vs trả đứt 15tr): option trả góp `principalAmount ~130tr, minimumMonthlyPayment 3000000, monthlyExpensesDelta 1500000`; option trả đứt xe cũ `cash: -20000000` + flag hỏng vặt như hiện có. Bẫy phải "đau nhưng sống được", không phải án tử (bản 500tr/10tr/tháng hiện tại là án tử tuyệt đối trên lương 15tr).
- Hạ `baseSalary` trong vn_provincial.json xuống 11000000 (đã chốt sau vòng tune đầu: mức 9500000 âm 1tr/tháng là impossible khi chưa có side-job/market — cả 3 seed bot chết tuổi 23; 11tr cho dư +0,5tr/tháng: sống được nhưng nghẹt thở, thăng chức là cột sống của đường thắng). Sau khi hạ, chạy lại simulation cả 2 bot với 3 seed (42, 7, 2026) và BÁO CÁO: Do-Nothing bot phải chật vật/thua rõ rệt; DCA bot vẫn phải có đường thắng trước 65 tuổi ở ít nhất seed 42. Nếu DCA bot hết đường thắng → báo cáo và đề xuất nút chỉnh (lương khởi điểm, mức tăng lương thăng chức, lợi suất tài sản), KHÔNG tự quyết.
- Quy tắc không đổi: mọi assertion fail do balance → báo cáo, không tự sửa assertion.

### Task 4 — Insight Card System ("Góc nhìn Chuyên gia")
Nền móng đã có sẵn từ Task 2.5: `EventEffect.insightCardId` và `GameState.unlockedInsightCardIds` (đã có test round-trip JSON). `ApplyEventOptionUseCase` đã tự ghi card vào set khi effect có insightCardId. Task này xây phần nội dung + trigger hành vi + hiển thị state.

- Entity `InsightCard` (freezed): id, conceptKey (vd "total_cost_of_ownership", "mental_accounting", "paradox_of_thrift"), và text đã resolve (title, nội dung bài học). Theo pattern i18n đã chốt ở Task 2: text nằm trong `assets/config/i18n/insight_cards_vi.json`, domain entity chỉ giữ text đã resolve, repository (`InsightCardRepository`) ghép khi load.
- **Nối vào event thật (BẮT BUỘC):** điền `insightCardId` vào các bẫy hiện có trong `vn_provincial.json` — tối thiểu: option mua xe (cả trả góp lẫn xe cũ) → card "Total Cost of Ownership"; `e_over_saving` option cắt giao lưu → "Paradox of Thrift"; `e_scam` → card về lừa đảo tài chính. Mở rộng test referential integrity: mọi `insightCardId` trong scenario JSON phải tồn tại trong file card i18n.
- **Trigger hành vi** (không gắn event): trả thẻ tín dụng mức tối thiểu N tháng liên tiếp → card "Mental Accounting". Kiến trúc đề xuất: usecase kiểm tra hành vi chạy trong pipeline (sau ProcessLoans), đọc/ghi counter trong GameState; agent nêu thiết kế cụ thể trong plan trước khi code.
- Card đã mở khóa lưu theo save game (đã tự động qua unlockedInsightCardIds). Cubit expose để UI biết có card MỚI mở trong lượt này (phân biệt "mới mở" vs "đã mở từ trước" — UI chỉ popup card mới).
- Unit test cho trigger logic (cả event-based lẫn behavior-based) + referential integrity mở rộng.
- Lưu ý cho agent: nội dung tiếng Việt của card sẽ do người dùng duyệt trực tiếp về mặt chữ nghĩa — viết thật, có chiều sâu, gắn với tình huống người chơi vừa trải, không viết văn mẫu định nghĩa khô khan.

### Task 5 — UI (chỉ bắt đầu khi Task 1-4 + 3.5 xong)
Phong cách thị giác đã chốt theo mockup của người dùng: neo-brutalist ấm — viền đen dày (~3px) hơi bất quy tắc, đổ bóng lệch cứng, bo góc mỗi góc một khác, nền kem/mint. Màu chủ đạo `#22C55E`, màu text `#161D16`, font **Nunito Sans** (qua google_fonts đã có trong pubspec). API Cubit hiện có: `startGame`, `nextMonth`, `chooseEventOption(eventId, optionId)`, `spendOnLeisure(amount)`; state union: `initial / loading / playing(state, newlyUnlockedInsightCardIds) / won(finalState, newly...) / gameOver(GameOverReason, finalState, newly...) / error`.

**5.0 — Design System Foundation (làm TRƯỚC mọi component/màn hình):**
- `lib/core/theme/`: `app_colors.dart` (primary #22C55E, ink #161D16, cardFill #FFFFFF, nền kem/mint, các màu trạng thái stress thấp/trung/cao), `app_tokens.dart` (cardRadius 32, borderWidth 2, shadowOffset Offset(4,4)), `app_spacing.dart`, `app_text_styles.dart` (Nunito Sans, thang chữ từ số tiền lớn tới caption), `app_theme.dart` (ThemeData tổng).
- **Spec bóng/viền đã chốt từ Figma của người dùng** — áp cho MỌI card/nút: fill trắng, viền `Border.all(color: ink, width: 2)` (Border của Flutter vẽ vào trong, khớp stroke "Inside" của Figma), bo góc 32, và bóng CỨNG: `BoxShadow(offset: Offset(4,4), blurRadius: 0, spreadRadius: 0)`. Màu bóng: render CẢ HAI biến thể #000000 và #161D16 trong Component Gallery để người dùng chọn — mặc định tạm #161D16.
- Setup l10n cùng lúc: `l10n.yaml`, `lib/l10n/app_vi.arb`, `flutter: generate: true`. MỌI chuỗi UI qua AppLocalizations từ dòng đầu tiên — không hardcode rồi dọn sau.
- Formatter tiền tệ: `lib/core/format/money_format.dart` — format kiểu Việt Nam (`12,5tr ₫`, `1,64 tỷ ₫`), có unit test với các mốc (nghìn/triệu/tỷ/âm). Đơn vị stress hiển thị theo ĐIỂM 0-100 khớp engine, không dùng %.

**5.1 — Core Components (mỗi component có widget test):**
- `GameCard` v1: Container + BoxDecoration theo spec 5.0. QUAN TRỌNG — API nhận `child` + `fill`, đóng gói toàn bộ decoration bên trong, để khi nâng cấp lên painter viền méo (bên dưới) thì KHÔNG màn hình nào phải sửa.
- **Layout với bóng cứng:** bóng vẽ ngoài biên widget → mọi vùng chứa GameCard/GameButton phải có padding phải/dưới ≥ 4px (bằng shadowOffset) và KHÔNG bọc trong ClipRRect/clipBehavior, nếu không bóng bị cắt cụt — lỗi kinh điển của style này.
- `GameButton`: hiệu ứng nhấn = hoán đổi bóng lấy dịch chuyển — khi pressed: `Matrix4.translationValues(4, 4, 0)` + boxShadow rỗng, AnimatedContainer ~80ms; nút "lún" đúng vào vị trí bóng cũ. Có trạng thái disabled.
- `SketchyBorderPainter` (CustomPainter, nâng cấp GameCard v2): vẽ rounded-rect với jitter nhẹ các điểm điều khiển (~1-2px) và bán kính mỗi góc khác nhau quanh mốc 32, jitter SEED theo widget (hash từ key/size) để viền bất quy tắc nhưng ổn định qua rebuild. Painter vẽ cả fill + viền + BÓNG bằng cùng một path dịch (4,4) — bóng phải méo theo đúng hình viền méo, không dùng bóng chữ nhật thẳng dưới viền cong. KHÔNG dùng ảnh cho khung viền; ảnh chỉ dành cho nhân vật/background/icon minh họa.
- `StatBar` (thanh stress/network với emoji, đổi màu theo ngưỡng), `MoneyDisplay` (số tiền lớn + chip cashflow ↑↓), `BottomNav` (Assets/Invest/Bank/Upgrades — các tab thuộc Task 6 hiển thị khóa 🔒, không chết cứng).
- Tạo một trang Component Gallery (route dev-only) bày mọi component ở mọi trạng thái (kể cả 2 biến thể màu bóng, GameCard v1 vs v2) — vừa là công cụ review bằng mắt, vừa là nơi chụp screenshot nghiệm thu.
- **CHECKPOINT bắt buộc: DỪNG sau 5.1, nộp screenshot Component Gallery cho người dùng duyệt chữ ký thị giác (viền, bóng, độ méo, màu bóng) TRƯỚC KHI ghép màn hình ở 5.2.** Sửa một painter rẻ hơn sửa năm màn hình.

**5.2 — Screens (ghép từ components, thứ tự sau):**
- **Component bổ sung từ Figma người dùng — `BottomNav` (spec chính thức, thay bản tạm 5.1):** cao **85**, fill **#F3FCEF** (mint rất nhạt — khai token `AppColors.navFill`, KHÔNG dùng cardFill trắng), viền ink **2px ở 3 cạnh trái/phải/trên, cạnh DƯỚI = 0** (nav dán đáy màn hình — dùng `Border(top:…, left:…, right:…)`, không `Border.all`), bo góc **chỉ 2 góc trên** (Figma radius "Mixed" → `BorderRadius.vertical(top: Radius.circular(24))`). Bóng cứng **NGƯỢC HƯỚNG**: `offset (0, -4)`, blur 0, màu #000000 — hắt LÊN TRÊN vì nav nằm đáy (khai token riêng `AppTokens.shadowOffsetUp`). Padding ngang 24, item dàn bằng Row spaceAround, chừa khoảng trống giữa cho EndTurnButton docked đè lên (không cần khoét notch — theo mockup nút đè trực tiếp). Item: icon + label, xám nhạt khi khóa/inactive, ink khi active. Widget test: render 4 item, đúng fill/viền/bo góc.
- **Component bổ sung từ Figma người dùng — `EndTurnButton` (nút Play tròn):** kích thước 80×80, tròn tuyệt đối (radius 9999 → dùng `shape: BoxShape.circle`), fill `AppColors.primary` (#22C55E), viền `Border.all(ink, 2)` (stroke Inside), bóng cứng RIÊNG của nút này: `offset (4, 6)`, blur 0, spread 0, màu **#004B1E** (green đậm — KHÔNG dùng màu bóng ink chung; khai token riêng, vd `AppColors.shadowOnPrimary`). Icon Play màu ink, căn giữa quang học (dịch phải ~2-3px vì tam giác lệch trọng tâm). Trạng thái nhấn: translate (4, 6) + bỏ bóng, AnimatedContainer ~80ms (cùng cơ chế GameButton nhưng offset dọc sâu hơn). Vị trí: floating docked giữa, đè lên BottomNav (Scaffold `floatingActionButtonLocation: centerDocked`). Đây là nút bấm nhiều nhất game — thêm widget test riêng (render, onPressed, disabled khi state không phải playing).
1. **Main Game Screen** (theo mockup): header Month/Age, khu nhân vật (placeholder ảnh tĩnh trước — thay đổi theo housingLevel/stress là backlog), MoneyDisplay + cashflow chip, hàng 3 StatBar (stress/network/credit), event card inline khi `currentEventId != null` với các option, nút Play = End Turn. Danh sách dòng tiền tháng hiển thị TÁCH DÒNG: lương, chi sinh hoạt, tiền thuê trọ, "Gửi về quê" (familySupportExpense — người chơi phải NHÌN THẤY gánh nặng này), trả nợ. Nút "Giải trí xả stress" (dialog chọn mức chi, gọi spendOnLeisure, hiển thị trần còn lại từ leisureReliefUsedThisMonth).
2. **Monthly Summary** — tổng kết sau End Turn: biến động cash, stress, tài sản.
3. **Insight Card popup + thư viện** — popup khi `newlyUnlockedInsightCardIds` không rỗng; thư viện xem lại card cũ.
4. **New Game Screen** — chọn Quốc gia → Bối cảnh (chỉ VN khả dụng, còn lại khóa 🔒); nút "Chơi tiếp" nếu `hasSavedGame()`.
5. **Win / Game Over Screen** — hai màn RIÊNG (state won vs gameOver). Game Over map `GameOverReason` enum → chuỗi ARB, mỗi reason một thông điệp bài học riêng (KHÔNG hardcode chuỗi trong Cubit/domain — quyết định Task 0.4). Kèm thống kê cả đời chơi.
- Lưu ý hiển thị effect option: engine có hiệu ứng tỷ lệ (cashBySalaryMultiplier) — UI phải hiển thị số tiền ĐÃ TÍNH theo state hiện tại (ví dụ "Thưởng Tết +11tr"), không hiển thị hệ số thô.
- Widget test: Main Game Screen render đúng số liệu từ state mock; Game Over Screen map đủ 4 GameOverReason ra text.

**Nghiệm thu Task 5 (bổ sung Nguyên tắc 9 cho UI):** walkthrough phải kèm SCREENSHOT thật của từng màn (Component Gallery + 5 màn) chạy trên simulator/thiết bị — với UI, screenshot là bằng chứng bắt buộc bên cạnh log test.

### Task 6 — Market & Hành động Phase 3 (mua/bán tài sản, trả nợ, cày cuốc)
Bối cảnh: simulation Task 3/3.5 đang mô phỏng các hành động này bằng `copyWith` trong test (đánh dấu `TODO(task-6)`). Task này biến chúng thành usecase domain thật và bổ sung các cơ chế còn thiếu mà dữ liệu simulation đã chỉ ra.

**6.1 — Usecases Phase 3 (Player Action):**
- `BuyAssetUseCase(GameState, assetListing, amount)`: trừ cash, thêm Asset. Validate đủ tiền.
- `SellAssetUseCase(GameState, assetId)`: bán tài sản theo giá thị trường hiện tại, cộng cash, xóa khỏi inventory. Đây là cơ chế "bán cắt lỗ cứu thanh khoản" mà simulation đã chứng minh là thiếu (DCA bot từng phá sản với 800tr tài sản trên giấy vì không bán được).
- `PayDebtUseCase(GameState, loanId, amount)`: trả thêm nợ gốc ngoài mức tối thiểu. Validate amount ≤ cash và ≤ dư nợ. NGHĨA VỤ từ Task 4: khi trả thêm cho khoản creditCard, reset `consecutiveMinimumCreditCardPayments` về 0 (counter của trigger Mental Accounting) — kèm unit test cho hành vi reset này.
- `WorkSideJobUseCase(GameState)` — cơ chế "Cày cuốc" (GDD GĐ1 Grind): +cash, +stress, giới hạn số lần/tháng. Thông số trong ScenarioConfig (VD VN: +2.500.000 cash, +8 stress, tối đa 2 lần/tháng — tune bằng simulation). Đây là đòn bẩy thu nhập chủ động đầu tiên của người chơi, điều kiện tiên quyết để mở lại chế độ khó (xem 6.4).
- Tất cả usecase trên: chạy `CheckGameStatusUseCase` sau khi áp (nhất quán Task 2.5/3.5); mọi tham số balance nằm trong config, không hardcode.
- Sau khi có usecases thật: cập nhật simulation test thay các khối `TODO(task-6)` copyWith bằng usecase thật; DCA bot học thêm chiến lược "bán cắt lỗ khi cash < 0" và "cày cuốc khi cash thấp + stress cho phép". Chạy lại 3 seed, báo cáo before/after.

**6.2 — MarketCubit + biến động giá:**
- Cubit riêng cho thị trường: danh sách asset mua được (cổ phiếu, chứng chỉ quỹ, nhà cho thuê...) đọc từ config, giá biến động theo tháng (đơn giản: random walk theo seed + chu kỳ kinh tế thô sơ; tinh vi hóa để sau). `Asset.baseValue` cập nhật theo giá thị trường mỗi tháng trong pipeline.
- Lưu ý bất biến: khi giá tài sản biến động, netWorth thay đổi là ĐÚNG (không còn bất biến hoán đổi như khi mua/bán) — cập nhật assert trong simulation cho phù hợp: bất biến hoán đổi chỉ áp tại thời điểm giao dịch với giá hiện hành.

**6.5 — Auto-Advance ("Tua nhanh") + Tết Recap — chữa vấn đề 80% lượt là bấm chay:**
Bối cảnh: dữ liệu simulation cho thấy ~60 event / 290 tháng — người chơi bấm End Turn chay hàng trăm lần. Giải pháp: giữ tick tháng (KHÔNG đổi sang năm — phá balance + mất bài học sống-theo-tháng), thêm chế độ thời gian tự chảy đến điểm cần quyết định.

- **Cubit `autoAdvance()`**: vòng lặp gọi pipeline nextMonth với nhịp ~3-4 tháng/giây (Timer/Stream, có `stopAutoAdvance()`), emit từng state để UI render số nhảy. DỪNG khi chạm bất kỳ điều kiện nào trong danh sách stop-conditions — thiết kế dạng danh sách kiểm tra được mở rộng (List<bool Function(oldState, newState)>), KHÔNG if-else cứng, vì 6.2 sẽ thêm điều kiện thị trường:
  1. Có event (`currentEventId != null`)
  2. Insight card mới mở
  3. `won` / `gameOver`
  4. Stress vượt 75 (thông báo "cơ thể bạn lên tiếng")
  5. Tết (calendarMonth == 1) — mở Yearly Recap
  6. **Milestone người dùng đặt trước** (tùy chọn khi bật tua): cash/netWorth đạt X, hoặc tuổi đạt Y
  7. **Đột biến dòng tiền**: |cashflow tháng này − tháng trước| > 30% → dừng kèm thông báo lý do
- **Auto-save theo lô**: trong chế độ tua, KHÔNG saveGame mỗi tick — chỉ save tại điểm dừng (giữ nguyên save-mỗi-lượt ở chế độ bấm tay). Cubit test cho hành vi này.
- **Monthly Summary đổi hành vi**: khi tua, không popup từng tháng — gộp thành một bản tại điểm dừng ("N tháng qua: cash ±X, stress ±Y, netWorth ±Z"). MonthlySummaryDelta cộng dồn trong vòng lặp.
- **Lịch sử session cho chart/recap — quyết định kiến trúc**: buffer `List<(ageInMonths, netWorth, cashIn, cashOut, eventId?)>` sống TRONG CUBIT (session-only), KHÔNG thêm vào GameState (save không phình, schema Hive không đổi). Chấp nhận: load game giữa năm → recap năm đó tính từ lúc quay lại (ghi chú trên UI).
- **Yearly Recap (màn Tết)**: tổng thu vs tổng chi năm qua; top 3 event ảnh hưởng tài chính mạnh nhất (từ buffer, xếp theo |delta cash|); biểu đồ đường netWorth 12 tháng (CustomPaint đơn giản, style ink 2px, nhất quán design system). Nút "Ăn Tết tiếp" đóng recap rồi event Tết hiện như thường.
- **UI — Hold-to-Fast-Forward (KHÔNG thêm nút mới)**: tích hợp vào chính EndTurnButton: tap = 1 tháng; **nhấn giữ = tua** (icon ▶ đổi ⏩, vòng glow xoay quanh nút); thả tay = dừng ngay. Đang tua: mọi nút hành động Phase 3 khóa. Ergonomics tự giải quyết nhờ stop Tết mỗi 12 tháng (giữ liên tục tối đa ~3-4s); Recap có nút "⏩ Tua tiếp năm sau" để chuỗi năm liền mạch.
- **Ngữ nghĩa CROSSING cho mọi ngưỡng (BẮT BUỘC)**: stop-condition stress là *vượt qua mốc* (old < 75 && new >= 75), KHÔNG phải mức tuyệt đối — nếu không, tua ở stress > 75 sẽ bị ngắt mỗi tick, vô dụng vĩnh viễn. Thêm mốc thứ hai crossing 90. Đột biến dòng tiền so tháng liền kề nên tự nhiên là crossing.
- **Phanh stress ("Brake")**: khi crossing 75/90, TỰ NGẮT tua dù tay còn giữ + haptic một nhịp (HapticFeedback.mediumImpact) + warning banner riêng ("Cơ thể bạn đang cạn kiệt năng lượng...") — KHÔNG dùng hệ thống Insight Card cho cảnh báo (card là bộ sưu tập giáo dục có persist, không phải toast). StatBar stress nhấp nháy đỏ khi > 75.
- **Chống "mù số" khi tua**: khu event (trống, hiện chữ mờ "Mọi thứ đang bình yên...") thành vùng floating text: mỗi tháng tua bay MỘT con số ròng duy nhất (net cashflow: xanh bay lên / đỏ rơi xuống) — KHÔNG bay từng dòng chi tiết ở nhịp 4 tháng/giây (mưa chữ không đọc nổi); bản chi tiết thuộc chế độ bấm tay.
- **Tick test được**: nhịp tua inject qua tham số Duration (hoặc chạy dưới fakeAsync) — cubit test không được phụ thuộc Timer thật.
- Test: cubit test cho từng stop-condition (dựng state chạm điều kiện → vòng lặp dừng đúng tháng), test ngữ nghĩa crossing (tua tiếp được khi stress đã > 75 và không tăng qua mốc mới), test save-theo-lô, test summary cộng dồn; widget test Recap render đủ 3 khối.
- Backlog ghi kèm (KHÔNG làm trong 6.5): stop-condition "thị trường biến động mạnh / cơ hội bắt đáy" (cần giá động của 6.2); "dự đoán năm tới" (cần 6.2); hệ thống Badge/thành tích (persist riêng); audio subsystem (tiếng "Ting!" khi phanh); avatar già theo tuổi + đồ vật trong phòng nâng cấp theo tài sản (sprite-heavy — đợt polish nghệ thuật cuối).

**6.3 — Backlog từ simulation (làm nếu còn thời gian):**
- `cooldownMonths` cho EventTrigger (thay giải pháp tạm Tết targetCalendarMonths [1]; khôi phục tinh thần "tháng 1 HOẶC 2" của GDD).
- Chạy simulation ~20 seed, thống kê phân phối tuổi thắng/thua làm "bản đồ độ khó" chính thức của scenario trước khi phát hành.

**6.4 — Scenario "Chế độ khó" (backlog, chỉ sau khi 6.1 xong):**
- Dữ liệu Task 3.5 chốt: lương 9.500.000 với chi phí 10,5tr (âm 1tr/tháng) là impossible khi chưa có side-job/market — cả 3 seed bot chết tuổi 23. Sau khi 6.1 phát hành đủ "vũ khí", tạo `vn_provincial_hard.json` với lương 9,5tr làm scenario khó riêng (phù hợp mô hình bán bối cảnh của GDD mục 9). Bản thường giữ lương 11.000.000 (chốt tại Task 3.5).

## ĐỊNH DẠNG BÁO CÁO SAU MỖI TASK
- Danh sách file đã tạo/sửa.
- Kết quả `dart analyze` và `flutter test` (số test pass).
- Các quyết định thiết kế đáng chú ý và trade-off.
- Vấn đề phát hiện trong code cũ (nếu có) + đề xuất.