import 'package:freezed_annotation/freezed_annotation.dart';
import 'asset.dart';

part 'asset_listing.freezed.dart';
part 'asset_listing.g.dart';

@freezed
abstract class AssetListing with _$AssetListing {
  const factory AssetListing({
    required String id,
    required String name,
    required AssetType type,
    required double annualYieldRate, // Percentage per year, e.g. 10.0 for 10%
  }) = _AssetListing;

  factory AssetListing.fromJson(Map<String, dynamic> json) => _$AssetListingFromJson(json);
}
