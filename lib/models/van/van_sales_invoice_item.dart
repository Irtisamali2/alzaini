import 'package:json_annotation/json_annotation.dart';

part 'van_sales_invoice_item.g.dart';

@JsonSerializable()
class VanSalesInvoiceDetailsItem{
  int ItemID;
  String ItemName;
  int UnitID;
  int InvoiceQty;
  int FreeQty;
  double UnitPrice;
  double ActualPrice;
  String UnitName;

  VanSalesInvoiceDetailsItem(
      {this.ItemID,
      this.ItemName,
      this.UnitID,
      this.InvoiceQty,
      this.FreeQty,
      this.UnitPrice,
      this.ActualPrice,
      this.UnitName});

  factory VanSalesInvoiceDetailsItem.fromJson(Map<String, dynamic> map) => _$VanSalesInvoiceDetailsItemFromJson(map);

  Map<String, dynamic> toJson() => _$VanSalesInvoiceDetailsItemToJson(this);
}