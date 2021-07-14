import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vam/Components/toast_utils.dart';
import 'package:vam/Components/animate.dart';

import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

import 'package:vam/screens/dashboard.dart';
import 'package:vam/screens/forgotpassword.dart';
import 'package:vam/screens/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  final TextEditingController user_idController = TextEditingController();
  final TextEditingController user_passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              // Navigator.push(context, SlideRightRoute(page: Homepage()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: new EdgeInsets.only(top: 1, right: 35, left: 35),
                  child: Image(
                    image: AssetImage('assets/images/logins.png'),
                    height: 266.0,
                    width: 266.0,
                  ),
                ),
                Container(
                  margin: new EdgeInsets.only(left: 30, right: 30),
                  child: ListTile(
                    title: TextFormField(
                      controller: user_idController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter valid username.";
                        }
                        /*if (!EmailValidator.validate(value)) {
                          return "Enter valid email";
                        }*/
                        //return "";
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: new EdgeInsets.only(left: 30, right: 30, top: 15),
                  child: ListTile(
                    title: TextFormField(
                      controller: user_passController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter the Password";
                        }
                        //return "";
                      },
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: new EdgeInsets.only(left: 75, right: 75, top: 40),
                  child: MaterialButton(
                    // color: Color(0xFF27DEBF),
                    onPressed: () {
                      print("login clicked..");
                      if (_formKey.currentState.validate()) {
                        loginUser();
                      }
                    },
                    minWidth: 250.0,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(8.0)),
                    height: 45.0,
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontFamily: 'RobotoBold',
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      gradient: RadialGradient(
                          radius: 15,
                          colors: [Color(0xFF27DEBF), Color(0xFF465A64)])),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: new EdgeInsets.only(
                            bottom: 30, top: 40.0, left: 75),
                        child: Text(
                          "- Forgot Password -",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF707070), fontSize: 16.0),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context, SlideLeftRoute(page: SetPassword()));
                        },
                        child: Container(
                          margin: new EdgeInsets.only(
                            bottom: 30,
                            top: 40.0,
                          ),
                          child: Text(
                            " Click Here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF27DEBF),
                                fontSize: 16.0,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: new EdgeInsets.only(left: 75),
                        child: Text(
                          "- Do not have an account -",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF707070), fontSize: 16.0),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context, SlideLeftRoute(page: ForgotPassword()));
                        },
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Signup()));
                            },
                            child: Text(
                              " Click Here",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF27DEBF),
                                  fontSize: 16.0,
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<http.Response> loginUser() async {
    String user_id = user_idController.text;
    String user_pass = user_passController.text;
    var url = Uri.parse('http://127.0.0.1:8000/api/api-token-auth/');

    Map data = {
      "username": user_idController.text,
      "password": user_passController.text,
    };

    var body = json.encode(data);

    http.Response res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print(res.body);
    print(res.statusCode);
    var responseData = json.decode(res.body);
    print(responseData['token']);

    if (res.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['token']);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Dashboard()));

      ToastUtils.showCustomToast(context, "Sign in Successfully");
    } else {
      showDialog(
          context: context,
          builder: (context) => CustomDialogError(
              "Error", "Username or Pasword is Wrong!!", "Cancel"));
    }
    return res;
  }
}
