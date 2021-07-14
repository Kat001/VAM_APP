import 'package:flutter/material.dart';

import 'package:vam/Components/sizes_helpers.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vam/Components/animate.dart';
import 'package:vam/screens/setnewpassword.dart';

// import 'package:vam/Screens/Setnewpassword.dart';

class PersonalDetails extends StatefulWidget {
  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  TextEditingController _sponsorController = TextEditingController();
  TextEditingController _dateJoinedController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchInformation();
  }

  Future fetchInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    var url = Uri.parse('http://127.0.0.1:8000/api/user-profile/');
    var res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
    );
    var responseData = json.decode(res.body);
    print(res.body);
    setState(() {
      _firstNameController.text = responseData['first_name'];
      _lastNameController.text = responseData['last_name'];
      _emailController.text = responseData['email'];
      _phoneController.text = responseData['phone'];
      _sponsorController.text = responseData['sponsor'];
      _dateJoinedController.text = responseData['registration'];
      _addressController.text = responseData['address'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Personal details",
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
      body: Container(
        margin: EdgeInsets.only(
          left: displayWidth(context) * 0.10,
          right: displayWidth(context) * 0.10,
          top: displayHeight(context) * 0.02,
        ),
        child: Column(children: <Widget>[
          TextFormField(
            controller: _firstNameController,
            /*controller: emailController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter the email.";
              }
              if (!EmailValidator.validate(value)) {
                return "Enter valid email";
              }
            },*/
            //initialValue: "data(1)",
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0),
              labelText: 'First name',
            ),
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _lastNameController,
            //initialValue: "lastName",
            /*controller: emailController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter the email.";
              }
              if (!EmailValidator.validate(value)) {
                return "Enter valid email";
              }
            },*/
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0),
              labelText: 'Last name',
            ),
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _phoneController,
            /*controller: emailController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter the email.";
              }
              if (!EmailValidator.validate(value)) {
                return "Enter valid email";
              }
            },*/
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0),
              labelText: 'Phone number',
            ),
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _emailController,
            /*controller: emailController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter the email.";
              }
              if (!EmailValidator.validate(value)) {
                return "Enter valid email";
              }
            },*/
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0),
              labelText: 'Email for authorisation',
            ),
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _sponsorController,
            readOnly: true,
            /*controller: emailController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter the email.";
              }
              if (!EmailValidator.validate(value)) {
                return "Enter valid email";
              }
            },*/
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0),
              labelText: 'Sponsor',
            ),
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _dateJoinedController,
            readOnly: true,
            /*controller: emailController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter the email.";
              }
              if (!EmailValidator.validate(value)) {
                return "Enter valid email";
              }
            },*/
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0),
              labelText: 'Registration Date',
            ),
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _addressController,
            /*controller: emailController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter the email.";
              }
              if (!EmailValidator.validate(value)) {
                return "Enter valid email";
              }
            },*/
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0),
              labelText: 'address',
            ),
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 18,
            ),
          ),
          Center(
            child: Container(
              margin: new EdgeInsets.only(top: 40),
              child: MaterialButton(
                // color: Color(0xFF27DEBF),
                onPressed: () {
                  updateUser();
                },
                minWidth: 250.0,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(8.0)),
                height: 45.0,
                child: Text(
                  "Save",
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
          ),
          Center(
            child: Row(
              children: [
                Container(
                  margin: new EdgeInsets.only(bottom: 30, top: 30.0, left: 50),
                  child: Text(
                    "- Change Password -",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF707070), fontSize: 16.0),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context, SlideLeftRoute(page: SetNewPassword()));
                  },
                  child: Container(
                    margin: new EdgeInsets.only(bottom: 30, top: 30.0),
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
        ]),
      ),
    );
  }

  Future<http.Response> updateUser() async {
    // Map data = {
    //   "first_name": _firstNameController.text,
    //   "last_name": _lastNameController.text,
    //   "email": _emailController.text,
    //   "phn_number": _phoneController.text,
    // };
    // var body = json.encode(data);
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // String token = prefs.getString("token");

    // http.Response res = await http.post(
    //   'https://www.mitrahtechnology.in/apis/mitrah-api/update_personal_details.php',
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //     'Authorization': token,
    //   },
    //   body: body,
    // );

    // print(res.body);
    // var responseData = json.decode(res.body);
    // if (responseData['status'] == 200) {
    //   prefs.setString("first_name", _firstNameController.text);
    //   prefs.setString("last_name", _lastNameController.text);
    //   prefs.setString("email", _emailController.text);
    //   prefs.setString("phn_number", _phoneController.text);
    //   showDialog(
    //     context: context,
    //     builder: (context) =>
    //         CustomDialog("Success", responseData['message'], "Okay", 2),
    //   );
    //   //Navigator.push(context, SlideLeftRoute(page: Profile()));
    // } else if (responseData['status'] == 500) {
    //   showDialog(
    //       context: context,
    //       builder: (context) =>
    //           CustomDialogError("Error", "User already Exists", "Cancel"));
    // } else {
    //   showDialog(
    //       context: context,
    //       builder: (context) =>
    //           CustomDialogError("Error", responseData['message'], "Cancel"));
    // }
  }
}
