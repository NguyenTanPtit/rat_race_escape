import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset.freezed.dart';
part 'asset.g.dart';

@freezed
abstract class Asset with _$Asset {
  const factory Asset({
    required String id,
    required String name,
    required double baseValue, // Cost basis for market assets; fixed value for legacy assets
    @Default(0.0) double monthlyPassiveIncome, // Passive income generated each month
    @Default(AssetType.stock) AssetType type,
    // Market-traded holdings only; legacy assets keep both at defaults
    @Default(0.0) double units,
    String? marketClassId,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}

enum AssetType { stock, realEstate, business, crypto }