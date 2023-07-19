import 'package:alzaini/screens/testprint.dart';
import 'package:alzaini/screens/van/transaction/van_invoice_search.dart';
import 'package:alzaini/screens/van/transaction/van_return_search.dart';
import 'package:alzaini/screens/van/transaction/van_sales.dart';
import 'package:alzaini/screens/van/transaction/van_stock_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/van_services.dart';
import '../util/shared_preferences.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      //    final  size = MediaQuery.of(context).size;
      // debugPrint(size.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                    'assets/main_logo.png',
                    width: MediaQuery.of(context).size.width * .8,
                  )),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: [
                    _menuCard('Van Sales', context),
                    _menuCard('Search Invoice', context),
                    _menuCard('Search Return', context),
                    _menuCard('Stock Check', context),
                    _menuCard('Pending Invoices', context),
                    _menuCard('Test Print', context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuCard(String s, BuildContext context) {
    String path = '';
    if (s == 'Van Sales') {
      path = 'assets/van_sales.png';
    } else if (s == 'Search Invoice') {
      path = 'assets/search_invoice.png';
    } else if (s == 'Stock Check') {
      path = 'assets/stock_check.png';
    } else if (s == 'Search Return') {
      path = 'assets/search_invoice.png';
    } else if (s == 'Pending Invoices') {
      path = 'assets/pending.png';
    } else if (s == 'Test Print') {
      path = 'assets/print.png';
    }
    return GestureDetector(
      onTap: () {
        if (s == 'Van Sales') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SalesInvoicePage()));
        } else if (s == 'Search Invoice') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => VanInvoiceSearchPage()));
        } else if (s == 'Stock Check') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => VanStockCheckPage()));
        }
        else if (s == 'Search Return') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => VanReturnSearchPage()));
        }
        else if (s == 'Pending Invoices') {
          vanPostPendingSalesInvoice(context);
        }
        else if (s == 'Test Print') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TestPrintPage()));
        }
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(flex: 1, child: Image.asset(path, fit: BoxFit.cover)),
              SizedBox(height: 7),
              Text(s)
            ],
          ),
        ),
      ),
    );
  }

  void vanPostPendingSalesInvoice(BuildContext context) async {
    var vanService = VanServices();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String player_id = prefs.getString(SharedPreVariables.PLAYER_ID);
    String userid = prefs.getInt(SharedPreVariables.USERID).toString();

    String response = await vanService.VanPostPendingSalesInvoice(userid: userid);

    if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('AZCI: $response ')));

    } else {
      print('API response is null');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Oops! Server is Down')));

    }
  }

}
