import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:vam/screens/dashboard.dart';
import 'package:vam/screens/forgotpassword.dart';
import 'package:vam/screens/login.dart';
import 'package:vam/screens/payment.dart';
import 'package:vam/screens/personal_info.dart';
import 'package:vam/screens/plan%20.dart';
import 'package:vam/screens/profile.dart';
import 'package:vam/screens/setnewpassword.dart';
import 'package:vam/screens/signup.dart';
import 'package:vam/screens/team.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vam/screens/w_history.dart';

void main() => runApp(Myapp());

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    if (token != null && token != "null") {
      setState(() {
        isLoggedIn = true;
      });

      return;
    } else {
      setState(() {
        isLoggedIn = false;
      });

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      //return LayoutBuilder
      builder: (context, constraints) {
        return OrientationBuilder(
          //return OrientationBuilder
          builder: (context, orientation) {
            //initialize SizerUtil()
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "VAM APP",
              theme: ThemeData(
                primaryColor: Color(0xFF21283A),
                dividerColor: Colors.transparent,
              ),
              home: isLoggedIn ? Dashboard() : Login(),
            );
          },
        );
      },
    );
  }
}
