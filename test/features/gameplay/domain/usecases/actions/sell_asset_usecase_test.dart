import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/sell_asset_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckGameStatusUseCase extends Mock implements CheckGameStatusUseCase {}
class FakeGameState extends Fake implements GameState {}

void main() {
  late MockCheckGameStatusUseCase mockCheckGameStatusUseCase;
  late SellAssetUseCase usecase;

  setUpAll(() {
    registerFallbackValue(FakeGameState());
  });

  setUp(() {
    mockCheckGameStatusUseCase = MockCheckGameStatusUseCase();
    usecase = SellAssetUseCase(mockCheckGameStatusUseCase);
    
    when(() => mockCheckGameStatusUseCase(any())).thenAnswer((inv) => TurnResult.continued(inv.positionalArguments[0] as GameState));
  });

  final testAsset = const Asset(
    id: 'asset_1',
    name: 'Tech Stock',
    type: AssetType.stock,
    baseValue: 10000,
    monthlyPassiveIncome: 100,
  );

  final initialState = GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'default',
    monthlyExpenses: 10000,
    monthlyRent: 2000,
    baseSalary: 15000,
    cash: 50000,
    assetSellFeeRate: 0.03, // 3% fee
    assets: [testAsset],
  );

  test('successfully sells an asset and deducts fee', () {
    final result = usecase(initialState, 'asset_1');

    expect(result.isRight(), true);
    final turnResult = result.fold((l) => null, (r) => r);
    expect(turnResult, isA<TurnContinued>());
    final finalState = (turnResult as TurnContinued).state;

    // Cash received = 10000 * (1 - 0.03) = 9700
    // Total cash = 50000 + 9700 = 59700
    expect(finalState.cash, 59700);
    expect(finalState.assets.length, 0);
  });

  test('fails if asset not found', () {
    final result = usecase(initialState, 'asset_2');

    expect(result.isLeft(), true);
    final failure = result.fold((l) => l, (r) => null);
    expect(failure?.message, 'Asset not found');
  });
}
