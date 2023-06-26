// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'van_sales_invoice_search_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VanSalesInvoiceSearchItem _$VanSalesInvoiceSearchItemFromJson(
    Map<String, dynamic> json) {
  return VanSalesInvoiceSearchItem(
    VanSalesInvoiceID: json['VanSalesInvoiceID'] as int,
    InvNo: json['InvNo'] as String,
    InvDate: json['InvDate'] as String,
    MobileNo: json['MobileNo'] as String,
    Total: json['Total'] as String,
  );
}

Map<String, dynamic> _$VanSalesInvoiceSearchItemToJson(
        VanSalesInvoiceSearchItem instance) =>
    <String, dynamic>{
      'VanSalesInvoiceID': instance.VanSalesInvoiceID,
      'InvNo': instance.InvNo,
      'InvDate': instance.InvDate,
      'MobileNo': instance.MobileNo,
      'Total': instance.Total,
    };
