import 'package:ams_printer/models/van/van_sales_invoice_print_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'van_sales_invoice_print.g.dart';

@JsonSerializable()
class VanSalesInvoicePrintModel{

  int VanSalesInvoiceID;
  int CustomerID;
  int LocationID;

  String InvoiceNo;
  String Mobile;

  int EmployeeID;
  String Phone;

  String Date;


  double Discount;
  double TotalAmount;

  List<VanSalesInvoicePrintItem> VanSalesInvoiceDetailsList;


  VanSalesInvoicePrintModel(
      {this.VanSalesInvoiceID,
      this.CustomerID,
      this.LocationID,
      this.InvoiceNo,
      this.Mobile,
      this.EmployeeID,
      this.Phone,
      this.Date,
      this.Discount,
      this.TotalAmount,
      this.VanSalesInvoiceDetailsList});

  factory VanSalesInvoicePrintModel.fromJson(Map<String, dynamic> map) => _$VanSalesInvoicePrintModelFromJson(map);

  Map<String, dynamic> toJson() => _$VanSalesInvoicePrintModelToJson(this);


}