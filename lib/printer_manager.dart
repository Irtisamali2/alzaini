import 'package:flutter/services.dart';

class PrinterManager{
  static final _platform = MethodChannel(PrinterStrings.channel);

 static connect(String mac) async {
  await _platform.invokeMethod(
    PrinterStrings.connectCommand,
    {
      PrinterStrings.macArg: mac,
    },
  );
  
  // Parse the result and return the boolean value
 
}

   static disconnect(S)async{
    _platform.invokeMethod(
        PrinterStrings.disconnect,
     
    );
  }

  static printImg(String imgPath)async{
    _platform.invokeMethod(
        PrinterStrings.printCommand,
        {
          PrinterStrings.imgPathArg : imgPath
        }
    );
  }
}



class PrinterStrings {
  // channel name
  static String channel = "android.flutter/printer";
  //commands
  static String connectCommand = "printer_connect";
  static String printCommand = "printer_print";
  // arguments
  static String macArg = "printer_mac";
  static String imgPathArg = "img_path";
 static String disconnect = "disconnect_cmd";

}


