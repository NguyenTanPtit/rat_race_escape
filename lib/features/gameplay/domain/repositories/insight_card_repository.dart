import '../entities/insight_card.dart';

abstract class InsightCardRepository {
  /// Loads all available insight cards for a given locale
  Future<List<InsightCard>> loadInsightCards([String locale = 'vi']);

  /// Gets a specific insight card by ID
  Future<InsightCard?> getInsightCard(String id, [String locale = 'vi']);
}
