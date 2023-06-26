import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/api_response.dart';
import '../../../models/van/van_sales_return_search.dart';
import '../../../models/van/van_sales_return_search_item.dart';
import '../../../services/van_services.dart';
import '../../../util/shared_preferences.dart';

class VanReturnSearchPage extends StatefulWidget {
  @override
  _VanReturnSearchPageState createState() => _VanReturnSearchPageState();
}

class _VanReturnSearchPageState extends State<VanReturnSearchPage> {
  List<VanSalesReturnSearchItem> _vanSalesReturnList = [];
  DateTime _toDate = DateTime.now();
  DateTime _fromDate;

  bool _searching = false;
  bool _searchComplete = false;

  String _responseFromDate = '';
  String _responseToDate = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Return', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _searching
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Container(),
              _searchComplete ? ListTile(
                title: Text('From'),
                trailing: Text(_responseFromDate),
              ) :
              Container(),
              _searchComplete ? ListTile(
                title: Text('To'),
                trailing: Text(_responseToDate),
              ) :
              Container(),
              Divider(height: 14,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  showBottomBorder: true,
                  columns: [
                    DataColumn(label: Text('ReturnNo')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('InvNo')),
                    DataColumn(label: Text('Total')),
                  ],
                  rows: _vanSalesReturnList
                      .map((model) => DataRow(cells: [
                    DataCell(Text(model.ReturnNo)),
                    DataCell(Text(model.ReturnDate)),
                    DataCell(Text(model.InvNo)),
                    DataCell(Text(model.Total)),
                  ]))
                      .toList(),
                ),
              ),
              // ListView.builder(
              //     itemCount: _vanSalesInvoiceList.length,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       VanSalesInvoiceSearchItem model = _vanSalesInvoiceList[index];
              //       return ListTile(
              //         title: Text('VanSalesInvoiceID: ' +
              //             model.VanSalesInvoiceID.toString()),
              //         subtitle: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               children: [
              //                 Text('InvNo: '),
              //                 Text(model.InvNo),
              //               ],
              //             ),
              //             Row(
              //               children: [
              //                 Text('InvDate: '),
              //                 Text(model.InvDate),
              //               ],
              //             ),
              //             Row(
              //               children: [
              //                 Text('MobileNo: '),
              //                 Text(model.MobileNo),
              //               ],
              //             ),
              //             Row(
              //               children: [
              //                 Text('Total: '),
              //                 Text(model.Total),
              //               ],
              //             ),
              //           ],
              //         ),
              //       );
              //     }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('From Date:'),
                          // subtitle: _fromDate != null
                          //     ? Text(DateFormat('MM-dd-yyyy').format(_fromDate))
                          //     : Text(''),
                          trailing: IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () async {
                              final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: _fromDate != null ? _fromDate : _toDate, // Refer step 1
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                              );
                              print('picked date ${picked}' );
                              print(picked != null);

                              if (picked != null && picked != _fromDate){
                                _fromDate = picked;
                              }


                            },
                          ),
                        ),
                        ListTile(
                          title: Text('To Date:'),
                          // subtitle: Text(DateFormat('MM-dd-yyyy').format(_toDate)),
                          trailing: IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () async {
                              final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: _toDate, // Refer step 1
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                              );
                              if (picked != null && picked != _toDate)
                                _toDate = picked;
                            },
                          ),
                        ),
                        _primaryButton(context, 'Search')
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.search),
      ),
    );
  }

  Widget _primaryButton(BuildContext context, String s) {
    return GestureDetector(
      onTap: () async {
        Navigator.pop(context);
        setState(() {
          _searching = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int customerID =
        int.parse(prefs.getString(SharedPreVariables.CUSTOMERID));
        int locationID = int.parse(prefs.getString(SharedPreVariables.LOCATIONID));


        String fromDate = '';
        if (_fromDate != null){
          fromDate = DateFormat('MM-dd-yyyy').format(_fromDate);
        }
        String toDate = DateFormat('MM-dd-yyyy').format(_toDate);

        var vanServices = VanServices();
        VanSalesReturnSearchAPIResponse response =
        await vanServices.VanSalesReturnSearch(
            LocationID: locationID,
            CustomerID: customerID,
            FromDate: fromDate,
            ToDate: toDate);
        if (response != null) {
          if (response.data != null) {
            VanSalesReturnSearch vanSalesReturnSearch = VanSalesReturnSearch.fromJson(response.data);
            _vanSalesReturnList = vanSalesReturnSearch.VanSalesReturnList;
            _responseFromDate = vanSalesReturnSearch.FromDate;
            _responseToDate = vanSalesReturnSearch.ToDate;
            _searching = false;
            _searchComplete = true;
            setState(() {

            });
          } else {
            _showMsg('Oops! Server is Down');
          }
        } else {
          print('API response is null');
          _showMsg('Oops! Server is Down');
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        padding: EdgeInsets.symmetric(
          vertical: 15.0,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
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

  void _showMsg(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
