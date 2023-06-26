// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'van_sales_invoice_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VanSalesInvoiceDetailsItem _$VanSalesInvoiceDetailsItemFromJson(
    Map<String, dynamic> json) {
  return VanSalesInvoiceDetailsItem(
    ItemID: json['ItemID'] as int,
    ItemName: json['ItemName'] as String,
    UnitID: json['UnitID'] as int,
    InvoiceQty: json['InvoiceQty'] as int,
    FreeQty: json['FreeQty'] as int,
    UnitPrice: (json['UnitPrice'] as num)?.toDouble(),
    ActualPrice: (json['ActualPrice'] as num)?.toDouble(),
    UnitName: json['UnitName'] as String,
  );
}

Map<String, dynamic> _$VanSalesInvoiceDetailsItemToJson(
        VanSalesInvoiceDetailsItem instance) =>
    <String, dynamic>{
      'ItemID': instance.ItemID,
      'ItemName': instance.ItemName,
      'UnitID': instance.UnitID,
      'InvoiceQty': instance.InvoiceQty,
      'FreeQty': instance.FreeQty,
      'UnitPrice': instance.UnitPrice,
      'ActualPrice': instance.ActualPrice,
      'UnitName': instance.UnitName,
    };
