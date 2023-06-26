// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'van_sales_return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VanSalesReturn _$VanSalesReturnFromJson(Map<String, dynamic> json) {
  return VanSalesReturn(
    VanSalesReturnID: json['VanSalesReturnID'] as int,
    VanSalesInvoiceID: json['VanSalesInvoiceID'] as int,
    CustomerID: json['CustomerID'] as int,
    LocationID: json['LocationID'] as int,
    Reference: json['Reference'] as String,
    GPSLocation: json['GPSLocation'] as String,
    EmployeeID: json['EmployeeID'] as int,
    TotalAmount: (json['TotalAmount'] as num)?.toDouble(),
    CreatedBy: json['CreatedBy'] as int,
    VanSalesReturnDetailsList: (json['VanSalesReturnDetailsList'] as List)
        ?.map((e) => e == null
            ? null
            : VanSalesReturnItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VanSalesReturnToJson(VanSalesReturn instance) =>
    <String, dynamic>{
      'VanSalesReturnID': instance.VanSalesReturnID,
      'VanSalesInvoiceID': instance.VanSalesInvoiceID,
      'CustomerID': instance.CustomerID,
      'LocationID': instance.LocationID,
      'Reference': instance.Reference,
      'GPSLocation': instance.GPSLocation,
      'EmployeeID': instance.EmployeeID,
      'TotalAmount': instance.TotalAmount,
      'CreatedBy': instance.CreatedBy,
      'VanSalesReturnDetailsList': instance.VanSalesReturnDetailsList,
    };
