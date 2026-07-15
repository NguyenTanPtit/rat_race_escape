import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/insight_card.dart';
import '../../domain/repositories/insight_card_repository.dart';

@LazySingleton(as: InsightCardRepository)
class JsonInsightCardRepository implements InsightCardRepository {
  Map<String, InsightCard>? _cache;
  String? _cachedLocale;

  @override
  Future<List<InsightCard>> loadInsightCards([String locale = 'vi']) async {
    await _ensureLoaded(locale);
    return _cache!.values.toList();
  }

  @override
  Future<InsightCard?> getInsightCard(String id, [String locale = 'vi']) async {
    await _ensureLoaded(locale);
    return _cache![id];
  }

  Future<void> _ensureLoaded(String locale) async {
    if (_cache != null && _cachedLocale == locale) {
      return;
    }

    final jsonString = await rootBundle.loadString('assets/config/i18n/insight_cards_$locale.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    _cache = {};
    for (final entry in jsonMap.entries) {
      final cardId = entry.key;
      final cardData = entry.value as Map<String, dynamic>;
      
      // Inject the key as the id
      cardData['id'] = cardId;
      
      _cache![cardId] = InsightCard.fromJson(cardData);
    }
    _cachedLocale = locale;
  }
}
