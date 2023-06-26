// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'van_sales_return_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VanSalesReturnSearch _$VanSalesReturnSearchFromJson(Map<String, dynamic> json) {
  return VanSalesReturnSearch(
    CustomerID: json['CustomerID'] as int,
    LocationID: json['LocationID'] as int,
    FromDate: json['FromDate'] as String,
    ToDate: json['ToDate'] as String,
    CreatedBy: json['CreatedBy'] as int,
    VanSalesReturnList: (json['VanSalesReturnList'] as List)
        ?.map((e) => e == null
            ? null
            : VanSalesReturnSearchItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VanSalesReturnSearchToJson(
        VanSalesReturnSearch instance) =>
    <String, dynamic>{
      'CustomerID': instance.CustomerID,
      'LocationID': instance.LocationID,
      'FromDate': instance.FromDate,
      'ToDate': instance.ToDate,
      'CreatedBy': instance.CreatedBy,
      'VanSalesReturnList': instance.VanSalesReturnList,
    };
