
import 'package:alzaini/printer_manager.dart';
import 'package:alzaini/util/global.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';

class PrintersView extends StatefulWidget {
  const PrintersView({Key key}) : super(key: key);

  @override
  State<PrintersView> createState() => _PrintersViewState();
}

class _PrintersViewState extends State<PrintersView> {
   FlutterScanBluetooth _scanBluetooth;
   List<BluetoothDevice> _devices;
  BluetoothDevice _selectedDevice;

  bool isScanning = true;

  @override
  void initState() {
    super.initState();
    _devices = [];
    _scanBluetooth = FlutterScanBluetooth();
    _startScan();
  }


  _startScan() async {
    if(mounted){
    setState(() {
      isScanning = true;
    });}
    await _scanBluetooth.startScan();

    _scanBluetooth.devices.listen((dev) {
      if(! _isDeviceAdded(dev)){
if(mounted){
        setState(() {
          _devices.add(dev);
        });
      }}
    });

    await Future.delayed(const Duration(seconds: 10));
    _stopScan();
  }

  void _stopScan() {
  _scanBluetooth.stopScan();
  if (mounted) {
    setState(() {
      isScanning = false;
    });
  }
}

  bool _isDeviceAdded(BluetoothDevice device) => _devices.contains(device);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 206, 186, 8),
        title: const Text('Bluetooth'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          ConditionalBuilder(
            condition: !isScanning,
            builder: (context) => FloatingActionButton(
              onPressed: () {
                _startScan();
              },
              child: const Icon(
                Icons.bluetooth_audio,
              ),
            ),
            fallback: (context) => const CircularProgressIndicator(
              color: Colors.lightBlue,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ConditionalBuilder(
              condition: _selectedDevice != null,
              builder: (context) => Column(
                    children: [
                      _buildDev(_selectedDevice),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        MaterialButton(
                            onPressed: () async {
                               setState(() {

                            isConnectedG=true;

                           });
                          await PrinterManager.connect(_selectedDevice.address);
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Printer is now connnected and ready to print",
                          style: TextStyle(fontSize: 14,)),backgroundColor: Colors.green,action: SnackBarAction(label: 'Ok', onPressed: (){},textColor: Colors.white,),));
                           
                       

                            }, color: Colors.lightBlue,
                            child: const Text(
                              "Connect",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
              fallback: (context) => const Text("Search Devices")),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.lightBlue,
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ..._devices.map(
                    (dev) => _buildDev(dev),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDev(BluetoothDevice dev) => GestureDetector(
        onTap: () {
          setState(() {
            _selectedDevice = dev;
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

      @override
  void dispose(){
    super.dispose();

}

}
