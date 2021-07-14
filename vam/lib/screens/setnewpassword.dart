import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vam/Components/animate.dart';
import 'package:vam/screens/login.dart';

class SetNewPassword extends StatefulWidget {
  @override
  _SetNewPasswordState createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  var _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text(
                "Set New Password",
                style: TextStyle(
                    fontFamily: "RobotoBold",
                    fontSize: 20.0,
                    color: Color(0xFF2AD0B5)),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              )),
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
                      image: AssetImage('assets/images/setpass.jpg'),
                      height: 220.0,
                      width: 220.0,
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 20, right: 20, top: 50),
                    child: ListTile(
                      title: TextFormField(
                        controller: _oldPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          labelText: 'Enter old password',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: _newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          labelText: 'Enter new password',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: _confirmNewPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          labelText: 'Confirm new password',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 70, right: 70, top: 35),
                    child: MaterialButton(
                      // color: Color(0xFF27DEBF),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (_newPasswordController.text ==
                              _confirmNewPasswordController.text) {
                            changePassword();
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => CustomDialogError("Error",
                                    "Password must be same", "Cancel"));
                          }
                        }
                      },
                      minWidth: 250.0,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(8.0)),
                      height: 45.0,
                      child: Text(
                        "Submit",
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
                ],
              ),
            ),
          )),
    );
  }

  Future<http.Response> changePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;
    var url = Uri.parse('http://127.0.0.1:8000/api/change-password/');

    Map data = {
      'cPassword': _oldPasswordController.text,
      "nPassword": _newPasswordController.text,
    };

    var body = json.encode(data);

    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
      body: body,
    );
    print(res.body);
    var responseData = json.decode(res.body);

    if (res.statusCode == 200) {
      Navigator.pushReplacement(context, SlideLeftRoute(page: Login()));
      showDialog(
        context: context,
        builder: (context) =>
            CustomDialog("Success", responseData['data'], "Okay", 3),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              CustomDialogError("Error", responseData['data'], "Cancel"));
    }
    return res;
  }
}
