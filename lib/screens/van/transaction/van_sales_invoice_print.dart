import 'dart:io';
import 'dart:typed_data';
import 'package:alzaini/printersview.dart';
import 'package:alzaini/util/dimensions.dart';
import 'package:alzaini/util/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
//  bool isScanning = true;
//    FlutterScanBluetooth _scanBluetooth;
//    List<BluetoothDevice> _devices;
  BluetoothDevice _selectedDevice;
      File imgFile;

  ScreenshotController _screenshotController;
  String formattedDate;

   
    // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

      print(widget.VanSalesInvoiceID.toString());
    getVanSalesInvoice();
    // _devices = [];
    // _scanBluetooth = FlutterScanBluetooth();
    // _startScan();
    // _initImg();
      _screenshotController = ScreenshotController();

    
  }



  // _startScan() async {
  //   setState(() {
  //     isScanning = true;
  //   });
  //   await _scanBluetooth.startScan();

  //   _scanBluetooth.devices.listen((dev) {
  //     if(! _isDeviceAdded(dev)){
  //       setState(() {
  //         _devices.add(dev);
  //       });
  //     }
  //   });

  //   await Future.delayed(const Duration(seconds: 5));
  //   setState(() {
  //         _stopScan();

  //   });
  // }

  // _stopScan() {
    
  //   _scanBluetooth.stopScan();
  //   setState(() {
  //     isScanning = false;
  //   });
  // }

  // bool _isDeviceAdded(BluetoothDevice device) => _devices.contains(device);
      Future<dynamic> _captureAndSaveScreenshot() async {
 final Uint8List imageBytes = await _screenshotController.capture();
      final String path = (await getExternalStorageDirectory()).path;
      // Create a file with a unique name
        final imagePath = '${path}/screenshot.png';
    if (imageBytes != null) {
      // Get the temporary directory path


       imgFile = File(imagePath);
      // Write the image bytes to the file
      await imgFile.writeAsBytes(imageBytes);
    }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("No image taken",
  style: TextStyle(fontSize: 14,)),backgroundColor: Colors.red,action: SnackBarAction(label: 'Ok', onPressed: (){},textColor: Colors.white,),));
    }

         // Scroll the table to ensure all rows are visible
    // _scrollController.animateTo(
    //   _scrollController.position.maxScrollExtent,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );

    // Delay to wait for the table to scroll
    // await Future.delayed(const Duration(milliseconds: 500));

    // Capture the screenshot
  //   final image = await _screenshotController.capture(delay: const Duration(milliseconds: 10));

  //     final directory =   await getExternalStorageDirectory(); //await getExternalStorageDirectory();
  // final imagePath = '${directory.path}/screenshot.png';

  //  imgFile = File(imagePath);
  // await imgFile.writeAsBytes(image);

  // final storagePermissionStatus = await Permission.storage.status;
  // if (storagePermissionStatus.isGranted) {
  //   // Save the image to the device storage
  //   await file.copy('${directory.path}/screenshot.png');

  //   // Show a success message or handle any further actions
  // } else {
  //   // Handle permission denied case
  // }

    

    return imagePath;
  }

