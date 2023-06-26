import 'package:ams_printer/models/van/van_sales_invoice_search_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'van_sales_invoice_search.g.dart';

@JsonSerializable()
class VanSalesInvoiceSearch{

  int CustomerID;
  int EmployeeID;

  String FromDate;
  String ToDate;

  int CreatedBy;

  List<VanSalesInvoiceSearchItem> VanSalesInvoiceList;

  VanSalesInvoiceSearch({this.CustomerID, this.EmployeeID, this.FromDate,
    this.ToDate, this.CreatedBy, this.VanSalesInvoiceList});

  factory VanSalesInvoiceSearch.fromJson(Map<String, dynamic> map) => _$VanSalesInvoiceSearchFromJson(map);

  Map<String, dynamic> toJson() => _$VanSalesInvoiceSearchToJson(this);

}