import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/shared_preferences.dart';
import 'auth/login.dart';
import 'home.dart';

class LaodingPage extends StatefulWidget {
  @override
  _LaodingPageState createState() => _LaodingPageState();
}

class _LaodingPageState extends State<LaodingPage> {
  // var logger = new Logger();
  String _debugLabelString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/main_logo.png'),
                SizedBox(height: 20),
                SpinKitFadingFour(
                  color: Colors.lightBlueAccent,
                  size: 50.0,
                ),
              ],
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = preferences.getInt(SharedPreVariables.USERID);

    if (userId != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  //
  // Future<void> initOneSignal() async {
  //   await OneSignal.shared.init('4175ccac-b26f-4be2-9749-bb0cc5836b9a');
  //
  //   var status = await OneSignal.shared.getPermissionSubscriptionState();
  //
  //   var playerId = status.subscriptionStatus.userId;
  //
  //   // setPlayerID(playerId);
  //   logger.i(playerId);
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var ply = await prefs.setString(SharedPreVariables.PLAYER_ID, playerId);
  //
  //   OneSignal.shared
  //       .setInFocusDisplayType(OSNotificationDisplayType.notification);
  //
  //   OneSignal.shared
  //       .setNotificationReceivedHandler((OSNotification notification) {
  //     this.setState(() {
  //       _debugLabelString =
  //       "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
  //     });
  //   });
  //
  //   OneSignal.shared
  //       .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //     this.setState(() {
  //       _debugLabelString =
  //       "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
  //     });
  //   });
  //
  //   checkLoginStatus();
  // }
  //
  // Future<void> setPlayerID(String playerId) async {
  //   var notificationServices = NotificationServices();
  //   APIResponse response =
  //   await notificationServices.sendPlayID(player_id: playerId);
  //   if (response != null) {
  //     if (response.status == '1') {
  //       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message + ': setting things ready for you')));
  //
  //       // _setData(response.data);
  //     } else {
  //       // _showError(response.message);
  //     }
  //   } else {
  //     logger.i('API response is null');
  //     // _showError('Oops! Server is Down');
  //   }
  // }
}
