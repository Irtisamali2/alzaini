// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'van_sales_invoice_print.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VanSalesInvoicePrintModel _$VanSalesInvoicePrintModelFromJson(
    Map<String, dynamic> json) {
  return VanSalesInvoicePrintModel(
    VanSalesInvoiceID: json['VanSalesInvoiceID'] as int,
    CustomerID: json['CustomerID'] as int,
    LocationID: json['LocationID'] as int,
    InvoiceNo: json['InvoiceNo'] as String,
    Mobile: json['Mobile'] as String,
    EmployeeID: json['EmployeeID'] as int,
    Phone: json['Phone'] as String,
    Date: json['Date'] as String,
    Discount: (json['Discount'] as num)?.toDouble(),
    TotalAmount: (json['TotalAmount'] as num)?.toDouble(),
    VanSalesInvoiceDetailsList: (json['VanSalesInvoiceDetailsList'] as List)
        ?.map((e) => e == null
            ? null
            : VanSalesInvoicePrintItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VanSalesInvoicePrintModelToJson(
        VanSalesInvoicePrintModel instance) =>
    <String, dynamic>{
      'VanSalesInvoiceID': instance.VanSalesInvoiceID,
      'CustomerID': instance.CustomerID,
      'LocationID': instance.LocationID,
      'InvoiceNo': instance.InvoiceNo,
      'Mobile': instance.Mobile,
      'EmployeeID': instance.EmployeeID,
      'Phone': instance.Phone,
      'Date': instance.Date,
      'Discount': instance.Discount,
      'TotalAmount': instance.TotalAmount,
      'VanSalesInvoiceDetailsList': instance.VanSalesInvoiceDetailsList,
    };
