import 'package:flutter/material.dart';

class AppVersion extends StatefulWidget {
  @override
  _AppVersionState createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21283A),
      appBar: AppBar(
        title: Text("App Version"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20.0,
            ),
            child: Text(
              "1.0.0.0.1.1",
              style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 2.0,
                left: 10.0,
                right: 10.0,
              ),
              child: Divider(
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
