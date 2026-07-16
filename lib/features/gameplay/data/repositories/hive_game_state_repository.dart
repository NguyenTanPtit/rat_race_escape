import 'dart:convert';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/repositories/game_state_repository.dart';

@LazySingleton(as: GameStateRepository)
class HiveGameStateRepository implements GameStateRepository {
  static const String _boxName = 'game_state_box';
  static const String _key = 'current_save';

  @override
  Future<void> saveGame(GameState state) async {
    final box = await Hive.openBox<String>(_boxName);
    await box.put(_key, jsonEncode(state.toJson()));
  }

  @override
  Future<GameState?> loadGame() async {
    final box = await Hive.openBox<String>(_boxName);
    final jsonString = box.get(_key);
    if (jsonString != null) {
      try {
        final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
        
        // Invalidate legacy saves with 'default' scenario
        if (jsonMap['scenarioId'] == 'default') {
          await deleteSave();
          return null;
        }
        
        return GameState.fromJson(jsonMap);
      } catch (e) {
        // Can log error here
        return null;
      }
    }
    return null;
  }

  @override
  Future<bool> hasSavedGame() async {
    final box = await Hive.openBox<String>(_boxName);
    if (!box.containsKey(_key)) return false;
    
    final jsonString = box.get(_key);
    if (jsonString != null) {
      try {
        final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
        if (jsonMap['scenarioId'] == 'default') {
          await deleteSave();
          return false;
        }
        return true;
      } catch (_) {}
    }
    return false;
  }

  @override
  Future<void> deleteSave() async {
    final box = await Hive.openBox<String>(_boxName);
    await box.delete(_key);
  }
}
