import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/api_response.dart';
import '../../services/auth_services.dart';
import '../../util/shared_preferences.dart';
import '../home.dart';
import 'package:permission_handler/permission_handler.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  FocusNode _passwordNode = new FocusNode();

  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset('assets/main_logo.png')),
                    SizedBox(
                      height: 10,
                    ),
                    _usernameField('Username*'),
                    SizedBox(
                      height: 10,
                    ),
                    _passwordField('Password*'),
                    SizedBox(
                      height: 40,
                    ),
                    isProcessing
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center(child: _primaryButton(context, 'Log In')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameField(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _usernameController,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(_passwordNode);
          },
          validator: (arg) {
            if (arg.length >= 5)
              return null;
            else {
              return 'Enter Valid Username';
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.blue[100],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            enabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ],
    );
  }

  Widget _passwordField(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _passwordController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          focusNode: _passwordNode,
          validator: (arg) {
            if (arg.length >= 5)
              return null;
            else {
              return 'Enter Valid Password';
            }
          },
          obscureText: true,
          decoration: InputDecoration(
            fillColor: Colors.blue[100],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            enabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ],
    );
  }

  InkWell _primaryButton(BuildContext context, String s) {
    return InkWell(
      onTap: () async {
        if (_key.currentState.validate()) {
          setState(() {
            isProcessing = true;
          });

          var authService = AuthServices();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // String player_id = prefs.getString(SharedPreVariables.PLAYER_ID);
          LoginAPIResponse response = await authService.login(
              uname: _usernameController.text, upwd: _passwordController.text);

          if (response != null) {
            if (response.data != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('AZCI: setting things ready for you')));
              _setData(response.data);
            } else {
              _showMsg('Oops! Server is Down');
            }
          } else {
            print('API response is null');
            _showMsg('Oops! Server is Down');
          }
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

  void _setData(Map<String, dynamic> data) async {
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        SharedPreVariables.USERID, data[SharedPreVariables.USERID]);
    await prefs.setString(
        SharedPreVariables.USERNAME, data[SharedPreVariables.USERNAME]);

    await prefs.setString(
        SharedPreVariables.USERTYPE, data[SharedPreVariables.USERTYPE]);
    await prefs.setInt(
        SharedPreVariables.EMPID, data[SharedPreVariables.EMPID]);

    await prefs.setString(
        SharedPreVariables.EMPLOYEENAME, data[SharedPreVariables.EMPLOYEENAME]);
    await prefs.setString(
        SharedPreVariables.EMPOLYEECODE, data[SharedPreVariables.EMPOLYEECODE]);

    await prefs.setString(
        SharedPreVariables.ROLEID, data[SharedPreVariables.ROLEID]);
    await prefs.setString(
        SharedPreVariables.CUSTOMERID, data[SharedPreVariables.CUSTOMERID]);

    await prefs.setString(
        SharedPreVariables.LOCATIONID, data[SharedPreVariables.LOCATIONID]);
    //
    //
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void _showMsg(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    setState(() {
      isProcessing = false;
    });
  }
}
