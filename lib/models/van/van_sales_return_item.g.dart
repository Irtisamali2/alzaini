// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'van_sales_return_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VanSalesReturnItem _$VanSalesReturnItemFromJson(Map<String, dynamic> json) {
  return VanSalesReturnItem(
    ItemID: json['ItemID'] as int,
    ItemName: json['ItemName'] as String,
    UnitID: json['UnitID'] as int,
    QtyReturned: (json['QtyReturned'] as num)?.toDouble(),
    QtyInvoiced: (json['QtyInvoiced'] as num)?.toDouble(),
    UnitPrice: (json['UnitPrice'] as num)?.toDouble(),
    ActualPrice: (json['ActualPrice'] as num)?.toDouble(),
    UnitName: json['UnitName'] as String,
    IsAdd: json['IsAdd'] as bool,
  );
}

Map<String, dynamic> _$VanSalesReturnItemToJson(VanSalesReturnItem instance) =>
    <String, dynamic>{
      'ItemID': instance.ItemID,
      'ItemName': instance.ItemName,
      'UnitID': instance.UnitID,
      'QtyReturned': instance.QtyReturned,
      'QtyInvoiced': instance.QtyInvoiced,
      'UnitPrice': instance.UnitPrice,
      'ActualPrice': instance.ActualPrice,
      'UnitName': instance.UnitName,
      'IsAdd': instance.IsAdd,
    };
