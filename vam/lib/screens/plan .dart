import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class Plan extends StatefulWidget {
  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  String name = "";
  String phone = "";
  String fund = "";

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  // Future fetchData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString("token");
  //   token = "Token " + token;

  //   var url = Uri.parse('https://www.cryptocraze.co.in/api/user-profile/');
  //   var res = await http.get(
  //     url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       "Authorization": token,
  //     },
  //   );
  //   var responseData = json.decode(res.body);
  //   if (res.statusCode == 200) {
  //     setState(() {
  //       name = responseData['username'];
  //       phone = responseData['phone'];
  //       fund = responseData['fund'].toString();
  //     });
  //   }
  // }

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
            "Plan",
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
              SizedBox(height: 100.0)
            ],
          ),
        ));
  }
}
