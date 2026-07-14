import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset.freezed.dart';

@freezed
class Asset with _$Asset {
  const factory Asset({
    required String id,
    required String name,
    required double baseValue, // Giá trị hiện tại của tài sản
    @Default(0.0) double monthlyPassiveIncome, // Dòng tiền thụ động sinh ra mỗi tháng
    @Default(AssetType.stock) AssetType type,
  }) = _Asset;
}

enum AssetType { stock, realEstate, business, crypto }