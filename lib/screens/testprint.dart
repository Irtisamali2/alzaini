import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestPrintPage extends StatefulWidget {
  @override
  _TestPrintPageState createState() => _TestPrintPageState();
}

class _TestPrintPageState extends State<TestPrintPage> {

  String _response = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Printer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              _response,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Connect'),
                  onPressed: () async {
                    if(Platform.isAndroid){
                      var methodChannel = MethodChannel("com.paakhealth.sdk_base");
                      String data = await methodChannel.invokeMethod("connectBle");
                      if (data != null && data.isNotEmpty){
                        setState(() {

                          _response = data;
                        });
                      }
                    }
                  },
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  child: Text('Disconnect'),
                  onPressed: () async {
                    if(Platform.isAndroid){
                      var methodChannel = MethodChannel("com.paakhealth.sdk_base");
                      String data = await methodChannel.invokeMethod("disconnectBle");
                      if (data != null && data.isNotEmpty){
                        setState(() {

                          _response = data;
                        });
                      }
                    }
                  },
                ),
              ],
            ),

            SizedBox(height: 50,),
            Center(
              child: ElevatedButton(
                child: Text('Test Print'),
                onPressed: () async {
                  if(Platform.isAndroid){
                    var methodChannel = MethodChannel("com.paakhealth.sdk_base");
                    String data = await methodChannel.invokeMethod("testPrint");
                    if (data != null && data.isNotEmpty){
                      setState(() {

                        _response = data;
                      });
                    }
                  }
                },
              ),

            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(Platform.isAndroid){
            var methodChannel = MethodChannel("com.paakhealth.sdk_base");
            String data = await methodChannel.invokeMethod("searchBle");
            if (data != null && data.isNotEmpty){
              setState(() {

                _response = data;
              });
            }
          }
        },
        tooltip: 'Search',
        child: Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
