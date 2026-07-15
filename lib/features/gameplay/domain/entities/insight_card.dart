import 'package:freezed_annotation/freezed_annotation.dart';

part 'insight_card.freezed.dart';
part 'insight_card.g.dart';

@freezed
abstract class InsightCard with _$InsightCard {
  const factory InsightCard({
    required String id,
    required String conceptKey,
    required String title,
    required String description,
  }) = _InsightCard;

  factory InsightCard.fromJson(Map<String, dynamic> json) => _$InsightCardFromJson(json);
}
