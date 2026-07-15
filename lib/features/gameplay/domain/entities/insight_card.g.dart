// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InsightCard _$InsightCardFromJson(Map<String, dynamic> json) => _InsightCard(
  id: json['id'] as String,
  conceptKey: json['conceptKey'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$InsightCardToJson(_InsightCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conceptKey': instance.conceptKey,
      'title': instance.title,
      'description': instance.description,
    };
