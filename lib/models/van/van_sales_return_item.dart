import 'package:json_annotation/json_annotation.dart';

part 'van_sales_return_item.g.dart';

@JsonSerializable()
class VanSalesReturnItem{

  int ItemID;
  String ItemName;

  int UnitID;

  double QtyReturned;
  double QtyInvoiced;

  double UnitPrice;
  double ActualPrice;

  String UnitName;
  bool IsAdd;

  VanSalesReturnItem(
      {this.ItemID,
      this.ItemName,
      this.UnitID,
      this.QtyReturned,
      this.QtyInvoiced,
      this.UnitPrice,
      this.ActualPrice,
      this.UnitName,
      this.IsAdd});

  factory VanSalesReturnItem.fromJson(Map<String, dynamic> map) => _$VanSalesReturnItemFromJson(map);

  Map<String, dynamic> toJson() => _$VanSalesReturnItemToJson(this);
}