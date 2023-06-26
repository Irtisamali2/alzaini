import 'dart:convert';
import 'dart:io';


// import 'package:http/io_client.dart';


import 'package:http/http.dart' as http;

import '../models/api_response.dart';
import '../util/api.dart';

class AuthServices {

  static const headers = <String, String>{
    'Content-Type': 'application/json',
    'API_KEY': '2020ZCIWEBAPIKEYCHECK2020'
  };

  // var http;
  // var deviceType;/

  // AuthServices({this.http}) {
  //   final ioc = new HttpClient();
  //   ioc.badCertificateCallback =
  //       (X509Certificate cert, String host, int port) => true;
  //   http = new IOClient(ioc);
  //
  //   if (Platform.isAndroid) {
  //     deviceType = '1';
  //   } else if (Platform.isIOS) {
  //     deviceType = '2';
  //   }
  // }

  Future login({String uname, String upwd}) {
    print(uname);
    print(upwd);
    var url = NetUtils.BASE_URL + '/VanLogin?uname='+ uname + '&upwd=' + upwd;
    return http
        .post(
      Uri.parse(url),
      headers: headers,
    )
        .then((data) {
      final jsonData = json.decode(data.body);

      // print(jsonData);
      // print(jsonData[0]['userid']);

      // var api = LoginAPIResponse(
      //     data: jsonData[0]);

      // print(api.data);

      return LoginAPIResponse(
          data: jsonData[0]);
    }).catchError((onError) {
      print(onError);
      return null;
    });
  }

  // Future signUp(String name, String email, String phone, String password) {
  //   return http
  //       .post(
  //     NetUtils.BASE_URL + '/signup',
  //     headers: headers,
  //     body: jsonEncode(<String, dynamic>{
  //       'name': name,
  //       'email': email,
  //       'phone': phone,
  //       'password': password,
  //       'address': '',
  //       'device_token': '2345',
  //       'device_type': deviceType
  //     }),
  //   )
  //       .then((data) {
  //     final jsonData = json.decode(data.body);
  //     // logger.i(jsonData);
  //
  //     // logger.i(jsonData['result']);
  //     // logger.i(jsonData['status']);
  //     // logger.i(jsonData['msg']);
  //     var api = APIResponse(
  //         data: jsonData['result'],
  //         status: jsonData['status'],
  //         message: jsonData['msg']);
  //
  //     // logger.i(api.status);
  //     // logger.i(api.message);
  //     // logger.i(api.data);
  //     // logger.i(api.data['token']);
  //
  //     return APIResponse(
  //         data: jsonData['result'],
  //         status: jsonData['status'],
  //         message: jsonData['msg']);
  //   }).catchError((onError) {
  //     logger.e(onError);
  //     // return APIResponse(data: '', status: '', message: '');
  //   });
  // }
  //
  // Future getProfile({String token}) {
  //   return http.get(
  //     NetUtils.BASE_URL + '/get_profile',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'x-api-key': token
  //     },
  //   ).then((data) {
  //     final jsonData = json.decode(data.body);
  //
  //     return APIResponse(
  //         data: jsonData['result'],
  //         status: jsonData['status'],
  //         message: jsonData['msg']);
  //   }).catchError((onError) {
  //     logger.e(onError);
  //     // return APIResponse(data: '', status: '', message: '');
  //   });
  // }
}