_initImg() async {
    try {
      

         final image = await _screenshotController.capture(delay: const Duration(seconds: 2));
showmessages('Captured');
 await Future.delayed(const Duration(microseconds: 10));

      final directory =   await getApplicationDocumentsDirectory(); //await getExternalStorageDirectory();

showmessages('get path');
 await Future.delayed(const Duration(microseconds: 10));


  final imagePath = '${directory.path}/screenshot.jpg';
  showmessages('opening path');
 await Future.delayed(const Duration(microseconds: 10));
 imgFile = File(imagePath);
   showmessages('writing on path');
 await Future.delayed(const Duration(microseconds: 10));
  await imgFile.writeAsBytes(image);
     showmessages('done');
 await Future.delayed(const Duration(microseconds: 10));
  // File imageFile = File(imgFile2.path);
     // ByteData byteData = await Image.file(File(imgFile2.path));


    //  List<int> bytes = await imageFile.readAsBytes();


    //   Uint8List buffer = Uint8List.fromList(bytes);  // byteData.buffer.asUint8List();


    //   String path = (await getTemporaryDirectory()).path;

    //   imgFile = File("$path/img.png");


    //   imgFile.writeAsBytes(buffer);


    } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar( duration: const Duration(milliseconds: 10),content:  Text(e.toString(),
  style: const TextStyle(fontSize: 14,)),backgroundColor: Colors.red,action: SnackBarAction(label: 'Ok', onPressed: (){},textColor: Colors.white,),));
      rethrow;
    }
  }


  void showmessages(String e){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: const Duration(milliseconds: 10),content:  Text(e,
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
                // 'Connect to Device',
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
      body: Screenshot(
        controller: _screenshotController,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: _searching
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Center(
                    child: Image.asset(
                      'assets/slogo.jpg',
                      width: 90.h,
                      height: 90.h,
                      fit: BoxFit.contain,
                    ),
                  ),
      
                  personalDetailTile(
                      arblabel: 'هاتف',
                      englabel: 'Phone',
                      title: vanSalesInvoicePrint.Phone),
                  personalDetailTile(
                      englabel: 'Date',
                      title: formattedDate,
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
                    child: Table(
        defaultColumnWidth: FixedColumnWidth(62.w), // Adjust the column width as needed
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border:  TableBorder(
          horizontalInside: BorderSide(width: 1.0, color: Colors.black.withOpacity(0.3)), // Apply a bottom border
          bottom: BorderSide(width: 1.0, color: Colors.black.withOpacity(0.3)), // Apply a bottom border
      
        ),  
         columnWidths: const {
          0: FlexColumnWidth(), // Use flex width for the first column to allow automatic width distribution
        },
        children: [
          TableRow(
        children: [
          TableCell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
              Text('الصنف',              style:  TextStyle(fontSize: 13.sp,fontWeight: FontWeight.bold),
      ),
              Text('ITEM',              style:  TextStyle(fontSize: 13.sp,fontWeight: FontWeight.bold),
      ),
              ],
            ),
          ),
          TableCell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
      
              children:  [
              Text('الوحدة',              style:  TextStyle(fontSize:  13.sp,fontWeight: FontWeight.bold),
      ),
              Text('UNIT',              style:  TextStyle(fontSize:  13.sp,fontWeight: FontWeight.bold),
      ),
              ],
            ),
          ),
          TableCell(
            child: Column(
      
              children:  [
              Text('الكمية',              style:  TextStyle(fontSize:  13.sp,fontWeight: FontWeight.bold),
      ),
              Text('QTY',              style:  TextStyle(fontSize:  13.sp,fontWeight: FontWeight.bold),
      ),
              ],
            ),
          ),
          TableCell(
            child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
      
              children:  [
              Text('السعر',              style:  TextStyle(fontSize:  13.sp,fontWeight: FontWeight.bold),
      ),
              Text('PRICE',              style:  TextStyle(fontSize:  13.sp,fontWeight: FontWeight.bold),
      ),
              ],
            ),
          ),
          TableCell(
            child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
      
              children:  [
              Text('المجموع',  
              style:  TextStyle(fontSize: 13.sp,fontWeight: FontWeight.bold),
      ),
              Text('AMOUNT',          
                style:  TextStyle(fontSize: 13.sp,fontWeight: FontWeight.bold),
      ),
              ],
            ),
          ),
        ],
          ),
          for (final model in vanSalesInvoicePrint.VanSalesInvoiceDetailsList)
           
        TableRow(
          children: [
            TableCell(
              child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 3.h),
              child: Text(
                '${model.ArabicName} ${model.ItemName}',
                style:  TextStyle(fontSize: 12.sp),
              ),
              ),
            ),
            TableCell(
              child: Padding(
              padding:  EdgeInsets.only(left: 10.h,top: 3.h,bottom: 3.h),
              child: Text(
                '${model.ArabicUnit} ${model.UnitName}',
                style:  TextStyle(fontSize:  12.sp),
              ),
              ),
            ),
            TableCell(
              child: Padding(
              padding:  EdgeInsets.only(left:22.h,top: 3.h,bottom: 3.h),
              child: Text(
                model.InvoiceQty.toString(),
                style:  TextStyle(fontSize:  12.sp),
              ),
              ),
            ),
            TableCell(
              child: Padding(
              padding:  EdgeInsets.only(left: 20.h,top: 3.h,bottom: 3.h),
              child: Text(
                model.UnitPrice.toString(),
                style:  TextStyle(fontSize:  12.sp),
              ),
              ),
            ),
            TableCell(
              child: Padding(
              padding:  EdgeInsets.only(left: 10.h,top:3.h,bottom: 3.h),
              child: Text(
                model.ActualPrice.toString(),
                style:  TextStyle(fontSize: 12.sp),
              ),
              ),
            ),
          ],
        ),
        ],
      )
      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("خصم - Discount :  " +
                          vanSalesInvoicePrint.Discount.toString(),
                          style:  TextStyle(fontSize: 16.sp),
                          ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("مجموع - Total :  " +
                          vanSalesInvoicePrint.TotalAmount.toString(),
                        style:  TextStyle(fontSize: 16.sp),
      
                          ),
                    ],
                  ),
                  Text('شکرًالتسوفکم',style:  TextStyle(fontSize: 16.sp)),
                  Text("Thank you for shopping.",style:  TextStyle(fontSize:16.sp)),
                  
                    ],
                  ),
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            setState(() {
              
            });
                   // Capture and save the screenshot
          if (isConnectedG)  {
  var status = await Permission.storage.request();

             if (status.isGranted) {
    // Permission granted, proceed with capturing and saving the screenshot
          await _initImg();
              // final imagePath = await _captureAndSaveScreenshot();
                          if(imgFile.path !=null){

              try{
              // final file = File(imagePath);
              // await file.delete();
              
                            PrinterManager.printImg(imgFile.path);

              } catch(e){
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text(e.toString(),
  style: const TextStyle(fontSize: 14,)),backgroundColor: Colors.red,action: SnackBarAction(label: 'Ok', onPressed: (){},textColor: Colors.white,),));
              }
              }
  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Storage permission denied",
  style: TextStyle(fontSize: 14,)),backgroundColor: Colors.red,action: SnackBarAction(label: 'Ok', onPressed: (){},textColor: Colors.white,),));  }
      
            
              
          
             
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
                        // Parse the string into a DateTime object
  DateTime dateTime = DateFormat('M/d/yyyy hh:mm:ss a').parse(vanSalesInvoicePrint.Date);

  // Extract the date part from the DateTime object
  DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day);
   // Format the date as a string
   formattedDate = DateFormat('M/d/yyyy').format(date);

  // Format the date as a string
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

   
    Widget _buildDev(BluetoothDevice dev) => GestureDetector(
        onTap: () {
          setState(() {
            _selectedDevice = dev;
            if(_selectedDevice.address!=null){
            PrinterManager.connect(_selectedDevice.address) ;

            }
          });
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.125),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(dev.name,
                  style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text(dev.address,
                  style: const TextStyle(color: Colors.grey, fontSize: 14))
            ],
          ),
        ),
      );

  //      void showSimpleDialog(BuildContext context) {
   

  //     showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //    builder: (BuildContext context, StateSetter setState) {

  //         return FractionallySizedBox(
  //           widthFactor: 0.8,
  //           heightFactor: 0.9,
  //           child: AlertDialog(
  //             title: const Text('Search For Devices'),
  //             content: SingleChildScrollView(
  //               child: Column(
  //                 children: [
  //                   isScanning ?  const  CircularProgressIndicator(
  //               color: Colors.lightBlue,
  //                   ):
            
  //             FloatingActionButton(
  //               onPressed: () {
  //                 setState(() {
  //                _startScan();
        
  //                 });
              
                  
  //               },
  //               child: const Icon(
  //                 Icons.bluetooth_audio,
  //               ),
  //             ),
             
  //                  SingleChildScrollView(
  //                   child: Column(
  //                     children: [
                        
        
  //                 SizedBox(
  //                   height: 300, // Set the desired height here
  //                   child: ListView(
  //                     scrollDirection: Axis.vertical,
  //                     children: <Widget>[
  //                       ListView.builder(
  //                         itemCount: _devices.length,
  //                         itemBuilder: (context, index) {
  //                           var dev = _devices[index];
  //                           return _buildDev(dev);
  //                         },
  //                         shrinkWrap: true,
  //                         physics: const NeverScrollableScrollPhysics(), // Disable scrolling of inner ListView
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //                                       //      ..._devices.map(
  //                   //   (dev) => _buildDev(dev),
                      
  //                   // )
  //                     ],
  //                   ),
  //                  )
  //                 ],
  //               ),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   // Perform an action here
  //                   Navigator.of(context).pop(); // Close the dialog
  //                 },
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //           ),
  //         );
  //    }
  //       );
  //     },
  //   );
  // }

   Widget personalDetailTile(
      {@required String englabel,
      @required String title,
      @required String arblabel}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$englabel : ", textAlign: TextAlign.left,
          style:  TextStyle(fontSize: 16.sp)
          //  + vanSalesInvoicePrint.Phone
          // + ' : هاتف'
        ),
        Text(title,
        style:  TextStyle(fontSize: 16.sp)
            // + ' : هاتف'
            ),
        Text(
          ' : $arblabel',
          style:  TextStyle(fontSize: 16.sp),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

}
