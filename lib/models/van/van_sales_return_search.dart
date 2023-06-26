
import 'package:ams_printer/models/van/van_sales_return_search_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'van_sales_return_search.g.dart';

@JsonSerializable()
class VanSalesReturnSearch{

  int CustomerID;
  int LocationID;

  String FromDate;
  String ToDate;

  int CreatedBy;

  List<VanSalesReturnSearchItem> VanSalesReturnList;

  VanSalesReturnSearch({this.CustomerID, this.LocationID, this.FromDate,
    this.ToDate, this.CreatedBy, this.VanSalesReturnList});

  factory VanSalesReturnSearch.fromJson(Map<String, dynamic> map) => _$VanSalesReturnSearchFromJson(map);

  Map<String, dynamic> toJson() => _$VanSalesReturnSearchToJson(this);

}