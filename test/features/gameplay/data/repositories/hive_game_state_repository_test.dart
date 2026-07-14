import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:rat_race_escape/features/gameplay/data/repositories/hive_game_state_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';

void main() {
  late HiveGameStateRepository repository;

  setUp(() async {
    Hive.init('./test_hive_data');
    repository = HiveGameStateRepository();
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('game_state_box');
  });

  group('HiveGameStateRepository', () {
    final tGameState = GameState(
      country: Country.vietnam,
      currency: Currency.vnd,
      currentMonth: 1,
      ageInMonths: 264,
      cash: 10000000,
      monthlyExpenses: 5000000,
      baseSalary: 12000000,
    );

    test('loadGame should return null when no saved game', () async {
      final result = await repository.loadGame();
      expect(result, isNull);
    });

    test('hasSavedGame should return false when no saved game', () async {
      final result = await repository.hasSavedGame();
      expect(result, false);
    });

    test('saveGame and loadGame round-trip should work correctly', () async {
      // Act
      await repository.saveGame(tGameState);
      final hasSaved = await repository.hasSavedGame();
      final loadedState = await repository.loadGame();

      // Assert
      expect(hasSaved, true);
      expect(loadedState, tGameState);
    });

    test('deleteSave should remove the saved game', () async {
      // Arrange
      await repository.saveGame(tGameState);
      expect(await repository.hasSavedGame(), true);

      // Act
      await repository.deleteSave();

      // Assert
      expect(await repository.hasSavedGame(), false);
      expect(await repository.loadGame(), isNull);
    });
  });
}
