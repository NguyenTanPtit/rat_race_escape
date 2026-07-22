import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:rat_race_escape/core/di/injection.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_next_month_usecase.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/game_state_repository.dart';

void main() {
  group('DI Smoke Test', () {
    late Directory tempDir;

    setUp(() async {
      await getIt.reset();
      tempDir = await Directory.systemTemp.createTemp();
      Hive.init(tempDir.path);
      await configureDependencies();
    });

    tearDown(() async {
      await Hive.close();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('should resolve essential dependencies without throwing', () {
      expect(() => getIt<ProcessNextMonthUseCase>(), returnsNormally);
      expect(() => getIt<GameEngineCubit>(), returnsNormally);
      expect(() => getIt<GameStateRepository>(), returnsNormally);
    });
  });
}
