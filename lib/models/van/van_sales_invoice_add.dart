
import 'package:alzaini/models/van/van_sales_invoice_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'van_sales_invoice_add.g.dart';

@JsonSerializable()
class VanSalesInvoiceAdd{

  int VanSalesInvoiceID;
  int CustomerID;
  int LocationID;

  String GPSLocation;
  String Mobile;

  int EmployeeID;
  double TotalAmount;

  int CreatedBy;
  List<VanSalesInvoiceDetailsItem> VanSalesInvoiceDetailsList;

  VanSalesInvoiceAdd(
      {this.VanSalesInvoiceID,
      this.CustomerID,
      this.LocationID,
      this.GPSLocation,
      this.Mobile,
      this.EmployeeID,
      this.TotalAmount,
      this.CreatedBy,
      this.VanSalesInvoiceDetailsList});

  factory VanSalesInvoiceAdd.fromJson(Map<String, dynamic> map) => _$VanSalesInvoiceAddFromJson(map);

  Map<String, dynamic> toJson() => _$VanSalesInvoiceAddToJson(this);
}