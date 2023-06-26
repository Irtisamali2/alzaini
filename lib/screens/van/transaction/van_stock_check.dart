import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/api_response.dart';
import '../../../models/van/van_item_detail.dart';
import '../../../services/van_services.dart';
import '../../../util/shared_preferences.dart';

class VanStockCheckPage extends StatefulWidget {
  @override
  _VanStockCheckPageState createState() => _VanStockCheckPageState();
}

class _VanStockCheckPageState extends State<VanStockCheckPage> {
  VanItemDetails _scannedItem;
  bool _showItem = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stock Check',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
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
        child: _showItem
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Item ID: '),
                Text(
                  _scannedItem.ItemID.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('Unit ID: '),
                Text(
                  _scannedItem.UnitID.toString(),
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
                      _scannedItem.ItemName,
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
                    _scannedItem.ItemTypeName,
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
                  _scannedItem.SalesPrice,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('QtyOnHand: '),
                Text(
                  _scannedItem.QtyOnHand,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('UnitName: '),
                Text(
                  _scannedItem.UnitName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String _barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#ffffff', 'Cancel', true, ScanMode.BARCODE);

          vanItemDetails(_barcodeScanRes);
        },
        child: Icon(Icons.fact_check_outlined),
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
        _scannedItem = VanItemDetails.fromJson(response.data);
        setState(() {
          _showItem = true;
        });
      } else {
        _showMsg('Oops! Server is Down');
      }
    } else {
      print('API response is null');
      _showMsg('Oops! Server is Down');
    }
  }

  void _showMsg(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

