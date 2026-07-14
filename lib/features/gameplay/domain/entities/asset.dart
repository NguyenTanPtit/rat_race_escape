import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset.freezed.dart';
part 'asset.g.dart';

@freezed
abstract class Asset with _$Asset {
  const factory Asset({
    required String id,
    required String name,
    required double baseValue, // Current value of the asset
    @Default(0.0) double monthlyPassiveIncome, // Passive income generated each month
    @Default(AssetType.stock) AssetType type,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}

enum AssetType { stock, realEstate, business, crypto }