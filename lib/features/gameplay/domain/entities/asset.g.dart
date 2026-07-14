// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Asset _$AssetFromJson(Map<String, dynamic> json) => _Asset(
  id: json['id'] as String,
  name: json['name'] as String,
  baseValue: (json['baseValue'] as num).toDouble(),
  monthlyPassiveIncome:
      (json['monthlyPassiveIncome'] as num?)?.toDouble() ?? 0.0,
  type:
      $enumDecodeNullable(_$AssetTypeEnumMap, json['type']) ?? AssetType.stock,
);

Map<String, dynamic> _$AssetToJson(_Asset instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'baseValue': instance.baseValue,
  'monthlyPassiveIncome': instance.monthlyPassiveIncome,
  'type': _$AssetTypeEnumMap[instance.type]!,
};

const _$AssetTypeEnumMap = {
  AssetType.stock: 'stock',
  AssetType.realEstate: 'realEstate',
  AssetType.business: 'business',
  AssetType.crypto: 'crypto',
};
