// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'van_sales_invoice_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VanSalesInvoiceSearch _$VanSalesInvoiceSearchFromJson(
    Map<String, dynamic> json) {
  return VanSalesInvoiceSearch(
    CustomerID: json['CustomerID'] as int,
    EmployeeID: json['EmployeeID'] as int,
    FromDate: json['FromDate'] as String,
    ToDate: json['ToDate'] as String,
    CreatedBy: json['CreatedBy'] as int,
    VanSalesInvoiceList: (json['VanSalesInvoiceList'] as List)
        ?.map((e) => e == null
            ? null
            : VanSalesInvoiceSearchItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VanSalesInvoiceSearchToJson(
        VanSalesInvoiceSearch instance) =>
    <String, dynamic>{
      'CustomerID': instance.CustomerID,
      'EmployeeID': instance.EmployeeID,
      'FromDate': instance.FromDate,
      'ToDate': instance.ToDate,
      'CreatedBy': instance.CreatedBy,
      'VanSalesInvoiceList': instance.VanSalesInvoiceList,
    };
