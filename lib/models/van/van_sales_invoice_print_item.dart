
import 'package:json_annotation/json_annotation.dart';

part 'van_sales_invoice_print_item.g.dart';

@JsonSerializable()
class VanSalesInvoicePrintItem{
  int ItemID;
  String ItemName;
  int UnitID;
  double InvoiceQty;
  double FreeQty;
  double UnitPrice;
  double ActualPrice;
  String UnitName;
  String ArabicName;
  String ArabicUnit;

  VanSalesInvoicePrintItem(
      {this.ItemID,
        this.ItemName,
        this.UnitID,
        this.InvoiceQty,
        this.FreeQty,
        this.UnitPrice,
        this.ActualPrice,
        this.UnitName, 
        this.ArabicName,
        this.ArabicUnit
        });

  factory VanSalesInvoicePrintItem.fromJson(Map<String, dynamic> map) => _$VanSalesInvoicePrintItemFromJson(map);

  Map<String, dynamic> toJson() => _$VanSalesInvoicePrintItemToJson(this);
}