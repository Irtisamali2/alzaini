import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/api_response.dart';
import '../../../models/van/van_sales_return.dart';
import '../../../models/van/van_sales_return_item.dart';
import '../../../services/van_services.dart';
import '../../../util/shared_preferences.dart';

class VanSalesReturnPage extends StatefulWidget {
  final int VanSalesInvoiceID;

  const VanSalesReturnPage({Key key, @required this.VanSalesInvoiceID}) : super(key: key);

  @override
  _VanSalesReturnPageState createState() => _VanSalesReturnPageState();
}

class _VanSalesReturnPageState extends State<VanSalesReturnPage> {

  bool _searching = true;
  // getted data   \
  VanSalesReturn _vanSalesReturnLoad = new VanSalesReturn();
  // List<VanSalesReturnItem> _vanSalesReturnDetailsList = [];

  // return list
  // VanSalesReturn _vanSalesReturnPush = new VanSalesReturn();
  List<VanSalesReturnItem> _selectedVanSalesReturnList = [];


  List<bool> _selectedItems = [];

  double _totalAmount = 0.0;
  @override
  void initState() {
    getVanSalesInvoice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sales Return',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            _searching
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                showBottomBorder: true,
                showCheckboxColumn: true,
                columns: [
                  DataColumn(label: Text('Item')),
                  DataColumn(label: Text('Quantity Invoiced')),
                  DataColumn(label: Text('Unit')),
                  DataColumn(label: Text('Quantity Returned')),
                  DataColumn(label: Text('Unit Price')),
                  DataColumn(label: Text('Total')),
                ],
                rows: _vanSalesReturnLoad.VanSalesReturnDetailsList
                    .map((model) => DataRow(
                  selected: _selectedVanSalesReturnList.contains(model),
                  onSelectChanged: (value){
                    int index = _vanSalesReturnLoad.VanSalesReturnDetailsList.indexOf(model);
                    if (model.QtyInvoiced >= _vanSalesReturnLoad.VanSalesReturnDetailsList[index].QtyReturned && _vanSalesReturnLoad.VanSalesReturnDetailsList[index].QtyReturned != 0){
                      // print(_vanSalesReturnLoad.VanSalesReturnDetailsList[index].QtyInvoiced.toString());
                      // print(_vanSalesReturnLoad.VanSalesReturnDetailsList[index].QtyInvoiced.toString());
                      // print(_vanSalesReturnLoad.VanSalesReturnDetailsList[index].ActualPrice.toString());
                      onSelectedRow(value, _vanSalesReturnLoad.VanSalesReturnDetailsList[index]);
                    }
                    else{
                      print('you cannot add');
                      _showMsg('You can return max ' + model.QtyInvoiced.toString());
                    }


                  },
                    cells: [
                  DataCell(Text(model.ItemName)),
                  DataCell(Text(model.QtyInvoiced.toString())),
                  DataCell(Text(model.UnitName)),
                  DataCell(
                    TextFormField(
                      initialValue: model.QtyReturned.toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (value){
                        int index = _vanSalesReturnLoad.VanSalesReturnDetailsList.indexOf(model);
                        if (value != '' && !value.contains(',')){
                          if (double.parse(value) <= model.QtyInvoiced){
                            _vanSalesReturnLoad.VanSalesReturnDetailsList[index].QtyReturned = double.parse(value);
                            _vanSalesReturnLoad.VanSalesReturnDetailsList[index].ActualPrice = model.UnitPrice * model.QtyReturned;
                            model.QtyReturned = double.parse(value);
                            model.ActualPrice = model.UnitPrice * model.QtyReturned;
                            // if(!mounted){
                              setState(() {

                              });
                            // }

                          }else{
                            _vanSalesReturnLoad.VanSalesReturnDetailsList[index].QtyReturned = 0;
                            _showMsg('You can return max ' + model.QtyInvoiced.toString());
                          }

                        }
                      },
                    )
                  ),
                  DataCell(Text(model.UnitPrice.toString())),
                  DataCell(Text(model.ActualPrice.toString())),
                ]))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_selectedVanSalesReturnList.length > 0) {
            bool violation = false;
            await _selectedVanSalesReturnList.forEach((element) {
              print(element.QtyReturned.toString() +  '....' + element.QtyInvoiced.toString());
              if(element.QtyReturned == 0){
                violation = true;
                print('violating 0');
              }else if(element.QtyInvoiced < element.QtyReturned){
                violation = true;
                print('violating exceed');
              }
            });
            if(!violation){
              print('every thing right');
              _vanSalesReturnAdd();
            }else{
              _showMsg('Return items exceeding invoiced qty.');
            }
            //
          } else {
            _showMsg('Add at least 1 item');
          }
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  void getVanSalesInvoice() async {
    var vanServices = VanServices();
    VanSalesReturnAPIResponse response =
        await vanServices.VanSalesInvoiceForReturn(VanSalesInvoiceID: widget.VanSalesInvoiceID);
    if (response != null) {
      if (response.data != null) {
        _vanSalesReturnLoad = VanSalesReturn.fromJson(response.data);
        // _vanSalesReturnDetailsList = _vanSalesReturnLoad.VanSalesReturnDetailsList;
        //
        print(response.data);
        _searching = false;
        setState(() {});
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

  _vanSalesReturnAdd() async {

    _totalAmount = 0.0;
    _selectedVanSalesReturnList.forEach((element) {
      _totalAmount = _totalAmount + element.ActualPrice;
    });

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String gpsLocation = position.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    VanSalesReturn vanSalesReturn = new VanSalesReturn(
        VanSalesReturnID: _vanSalesReturnLoad.VanSalesReturnID ,
      VanSalesInvoiceID: _vanSalesReturnLoad.VanSalesInvoiceID ,
      CustomerID: _vanSalesReturnLoad.CustomerID ,
      LocationID: _vanSalesReturnLoad.LocationID ,
      Reference: _vanSalesReturnLoad.Reference ,
      GPSLocation: gpsLocation,
      EmployeeID: prefs.getInt(SharedPreVariables.EMPID) ,
      TotalAmount: _totalAmount ,
      CreatedBy: prefs.getInt(SharedPreVariables.USERID) ,
      VanSalesReturnDetailsList: _selectedVanSalesReturnList ,
    );

    // print('------------------------------------');
    // print('------------------------------------');
    // print('inside _vanSalesReturnAdd Function');
    // print(_totalAmount.toString());
    // print(vanSalesReturn.VanSalesReturnID);
    // print(vanSalesReturn.VanSalesInvoiceID);
    // print(vanSalesReturn.CustomerID);
    // print(vanSalesReturn.LocationID);
    // print(vanSalesReturn.Reference);
    // print(vanSalesReturn.GPSLocation);
    // print(vanSalesReturn.EmployeeID);
    // print(vanSalesReturn.TotalAmount);
    // print(vanSalesReturn.CreatedBy);
    // print('------------------------------------');
    // print('------------------------------------');

    var vanServices = VanServices();
    var response =
    await vanServices.VanSalesReturnAdd(map: vanSalesReturn.toJson());
    if (response != null) {
      Navigator.pop(context);
      _selectedVanSalesReturnList = [];
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sales Return number: ' + response.toString())));

    } else {
      print('API response is null');
      _showMsg('Oops! Server is Down');
    }

  }

  // main logic
  void onSelectedRow(bool value, VanSalesReturnItem model) {
    setState(() {
      if (value) {
        _selectedVanSalesReturnList.add(model);
      } else {
        _selectedVanSalesReturnList.remove(model);
      }
    });
  }

}
