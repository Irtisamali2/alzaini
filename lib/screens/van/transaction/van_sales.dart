import 'dart:io';
import 'package:ams_printer/screens/van/transaction/van_sales_invoice_print.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/api_response.dart';
import '../../../models/van/van_item_detail.dart';
import '../../../models/van/van_sales_invoice_add.dart';
import '../../../models/van/van_sales_invoice_item.dart';
import '../../../services/van_services.dart';
import '../../../util/shared_preferences.dart';

class SalesInvoicePage extends StatefulWidget {
  @override
  _SalesInvoicePageState createState() => _SalesInvoicePageState();
}

class _SalesInvoicePageState extends State<SalesInvoicePage> {
  VanItemDetails _scannedItem;

  GlobalKey<FormState> _key = new GlobalKey<FormState>();

  TextEditingController _qtyController = new TextEditingController();
  TextEditingController _subtotalController = new TextEditingController();

  List<VanSalesInvoiceDetailsItem> _vanSalesInvoiceDetailsList = [];

  double _totalAmount = 0.0;

  TextEditingController _phoneController = new TextEditingController();

  bool _processing = false;
  bool showAdd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sales Invoice',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.camera_enhance),
              onPressed: () async {
                String _barcodeScanRes =
                    await FlutterBarcodeScanner.scanBarcode(
                        '#ffffff', 'Cancel', true, ScanMode.BARCODE);

                vanItemDetails(_barcodeScanRes);
              }),
          IconButton(
              icon: Icon(Icons.title),
              onPressed: () async {
                String _barcodeScanRes = '';
                TextEditingController controller = new TextEditingController();
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text('Enter the barcode'),
                  content: TextFormField(
                    controller: controller,
                  ),
                  actions: [
                    ElevatedButton(
                      child: Text('OK'),
                      onPressed: () {
                        if(controller.text.isNotEmpty){
                          Navigator.of(context).pop();
                          _barcodeScanRes = controller.text;
                          vanItemDetails(_barcodeScanRes);
                        }
                      },
                    ),
                    ElevatedButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
              }),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: _processing
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  ListView.builder(
                      itemCount: _vanSalesInvoiceDetailsList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        VanSalesInvoiceDetailsItem model =
                            _vanSalesInvoiceDetailsList[index];
                        return ListTile(
                          title: Text(model.ItemName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Unit Name: '),
                                  Text(model.UnitName.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Unit Price: '),
                                  Text(model.UnitPrice.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Invoice Quantity: '),
                                  Text(model.InvoiceQty.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Actual Price: '),
                                  Text(model.ActualPrice.toString()),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_vanSalesInvoiceDetailsList.length > 0) {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            _phoneField('Mobile: '),
                            TextButton(
                                onPressed: () {
                                  if (_key.currentState.validate()) {
                                    setState(() {
                                      _processing = true;
                                    });
                                    _vanSalesInvoiceAdd();
                                  }
                                },
                                child: Text('Process'))
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            _showMsg('Add at least 1 item');
          }
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Future<void> vanItemDetails(String barcodeScanRes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String locationId = prefs.getString(SharedPreVariables.LOCATIONID);
    var vanServices = VanServices();
    VanItemDetailsAPIResponse response = await vanServices.VanItemDetails(
        locationId: locationId, barcode: barcodeScanRes);
    if (response != null) {
      if (response.data != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.data.toString())));
        _scannedItem = VanItemDetails.fromJson(response.data);
        _scannedItemCard(_scannedItem);
        // setState(() {
        //   showItem = true;
        // });
      } else {
        _showMsg('Oops! Server is Down');
      }
    } else {
      print('API response is null');
      _showMsg('Oops! Server is Down');
    }
  }

  void _showMsg(String message) {
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text(message)));
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
    );
  }

  _scannedItemCard(VanItemDetails itemDetails) {
    double maxQty = double.parse(itemDetails.QtyOnHand);
    double salesPrice = double.parse(itemDetails.SalesPrice);
    _qtyController.text = '1';
    _subtotalController.text = itemDetails.SalesPrice;
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Item ID: '),
                      Text(
                        itemDetails.ItemID.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Unit ID: '),
                      Text(
                        itemDetails.UnitID.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Item Name: '),
                      Expanded(
                        child: Container(
                          color: Colors.yellow,
                          child: Text(
                            itemDetails.ItemName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ItemTypeName: '),
                      Expanded(
                        child: Text(
                          itemDetails.ItemTypeName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('SalesPrice: '),
                      Text(
                        itemDetails.SalesPrice,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('QtyOnHand: '),
                      Text(
                        itemDetails.QtyOnHand,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('UnitName: '),
                      Text(
                        itemDetails.UnitName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Text('How Many Items: ')),
                        Expanded(
                          child: TextFormField(
                            controller: _qtyController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                            decoration: InputDecoration(
                              fillColor: Colors.blue[100],
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                              ),
                              enabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            validator: (arg) {
                              if (arg != null && arg.isNotEmpty) {
                                if(arg == '.' || arg.contains(',')){
                                  arg = '0';
                                }
                                double arg_double = double.parse(arg);
                                if (maxQty >= arg_double) {

                                  print("maxQty");
                                  print(maxQty);
                                  print("maxQty");

                                  _subtotalController.text =
                                      (arg_double * salesPrice).toString();

                                  return null;
                                }else{
                                  return 'Not Available';
                                }
                              }
                              return null;
                            },
                            onFieldSubmitted: (arg){
                              if(arg != '.' || arg.contains(',')){
                                print(arg);
                                double arg_double =
                                double.parse(arg);
                                if (maxQty >= arg_double) {
                                  _subtotalController.text =
                                      (arg_double * salesPrice).toString();
                                  return null;
                                }
                              }

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Subtotal Price: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: _subtotalController,
                          keyboardType: TextInputType.number,
                          enabled: false,
                          decoration: InputDecoration(
                              fillColor: Colors.grey, filled: true),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Center(
                      child: _addtoListButton(
                          context, 'Add to List', itemDetails))
                ],
              ),
            ),
          );
        });
  }


  InkWell _addtoListButton(
      BuildContext context, String s, VanItemDetails itemDetails) {
    return InkWell(
      onTap: () async {
        double demand = 0;
        if(_qtyController.text == '.'){
          _showMsg('Select proper quantity');
        }
        else if(_qtyController.text == '0'){
          _showMsg('Select at least one.');
        }
        else if (_qtyController.text.contains(',')){
          _showMsg('Remove comma.');
        }
        else if (_qtyController.text.isEmpty){
          _showMsg('Select proper quantity');
        }
        else if (double.parse(_qtyController.text) > 0 ){
          demand = double.parse(_qtyController.text);
          if (double.parse(itemDetails.QtyOnHand) >= demand){

            double actualPrice = double.parse(itemDetails.SalesPrice) *
                int.parse(_qtyController.text);

            VanSalesInvoiceDetailsItem model = new VanSalesInvoiceDetailsItem(
                ItemID: itemDetails.ItemID,
                ItemName: itemDetails.ItemName,
                UnitID: itemDetails.UnitID,
                InvoiceQty: int.parse(_qtyController.text),
                FreeQty: 5,
                UnitPrice: double.parse(itemDetails.SalesPrice),
                ActualPrice: actualPrice,
                UnitName: itemDetails.UnitName);

            if (_vanSalesInvoiceDetailsList.length > 0) {
              bool notAdded = true;
              for (var i = 0; i < _vanSalesInvoiceDetailsList.length; i++) {
                if (_vanSalesInvoiceDetailsList[i].ItemID == model.ItemID &&
                    _vanSalesInvoiceDetailsList[i].UnitID == model.UnitID) {
                  _vanSalesInvoiceDetailsList[i].InvoiceQty =
                      _vanSalesInvoiceDetailsList[i].InvoiceQty + model.InvoiceQty;
                  double actualPricee =
                      model.UnitPrice * _vanSalesInvoiceDetailsList[i].InvoiceQty;

                  _vanSalesInvoiceDetailsList[i].ActualPrice = actualPricee;
                  notAdded = false;
                }
              }
              if (notAdded) {
                _vanSalesInvoiceDetailsList.add(model);
              }
            } else {
              _vanSalesInvoiceDetailsList.add(model);
            }

            setState(() {});
            Navigator.pop(context);

          }
          else{
            _showMsg('Out of Stock');
          }
        }





      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 7.0,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.lightBlueAccent),
        child: Column(
          children: [
            Text(
              s,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _phoneField(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _phoneController,
          validator: (arg) {
            if (arg.length == 9)
              return null;
            else {
              return 'Enter Valid Phone Number';
            }
          },
          keyboardType: TextInputType.number,
          maxLength: 9,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            enabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            prefixText: '+97',
          ),
        ),
      ],
    );
  }

  _vanSalesInvoiceAdd() async {
    _totalAmount = 0.0;
    _vanSalesInvoiceDetailsList.forEach((element) {
      _totalAmount = _totalAmount + element.ActualPrice;
    });

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String gpsLocation = position.toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    VanSalesInvoiceAdd vanSalesInvoiceAdd = new VanSalesInvoiceAdd(
        VanSalesInvoiceID: 0,
        CustomerID: int.parse(prefs.getString(SharedPreVariables.CUSTOMERID)),
        LocationID: int.parse(prefs.getString(SharedPreVariables.LOCATIONID)),
        GPSLocation: gpsLocation,
        Mobile: '+97' + _phoneController.text,
        EmployeeID: prefs.getInt(SharedPreVariables.EMPID),
        TotalAmount: _totalAmount,
        CreatedBy: prefs.getInt(SharedPreVariables.USERID),
        VanSalesInvoiceDetailsList: _vanSalesInvoiceDetailsList);

    // print(vanSalesInvoiceAdd.toJson());

    var vanServices = VanServices();
    var response =
        await vanServices.VanSalesInvoiceAdd(map: vanSalesInvoiceAdd.toJson());
    if (response != null) {
      Navigator.pop(context);
      _vanSalesInvoiceDetailsList = [];
      _phoneController.text = '';
      _processing = false;
      setState(() {});

      // returned vanSalesInvoiceID from api response to print the receipt
      int vanSalesInvoiceID = int.parse(response.toString());

      print('----------------------');
      print('vanSalesInvoiceID: ' + response.toString());
      print('----------------------');

      // print the receipt
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VanSalesInvoicePrint(VanSalesInvoiceID: vanSalesInvoiceID)));
    } else {
      print('API response is null');
      _showMsg('Oops! Server is Down');
    }
  }
}
