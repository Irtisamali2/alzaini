// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'van_sales_invoice_add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VanSalesInvoiceAdd _$VanSalesInvoiceAddFromJson(Map<String, dynamic> json) {
  return VanSalesInvoiceAdd(
    VanSalesInvoiceID: json['VanSalesInvoiceID'] as int,
    CustomerID: json['CustomerID'] as int,
    LocationID: json['LocationID'] as int,
    GPSLocation: json['GPSLocation'] as String,
    Mobile: json['Mobile'] as String,
    EmployeeID: json['EmployeeID'] as int,
    TotalAmount: (json['TotalAmount'] as num)?.toDouble(),
    CreatedBy: json['CreatedBy'] as int,
    VanSalesInvoiceDetailsList: (json['VanSalesInvoiceDetailsList'] as List)
        ?.map((e) => e == null
            ? null
            : VanSalesInvoiceDetailsItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VanSalesInvoiceAddToJson(VanSalesInvoiceAdd instance) =>
    <String, dynamic>{
      'VanSalesInvoiceID': instance.VanSalesInvoiceID,
      'CustomerID': instance.CustomerID,
      'LocationID': instance.LocationID,
      'GPSLocation': instance.GPSLocation,
      'Mobile': instance.Mobile,
      'EmployeeID': instance.EmployeeID,
      'TotalAmount': instance.TotalAmount,
      'CreatedBy': instance.CreatedBy,
      'VanSalesInvoiceDetailsList': instance.VanSalesInvoiceDetailsList,
    };
