import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vam/Components/toast_utils.dart';
import 'package:vam/Components/animate.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

import 'package:vam/screens/dashboard.dart';
import 'package:vam/screens/login.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sponsorController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
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
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin:
                        new EdgeInsets.only(right: 35, left: 35, bottom: 10),
                    child: Image(
                      image: AssetImage('assets/images/signup.png'),
                      height: 220.0,
                      width: 220.0,
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 30, right: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: sponsorController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter your Sponsor.";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: 'Sponsor',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 30, right: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: firstNameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter the first name.";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: 'First Name',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 30, right: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: lastNameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter the last name.";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: 'Last Name',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 30, right: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: emailController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter the email.";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: 'Email',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 30, right: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: phoneController,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter the phone no.";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: 'Phone Number',
                          //prefixStyle: TextStyle(color: Colors.transparent),
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 30, right: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: passwordController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter the password.";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: 'Create Password',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 75, right: 75, top: 25),
                    child: MaterialButton(
                      // color: Color(0xFF27DEBF),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          createUser();
                        }
                      },
                      minWidth: 250.0,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(8.0)),
                      height: 45.0,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontFamily: 'roboto',
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
                    margin: new EdgeInsets.only(top: 25.0, bottom: 25),
                    child: Text(
                      "- Already have an account -",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Color(0xFF707070), fontSize: 16.0),
                    ),
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Login()));
                      },
                      child: Text(
                        "- Login -",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<http.Response> createUser() async {
    var url = Uri.parse('http://127.0.0.1:8000/api/register/');

    Map data = {
      'first_name': firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "phon_no": phoneController.text,
      "spn": sponsorController.text,
      "password": passwordController.text,
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

    if (res.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog("Success",
            "Username : " + responseData['user']['username'], "Okay", 3),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) => CustomDialogError("Error",
              "sponsor does not exists or make password strong!!", "Cancel"));
    }
    return res;
  }
}
