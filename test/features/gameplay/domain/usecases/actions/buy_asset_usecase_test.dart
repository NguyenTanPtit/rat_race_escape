import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset_listing.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/buy_asset_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckGameStatusUseCase extends Mock implements CheckGameStatusUseCase {}
class FakeGameState extends Fake implements GameState {}

void main() {
  late MockCheckGameStatusUseCase mockCheckGameStatusUseCase;
  late BuyAssetUseCase usecase;

  setUpAll(() {
    registerFallbackValue(FakeGameState());
  });

  setUp(() {
    mockCheckGameStatusUseCase = MockCheckGameStatusUseCase();
    usecase = BuyAssetUseCase(mockCheckGameStatusUseCase);
    
    when(() => mockCheckGameStatusUseCase(any())).thenAnswer((inv) => TurnResult.continued(inv.positionalArguments[0] as GameState));
  });

  final initialState = const GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'default',
    monthlyExpenses: 10000,
    monthlyRent: 2000,
    baseSalary: 15000,
    cash: 50000,
  );

  final testAssetListing = const AssetListing(
    id: 'stock_1',
    name: 'Tech Stock',
    type: AssetType.stock,
    annualYieldRate: 12.0, // 1% per month
  );

  test('successfully buys an asset if enough cash', () {
    final result = usecase(initialState, testAssetListing, 10000);

    expect(result.isRight(), true);
    final turnResult = result.fold((l) => null, (r) => r);
    expect(turnResult, isA<TurnContinued>());
    final finalState = (turnResult as TurnContinued).state;

    expect(finalState.cash, 40000); // 50000 - 10000
    expect(finalState.assets.length, 1);
    expect(finalState.assets[0].name, 'Tech Stock');
    expect(finalState.assets[0].baseValue, 10000);
    // 10000 * (12 / 100 / 12) = 100
    expect(finalState.assets[0].monthlyPassiveIncome, 100.0);
  });

  test('fails if not enough cash', () {
    final result = usecase(initialState, testAssetListing, 60000); // more than 50000

    expect(result.isLeft(), true);
    final failure = result.fold((l) => l, (r) => null);
    expect(failure?.message, 'Not enough cash to buy this asset');
  });

  test('fails if amount <= 0', () {
    final result = usecase(initialState, testAssetListing, 0);

    expect(result.isLeft(), true);
    final failure = result.fold((l) => l, (r) => null);
    expect(failure?.message, 'Amount must be greater than 0');
  });
}
