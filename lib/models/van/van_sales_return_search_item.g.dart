// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'van_sales_return_search_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VanSalesReturnSearchItem _$VanSalesReturnSearchItemFromJson(
    Map<String, dynamic> json) {
  return VanSalesReturnSearchItem(
    VanSalesReturnID: json['VanSalesReturnID'] as int,
    ReturnNo: json['ReturnNo'] as String,
    ReturnDate: json['ReturnDate'] as String,
    InvNo: json['InvNo'] as String,
    Total: json['Total'] as String,
  );
}

Map<String, dynamic> _$VanSalesReturnSearchItemToJson(
        VanSalesReturnSearchItem instance) =>
    <String, dynamic>{
      'VanSalesReturnID': instance.VanSalesReturnID,
      'ReturnNo': instance.ReturnNo,
      'ReturnDate': instance.ReturnDate,
      'InvNo': instance.InvNo,
      'Total': instance.Total,
    };
