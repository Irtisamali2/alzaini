
import 'package:alzaini/models/van/van_sales_return_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'van_sales_return.g.dart';

@JsonSerializable()
class VanSalesReturn{

  int VanSalesReturnID;
  int VanSalesInvoiceID;

  int CustomerID;
  int LocationID;

  String Reference;
  String GPSLocation;

  int EmployeeID;
  double TotalAmount;

  int CreatedBy;

  List<VanSalesReturnItem> VanSalesReturnDetailsList;

  VanSalesReturn(
      {this.VanSalesReturnID,
      this.VanSalesInvoiceID,
      this.CustomerID,
      this.LocationID,
      this.Reference,
      this.GPSLocation,
      this.EmployeeID,
      this.TotalAmount,
      this.CreatedBy,
      this.VanSalesReturnDetailsList});


  factory VanSalesReturn.fromJson(Map<String, dynamic> map) => _$VanSalesReturnFromJson(map);

  Map<String, dynamic> toJson() => _$VanSalesReturnToJson(this);
}