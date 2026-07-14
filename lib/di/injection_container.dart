import 'package:get_it/get_it.dart';
import '../features/gameplay/domain/usecases/process_next_month_usecase.dart';
import '../features/gameplay/domain/usecases/calculate_cashflow_usecase.dart';
import '../features/gameplay/domain/usecases/process_loans_usecase.dart';
import '../features/gameplay/domain/usecases/update_metrics_usecase.dart';
import '../features/gameplay/domain/usecases/generate_event_usecase.dart';
import '../features/gameplay/domain/usecases/check_game_status_usecase.dart';
import '../features/gameplay/presentation/cubit/game_engine_cubit.dart';

final sl = GetIt.instance; // sl stands for Service Locator

Future<void> initDI() async {
  // 1. Register UseCases
  sl.registerLazySingleton(() => CalculateCashflowUseCase());
  sl.registerLazySingleton(() => ProcessLoansUseCase());
  sl.registerLazySingleton(() => UpdateMetricsUseCase());
  sl.registerLazySingleton(() => GenerateEventUseCase());
  sl.registerLazySingleton(() => CheckGameStatusUseCase());

  // 2. Register Orchestrator (Cần inject các usecase con vào)
  sl.registerLazySingleton(() => ProcessNextMonthUseCase(
    sl(),
    sl(),
    sl(),
    sl(),
    sl(),
  ));

  // 3. Register Cubit (Cần inject orchestrator vào)
  sl.registerFactory(() => GameEngineCubit(sl()));
}