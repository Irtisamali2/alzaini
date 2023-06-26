import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/api_response.dart';
import '../util/api.dart';

class VanServices{

  static const headers = <String, String>{
    'Content-Type': 'application/json',
    'API_KEY': '2020ZCIWEBAPIKEYCHECK2020'
  };

  Future VanItemDetails({String locationId, String barcode}){

    var url = NetUtils.BASE_URL + '/VanItemDetails?LocationID='+ locationId + '&Barcode=' + barcode;

    return http.post(
      Uri.parse(url),
      headers: headers,
    ).then((data) {
      final jsonData = json.decode(data.body);

      print('------------------------------------------------------------------');
      print(jsonData);
      print('------------------------------------------------------------------');

      return VanItemDetailsAPIResponse(
          data: jsonData[0]);

    }).catchError((onError) {
      print(onError);
      return null;
    });
  }

  Future VanSalesInvoiceAdd({Map<String, dynamic> map}){

    var url = NetUtils.BASE_URL + '/VanSalesInvoiceAdd';
    final body = jsonEncode(map);
    return http.post(
      Uri.parse(url),
      headers: headers,
      body: body
    ).then((data) {
      final jsonData = json.decode(data.body);

      print('------------------------------------------------------------------');
      print(jsonData);
      print(jsonData[0]);
      print('------------------------------------------------------------------');

      // returned value is just a string, which is invoice number
      return jsonData;

    }).catchError((onError) {
      print(onError);
      return null;
    });
  }

  Future VanSalesInvoiceSearch({int CustomerID, int EmployeeID, String FromDate, String ToDate}){

    var url = NetUtils.BASE_URL + '/VanSalesInvoiceSearch?CustomerID=${CustomerID}&EmployeeID=${EmployeeID}&FromDate=${FromDate}&ToDate=${ToDate}';

    return http.post(
      Uri.parse(url),
      headers: headers,
    ).then((data) {
      final jsonData = json.decode(data.body);

      print('------------------------------------------------------------------');
      print(jsonData);
      print('------------------------------------------------------------------');

      return VanSalesInvoiceSearchAPIResponse(
          data: jsonData[0]);

    }).catchError((onError) {
      print(onError);
      return null;
    });
  }

  Future VanSalesInvoiceForReturn({int VanSalesInvoiceID}){

    var url = NetUtils.BASE_URL + '/VanSalesInvoiceForReturn?VanSalesInvoiceID='+ VanSalesInvoiceID.toString();

    return http.post(
      Uri.parse(url),
      headers: headers,
    ).then((data) {
      final jsonData = json.decode(data.body);

      print('------------------------------------------------------------------');
      print(jsonData);
      print('------------------------------------------------------------------');

      return VanSalesReturnAPIResponse(
          data: jsonData[0]);

    }).catchError((onError) {
      print(onError);
      return null;
    });
  }

  Future VanSalesReturnAdd({Map<String, dynamic> map}){

    var url = NetUtils.BASE_URL + '/VanSalesReturnAdd';
    final body = jsonEncode(map);
    return http.post(
        Uri.parse(url),
        headers: headers,
        body: body
    ).then((data) {
      final jsonData = json.decode(data.body);

      // print('------------------------------------------------------------------');
      // print(jsonData);
      // print(jsonData[0]);
      // print('------------------------------------------------------------------');

      // returned value is just a string, which is invoice number
      return jsonData;

    }).catchError((onError) {
      print(onError);
      return null;
    });
  }

  Future VanSalesReturnSearch({int CustomerID, int LocationID, String FromDate, String ToDate}){

    var url = NetUtils.BASE_URL + '/VanSalesReturnSearch?CustomerID=' +CustomerID.toString() + '&LocationID=' + LocationID.toString() + '&FromDate=' + FromDate + '&ToDate=' + ToDate;

    return http.post(
      Uri.parse(url),
      headers: headers,
    ).then((data) {
      final jsonData = json.decode(data.body);

      print('------------------------------------------------------------------');
      print(jsonData);
      print('------------------------------------------------------------------');

      return VanSalesReturnSearchAPIResponse(
          data: jsonData[0]);

    }).catchError((onError) {
      print(onError);
      return null;
    });
  }


  Future VanPostPendingSalesInvoice({String userid}){

    var url = NetUtils.BASE_URL + '/VanPostPendingSalesInvoice?userid='+ userid;

    return http.post(
      Uri.parse(url),
      headers: headers,
    ).then((data) {
      final jsonData = json.decode(data.body);

      print('------------------------------------------------------------------');
      print(jsonData);
      print('------------------------------------------------------------------');

      return jsonData[0];

    }).catchError((onError) {
      print(onError);
      return null;
    });
  }



  Future VanSalesInvoiceView({int VanSalesInvoiceID}){

    var url = NetUtils.BASE_URL + '/VanSalesInvoiceView?VanSalesInvoiceID='+ VanSalesInvoiceID.toString();

    return http.post(
      Uri.parse(url),
      headers: headers,
    ).then((data) {
      final jsonData = json.decode(data.body);

      print('------------------------------------------------------------------');
      print(jsonData);
      print('------------------------------------------------------------------');

      return VanSalesReturnAPIResponse(
          data: jsonData[0]);

    }).catchError((onError) {
      print(onError);
      return null;
    });
  }

}