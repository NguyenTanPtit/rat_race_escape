// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:math' as _i407;

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/gameplay/data/repositories/hive_game_state_repository.dart'
    as _i1051;
import '../../features/gameplay/data/repositories/in_memory_event_pool_repository.dart'
    as _i561;
import '../../features/gameplay/data/repositories/in_memory_scenario_config_repository.dart'
    as _i542;
import '../../features/gameplay/domain/repositories/event_pool_repository.dart'
    as _i690;
import '../../features/gameplay/domain/repositories/game_state_repository.dart'
    as _i688;
import '../../features/gameplay/domain/repositories/scenario_config_repository.dart'
    as _i96;
import '../../features/gameplay/domain/usecases/calculate_cashflow_usecase.dart'
    as _i521;
import '../../features/gameplay/domain/usecases/check_game_status_usecase.dart'
    as _i669;
import '../../features/gameplay/domain/usecases/generate_event_usecase.dart'
    as _i588;
import '../../features/gameplay/domain/usecases/process_loans_usecase.dart'
    as _i709;
import '../../features/gameplay/domain/usecases/process_next_month_usecase.dart'
    as _i541;
import '../../features/gameplay/domain/usecases/update_metrics_usecase.dart'
    as _i454;
import '../../features/gameplay/presentation/cubit/game_engine_cubit.dart'
    as _i910;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i407.Random>(() => registerModule.random);
    gh.lazySingleton<_i521.CalculateCashflowUseCase>(
      () => _i521.CalculateCashflowUseCase(),
    );
    gh.lazySingleton<_i669.CheckGameStatusUseCase>(
      () => _i669.CheckGameStatusUseCase(),
    );
    gh.lazySingleton<_i588.GenerateEventUseCase>(
      () => _i588.GenerateEventUseCase(),
    );
    gh.lazySingleton<_i709.ProcessLoansUseCase>(
      () => _i709.ProcessLoansUseCase(),
    );
    gh.lazySingleton<_i454.UpdateMetricsUseCase>(
      () => _i454.UpdateMetricsUseCase(),
    );
    gh.lazySingleton<_i96.ScenarioConfigRepository>(
      () => _i542.InMemoryScenarioConfigRepository(),
    );
    gh.lazySingleton<_i690.EventPoolRepository>(
      () => _i561.InMemoryEventPoolRepository(),
    );
    gh.lazySingleton<_i688.GameStateRepository>(
      () => _i1051.HiveGameStateRepository(),
    );
    gh.lazySingleton<_i541.ProcessNextMonthUseCase>(
      () => _i541.ProcessNextMonthUseCase(
        gh<_i521.CalculateCashflowUseCase>(),
        gh<_i709.ProcessLoansUseCase>(),
        gh<_i454.UpdateMetricsUseCase>(),
        gh<_i588.GenerateEventUseCase>(),
        gh<_i669.CheckGameStatusUseCase>(),
      ),
    );
    gh.factory<_i910.GameEngineCubit>(
      () => _i910.GameEngineCubit(gh<_i541.ProcessNextMonthUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
