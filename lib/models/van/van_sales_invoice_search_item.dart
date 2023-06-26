import 'package:json_annotation/json_annotation.dart';

part 'van_sales_invoice_search_item.g.dart';

@JsonSerializable()
class VanSalesInvoiceSearchItem{

  int VanSalesInvoiceID;
  String InvNo;

  String InvDate;
  String MobileNo;

  String Total;

  VanSalesInvoiceSearchItem({this.VanSalesInvoiceID, this.InvNo, this.InvDate,
    this.MobileNo, this.Total});

  factory VanSalesInvoiceSearchItem.fromJson(Map<String, dynamic> map) => _$VanSalesInvoiceSearchItemFromJson(map);

  Map<String, dynamic> toJson() => _$VanSalesInvoiceSearchItemToJson(this);
}