
import 'package:json_annotation/json_annotation.dart';

part 'van_sales_return_search_item.g.dart';

@JsonSerializable()
class VanSalesReturnSearchItem{

  int VanSalesReturnID;
  String ReturnNo;

  String ReturnDate;
  String InvNo;

  String Total;

  VanSalesReturnSearchItem({this.VanSalesReturnID, this.ReturnNo, this.ReturnDate,
    this.InvNo, this.Total});

  factory VanSalesReturnSearchItem.fromJson(Map<String, dynamic> map) => _$VanSalesReturnSearchItemFromJson(map);

  Map<String, dynamic> toJson() => _$VanSalesReturnSearchItemToJson(this);
}
