// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'van_item_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VanItemDetails _$VanItemDetailsFromJson(Map<String, dynamic> json) {
  return VanItemDetails(
    ItemID: json['ItemID'] as int,
    UnitID: json['UnitID'] as int,
    ItemName: json['ItemName'] as String,
    ItemTypeName: json['ItemTypeName'] as String,
    SalesPrice: json['SalesPrice'] as String,
    QtyOnHand: json['QtyOnHand'] as String,
    UnitName: json['UnitName'] as String,
  );
}

Map<String, dynamic> _$VanItemDetailsToJson(VanItemDetails instance) =>
    <String, dynamic>{
      'ItemID': instance.ItemID,
      'UnitID': instance.UnitID,
      'ItemName': instance.ItemName,
      'ItemTypeName': instance.ItemTypeName,
      'SalesPrice': instance.SalesPrice,
      'QtyOnHand': instance.QtyOnHand,
      'UnitName': instance.UnitName,
    };
