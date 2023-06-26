import 'dart:io';
import 'dart:typed_data';
import 'package:ams_printer/printersview.dart';
import 'package:ams_printer/util/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../../models/api_response.dart';
import '../../../models/van/van_sales_invoice_print.dart';
import '../../../printer_manager.dart';
import '../../../services/van_services.dart';



class VanSalesInvoicePrint extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final int VanSalesInvoiceID;

  // ignore: non_constant_identifier_names
  const VanSalesInvoicePrint({Key key, @required this.VanSalesInvoiceID})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VanSalesInvoicePrintState createState() => _VanSalesInvoicePrintState();
}

class _VanSalesInvoicePrintState extends State<VanSalesInvoicePrint> {
  bool _searching = true;
  VanSalesInvoicePrintModel vanSalesInvoicePrint =
      VanSalesInvoicePrintModel();

  BluetoothDevice _selectedDevice;
      File imgFile;

  ScreenshotController _screenshotController;
   

  @override
  void initState() {
    super.initState();

    getVanSalesInvoice();
 
      _screenshotController = ScreenshotController();

    
  }




_initImg() async {
    try {

         final image = await _screenshotController.capture(delay: const Duration(seconds: 2));


      final directory =   await getExternalStorageDirectory(); //await getExternalStorageDirectory();

 await Future.delayed(const Duration(seconds: 2));
showmessages('get external path');

  final imagePath = '${directory.path}/screenshot.png';

  final File imgFile2 = File(imagePath);
  await imgFile2.writeAsBytes(image);
  File imageFile = File(imgFile2.path);
  showmessages('written on external path');

 await Future.delayed(const Duration(seconds: 3));

     List<int> bytes = await imageFile.readAsBytes();


      Uint8List buffer = Uint8List.fromList(bytes); 

      String path = (await getTemporaryDirectory()).path;

      imgFile = File("$path/img.png");

      imgFile.writeAsBytes(buffer);
      showmessages('Printed');


    } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text(e.toString(),
  style: const TextStyle(fontSize: 14,)),backgroundColor: Colors.red,action: SnackBarAction(label: 'Ok', onPressed: (){},textColor: Colors.white,),));
      rethrow;
    }
  }
void showmessages(String e){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text(e,
  style: const TextStyle(fontSize: 14,)),backgroundColor: Colors.green,action: SnackBarAction(label: 'Ok', onPressed: (){},textColor: Colors.white,),));
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Print Invoice',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Search Available Devices',
                // 'Discount from Device'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding:const EdgeInsets.all(10),
        child: _searching
            ?const Center(
                child: CircularProgressIndicator(),
              )
            : Screenshot(
              controller: _screenshotController,
              child: Container(
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Center(
                    child: Image.asset(
                      'assets/slogo.jpg',
                      width: 98,
                      height: 98,
                      fit: BoxFit.contain,
                    ),
                  ),

                  personalDetailTile(
                      arblabel: 'هاتف',
                      englabel: 'Phone',
                      title: vanSalesInvoicePrint.Phone),
                  personalDetailTile(
                      englabel: 'Date',
                      title: vanSalesInvoicePrint.Date,
                      arblabel: 'تاريخ'),
                  personalDetailTile(
                      englabel: 'Invoice#',
                      title: vanSalesInvoicePrint.InvoiceNo,
                      arblabel: 'فاتورة'),
                  personalDetailTile(
                      englabel: 'Mobile',
                      title: vanSalesInvoicePrint.Mobile,
                      arblabel: 'جوال'),
    
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      horizontalMargin: 0,
                      showBottomBorder: true,
                      dataRowHeight: MediaQuery.of(context).size.height *0.075,
                      columnSpacing: MediaQuery.of(context).size.height *0.035,
                      columns: [
                        DataColumn(
                            label: Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('الصنف'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('ITEM'),
                            ),
                          ],
                        )),
                        DataColumn(
                            label: Column(
                          children: const[
                            Text('الوحدة'),
                            Text('UNIT'),
                          ],
                        )),
                        DataColumn(
                            label: Column(
                          children: const [
                            Text('الكمية'),
                            Text('QTY'),
                          ],
                        )),
                        DataColumn(
                            label: Column(
                          children: const [
                            Text('السعر'),
                            Text('PRICE'),
                          ],
                        )),
                        DataColumn(
                            label: Column(
                          children: const [
                            Text('المجموع'),
                            Text('AMOUNT'),
                          ],
                        )),
                      ],
                      rows: vanSalesInvoicePrint.VanSalesInvoiceDetailsList.map(
                          (model) => DataRow(cells: [
                            
                              DataCell(
                                    Container(
                                      margin:const EdgeInsets.symmetric(horizontal: 10), // Adjust padding as needed
                                      alignment: Alignment.centerLeft, // Adjust alignment as needed
                                      child: Text('${model.ArabicName} ${model.ItemName}'),
                                    ),
                                  ), DataCell(Text('${model.ArabicUnit} ${model.UnitName}')),
                                DataCell(Text(model.InvoiceQty.toString())),
                                DataCell(Text(model.UnitPrice.toString())),
                                DataCell(Text(model.ActualPrice.toString())),
                              ])).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Discount : " +
                          vanSalesInvoicePrint.Discount.toString() +
                          ':خصم'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Total : " +
                          vanSalesInvoicePrint.TotalAmount.toString() +
                          ':مجموع'),
                    ],
                  ),
                  Text('شکرًالتسوفکم'),
                  Text("Thank you for shopping."),
                    ],
                  ),
              ),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            setState(() {
              
            });
          if (isConnectedG)  {
            await _initImg();
                          if(imgFile.path !=null){

              try{
         
              
                 PrinterManager.printImg(imgFile.path);

              } catch(e){
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text(e.toString(),
  style: const TextStyle(fontSize: 14,)),backgroundColor: Colors.red,action: SnackBarAction(label: 'Ok', onPressed: (){},textColor: Colors.white,),));
              }
              }
            
              
          
             
}else{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Please Connect Printer First",
  style: TextStyle(fontSize: 14,)),backgroundColor: Colors.red,action: SnackBarAction(label: 'Ok', onPressed: (){},textColor: Colors.white,),));
}

   
        },
        child: const Icon(Icons.print),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Search Available Devices':
        if (Platform.isAndroid) {
    
          Navigator.push(context, MaterialPageRoute(builder: (_)=> const PrintersView()));
        }
        break;
  
      case 'Discount from Device':
        if (Platform.isAndroid) {
          // var methodChannel = MethodChannel("com.paakhealth.sdk_base");
          // methodChannel.invokeMethod("disconnectBle");
        }
        break;
    }
  }

  void getVanSalesInvoice() async {
    var vanServices = VanServices();
    VanSalesReturnAPIResponse response = await vanServices.VanSalesInvoiceView(
        VanSalesInvoiceID: widget.VanSalesInvoiceID);

    if (response != null) {
      if (response.data != null) {
        vanSalesInvoicePrint =
            VanSalesInvoicePrintModel.fromJson(response.data);
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
   
  
    Widget personalDetailTile(
      {@required String englabel,
      @required String title,
      @required String arblabel}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$englabel : ", textAlign: TextAlign.left,
          //  + vanSalesInvoicePrint.Phone
          // + ' : هاتف'
        ),
        Text(title
            // + ' : هاتف'
            ),
        Text(
          ' : $arblabel',
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

}
