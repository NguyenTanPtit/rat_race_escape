// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssetListing _$AssetListingFromJson(Map<String, dynamic> json) =>
    _AssetListing(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$AssetTypeEnumMap, json['type']),
      annualYieldRate: (json['annualYieldRate'] as num).toDouble(),
    );

Map<String, dynamic> _$AssetListingToJson(_AssetListing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$AssetTypeEnumMap[instance.type]!,
      'annualYieldRate': instance.annualYieldRate,
    };

const _$AssetTypeEnumMap = {
  AssetType.stock: 'stock',
  AssetType.realEstate: 'realEstate',
  AssetType.business: 'business',
  AssetType.crypto: 'crypto',
};
