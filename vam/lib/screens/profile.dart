import 'package:flutter/material.dart';
import 'package:vam/Components/sizes_helpers.dart';
import 'package:vam/Components/animate.dart';
import 'package:vam/Components/customicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vam/screens/appversion.dart';
import 'dart:convert';

import 'package:vam/screens/income.dart';
import 'package:vam/screens/login.dart';
import 'package:vam/screens/personal_info.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String phone = "";
  String fund = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    var url = Uri.parse('https://www.cryptocraze.co.in/api/user-profile/');
    var res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
    );
    var responseData = json.decode(res.body);
    if (res.statusCode == 200) {
      setState(() {
        name = responseData['username'];
        phone = responseData['phone'];
        fund = responseData['fund'].toString();
      });
    }
  }

  Widget rowWidget(String str1, String str2) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            str1,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
        //SizedBox(width: 40.0),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 85.0),
            child: Text(
              str2,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(
              fontFamily: 'RobotoBold',
              fontSize: 17,
              letterSpacing: 2.0,
              color: Colors.white,
            ),
          ),
          actions: [],
        ),
        backgroundColor: Color(0xFF21283A),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  name,
                  style: TextStyle(
                      fontFamily: "RobotoBold",
                      fontSize: 28.0,
                      color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  "+91 $phone",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 18,
                      color: Color(0xFF465A64)),
                ),
              ),
              Column(
                children: [
                  new Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.blue,
                              Colors.red,
                            ]),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF0F0F0),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          )
                        ]),
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.0),
                          rowWidget("Available BUSD:", fund),
                          SizedBox(height: 12.0),
                          Center(
                            child: Container(
                              height: displayHeight(context) * 0.05,
                              // padding: const EdgeInsets.only(top: ),
                              // margin: new EdgeInsets.only(
                              //   left: 60,
                              //   right: 60,
                              //   top: 18,
                              // ),
                              margin:
                                  EdgeInsets.all(displayHeight(context) * 0.01),
                              child: MaterialButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context, SlideLeftRoute(page: Topup()));
                                },
                                minWidth: 250.0,
                                height: 10,
                                child: Text(
                                  "Purchase BUSD",
                                  style: TextStyle(
                                    fontFamily: 'RobotoBold',
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  gradient: RadialGradient(radius: 15, colors: [
                                    Color(0xFF27DEBF),
                                    Color(0xFF465A64)
                                  ])),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 40, left: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      SlideLeftRoute(page: PersonalDetails()),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 25,
                        height: 25,
                        child: Icon(Icons.person),
                        color: Colors.white,
                      ),
                      Container(
                        child: Text(
                          "Personal Information",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 17,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25, left: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, SlideLeftRoute(page: Income()));
                  },
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 20),
                          width: 25,
                          height: 25,
                          child: Icon(Icons.stacked_bar_chart),
                          color: Colors.white),
                      Container(
                        child: Text(
                          "My Packages",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 17,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25, left: 20),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(context, SlideLeftRoute(page: Region()));
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 25,
                        height: 25,
                        child: Icon(Icons.info_outline),
                        color: Colors.white,
                      ),
                      Container(
                        child: Text(
                          "About Us",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 17,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 15, left: 65),
                  child: Divider(
                    color: Colors.black,
                  )),
              InkWell(
                onTap: () {
                  Navigator.push(context, SlideLeftRoute(page: AppVersion()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 25,
                        height: 25,
                        // child: Image.asset(
                        //   //version,
                        //   color: Color(0xFF465A64),
                        // ),
                      ),
                      Container(
                        child: Text(
                          "App Version",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 17,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  return showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Are you sure?',
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Color(0xFF465A64))),
                          content: Text('Do you want to Logout from this App',
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Color(0xFF465A64))),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString("token", "null");
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Login(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Text('Yes',
                                  style: TextStyle(
                                      fontFamily: "RobotoBold",
                                      color: Color(0xFF2BCDB4))),
                            ),
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              /*Navigator.of(context).pop(true)*/
                              child: Text('No',
                                  style: TextStyle(
                                      fontFamily: "RobotoBold",
                                      color: Color(0xFF2BCDB4))),
                            ),
                          ],
                        ),
                      ) ??
                      false;
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 65),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 100.0)
            ],
          ),
        ));
  }
}
