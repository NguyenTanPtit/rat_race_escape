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
import '../../features/gameplay/data/repositories/json_event_pool_repository.dart'
    as _i831;
import '../../features/gameplay/data/repositories/json_insight_card_repository.dart'
    as _i29;
import '../../features/gameplay/data/repositories/json_scenario_config_repository.dart'
    as _i248;
import '../../features/gameplay/domain/repositories/event_pool_repository.dart'
    as _i690;
import '../../features/gameplay/domain/repositories/game_state_repository.dart'
    as _i688;
import '../../features/gameplay/domain/repositories/insight_card_repository.dart'
    as _i107;
import '../../features/gameplay/domain/repositories/scenario_config_repository.dart'
    as _i96;
import '../../features/gameplay/domain/usecases/actions/buy_asset_usecase.dart'
    as _i78;
import '../../features/gameplay/domain/usecases/actions/pay_debt_usecase.dart'
    as _i22;
import '../../features/gameplay/domain/usecases/actions/sell_asset_usecase.dart'
    as _i635;
import '../../features/gameplay/domain/usecases/actions/spend_on_leisure_usecase.dart'
    as _i298;
import '../../features/gameplay/domain/usecases/actions/work_side_job_usecase.dart'
    as _i453;
import '../../features/gameplay/domain/usecases/engine/calculate_cashflow_usecase.dart'
    as _i37;
import '../../features/gameplay/domain/usecases/engine/check_behavioral_insights_usecase.dart'
    as _i951;
import '../../features/gameplay/domain/usecases/engine/check_game_status_usecase.dart'
    as _i782;
import '../../features/gameplay/domain/usecases/engine/process_loans_usecase.dart'
    as _i417;
import '../../features/gameplay/domain/usecases/engine/process_next_month_usecase.dart'
    as _i881;
import '../../features/gameplay/domain/usecases/engine/update_metrics_usecase.dart'
    as _i680;
import '../../features/gameplay/domain/usecases/events/apply_event_option_usecase.dart'
    as _i608;
import '../../features/gameplay/domain/usecases/events/generate_event_usecase.dart'
    as _i319;
import '../../features/gameplay/domain/usecases/market/buy_market_asset_usecase.dart'
    as _i1072;
import '../../features/gameplay/domain/usecases/market/sell_market_asset_usecase.dart'
    as _i359;
import '../../features/gameplay/domain/usecases/market/update_market_usecase.dart'
    as _i893;
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
    gh.lazySingleton<_i37.CalculateCashflowUseCase>(
      () => _i37.CalculateCashflowUseCase(),
    );
    gh.lazySingleton<_i951.CheckBehavioralInsightsUseCase>(
      () => _i951.CheckBehavioralInsightsUseCase(),
    );
    gh.lazySingleton<_i782.CheckGameStatusUseCase>(
      () => _i782.CheckGameStatusUseCase(),
    );
    gh.lazySingleton<_i417.ProcessLoansUseCase>(
      () => _i417.ProcessLoansUseCase(),
    );
    gh.lazySingleton<_i680.UpdateMetricsUseCase>(
      () => _i680.UpdateMetricsUseCase(),
    );
    gh.lazySingleton<_i893.UpdateMarketUseCase>(
      () => _i893.UpdateMarketUseCase(gh<_i407.Random>()),
    );
    gh.lazySingleton<_i78.BuyAssetUseCase>(
      () => _i78.BuyAssetUseCase(gh<_i782.CheckGameStatusUseCase>()),
    );
    gh.lazySingleton<_i22.PayDebtUseCase>(
      () => _i22.PayDebtUseCase(gh<_i782.CheckGameStatusUseCase>()),
    );
    gh.lazySingleton<_i635.SellAssetUseCase>(
      () => _i635.SellAssetUseCase(gh<_i782.CheckGameStatusUseCase>()),
    );
    gh.lazySingleton<_i298.SpendOnLeisureUseCase>(
      () => _i298.SpendOnLeisureUseCase(gh<_i782.CheckGameStatusUseCase>()),
    );
    gh.lazySingleton<_i453.WorkSideJobUseCase>(
      () => _i453.WorkSideJobUseCase(gh<_i782.CheckGameStatusUseCase>()),
    );
    gh.lazySingleton<_i1072.BuyMarketAssetUseCase>(
      () => _i1072.BuyMarketAssetUseCase(gh<_i782.CheckGameStatusUseCase>()),
    );
    gh.lazySingleton<_i359.SellMarketAssetUseCase>(
      () => _i359.SellMarketAssetUseCase(gh<_i782.CheckGameStatusUseCase>()),
    );
    gh.lazySingleton<_i688.GameStateRepository>(
      () => _i1051.HiveGameStateRepository(),
    );
    gh.lazySingleton<_i107.InsightCardRepository>(
      () => _i29.JsonInsightCardRepository(),
    );
    gh.lazySingleton<_i690.EventPoolRepository>(
      () => _i831.JsonEventPoolRepository(),
    );
    gh.lazySingleton<_i96.ScenarioConfigRepository>(
      () => _i248.JsonScenarioConfigRepository(),
    );
    gh.lazySingleton<_i608.ApplyEventOptionUseCase>(
      () => _i608.ApplyEventOptionUseCase(
        gh<_i690.EventPoolRepository>(),
        gh<_i782.CheckGameStatusUseCase>(),
      ),
    );
    gh.lazySingleton<_i319.GenerateEventUseCase>(
      () => _i319.GenerateEventUseCase(
        gh<_i690.EventPoolRepository>(),
        gh<_i407.Random>(),
      ),
    );
    gh.lazySingleton<_i881.ProcessNextMonthUseCase>(
      () => _i881.ProcessNextMonthUseCase(
        gh<_i37.CalculateCashflowUseCase>(),
        gh<_i417.ProcessLoansUseCase>(),
        gh<_i893.UpdateMarketUseCase>(),
        gh<_i680.UpdateMetricsUseCase>(),
        gh<_i319.GenerateEventUseCase>(),
        gh<_i782.CheckGameStatusUseCase>(),
        gh<_i951.CheckBehavioralInsightsUseCase>(),
      ),
    );
    gh.factory<_i910.GameEngineCubit>(
      () => _i910.GameEngineCubit(
        gh<_i881.ProcessNextMonthUseCase>(),
        gh<_i608.ApplyEventOptionUseCase>(),
        gh<_i298.SpendOnLeisureUseCase>(),
        gh<_i688.GameStateRepository>(),
        gh<_i96.ScenarioConfigRepository>(),
        gh<_i690.EventPoolRepository>(),
        gh<_i1072.BuyMarketAssetUseCase>(),
        gh<_i359.SellMarketAssetUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
