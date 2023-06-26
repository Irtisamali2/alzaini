// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'van_sales_invoice_print_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VanSalesInvoicePrintItem _$VanSalesInvoicePrintItemFromJson(
    Map<String, dynamic> json) {
  return VanSalesInvoicePrintItem(
    ItemID: json['ItemID'] as int,
    ItemName: json['ItemName'] as String,
    UnitID: json['UnitID'] as int,
    InvoiceQty: (json['InvoiceQty'] as num)?.toDouble(),
    FreeQty: (json['FreeQty'] as num)?.toDouble(),
    UnitPrice: (json['UnitPrice'] as num)?.toDouble(),
    ActualPrice: (json['ActualPrice'] as num)?.toDouble(),
    UnitName: json['UnitName'] as String,
    ArabicName: json['ArabicName'] as String,
    ArabicUnit: json['ArabicUnit'] as String,
  );
}

Map<String, dynamic> _$VanSalesInvoicePrintItemToJson(
        VanSalesInvoicePrintItem instance) =>
    <String, dynamic>{
      'ItemID': instance.ItemID,
      'ItemName': instance.ItemName,
      'UnitID': instance.UnitID,
      'InvoiceQty': instance.InvoiceQty,
      'FreeQty': instance.FreeQty,
      'UnitPrice': instance.UnitPrice,
      'ActualPrice': instance.ActualPrice,
      'UnitName': instance.UnitName,
      'ArabicName': instance.ArabicName,
      'ArabicUnit': instance.ArabicUnit,
    };
