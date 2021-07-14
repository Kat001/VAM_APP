import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:vam/Components/animate.dart';

//import 'package:http/http.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

import 'package:vam/screens/login.dart';

class SetPassword extends StatefulWidget {
  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  var _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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
              Navigator.push(context, SlideRightRoute(page: Login()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
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
                      controller: userController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter username.";
                        }

                        //return "";
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter username',
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
                      controller: emailController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter the Confirm Password";
                        }
                        //return "";
                      },
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Enter Email'),
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
                      if (_formKey.currentState.validate()) {}
                    },
                    minWidth: 250.0,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(8.0)),
                    height: 45.0,
                    child: Text(
                      "Send New Password",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
