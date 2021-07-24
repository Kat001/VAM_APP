import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>> fetchTaskDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    var url = Uri.parse('https://www.cryptocraze.co.in/api/task-detail/');
    var res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
    );

    print(res.body);
    print(res.statusCode);
    var responseData = json.decode(res.body);
    return responseData['data'];
  }

  String packName(double amount) {
    if (amount == 10) {
      return "BNB 01";
    }
    if (amount == 50) {
      return "BNB 02";
    }
    if (amount == 100) {
      return "BNB 03";
    }
    if (amount == 500) {
      return "BNB 04";
    }
    if (amount == 1000) {
      return "BNB 05";
    }
  }

  Widget tile(double amount, int clicked) {
    if (amount == 10 && clicked >= 2)
      return ListTile(
        leading: Icon(
          Icons.arrow_right,
          color: Colors.black,
          size: 60.0,
        ),
        trailing: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 60,
        ),
        title: Text(
          packName(amount),
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.green,
            // fontSize: displayWidth(context) * 0.05,
          ),
          textScaleFactor: 1.5,
        ),
        subtitle: Text(
          "Today's Task of this Package completed!!",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.green,

            // fontSize: displayWidth(context) * 0.05,
          ),
        ),
      );
    else if (amount == 50 && clicked >= 4)
      return ListTile(
        leading: Icon(
          Icons.arrow_right,
          color: Colors.black,
          size: 60.0,
        ),
        trailing: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 60,
        ),
        title: Text(
          packName(amount),
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.green,
            // fontSize: displayWidth(context) * 0.05,
          ),
          textScaleFactor: 1.5,
        ),
        subtitle: Text(
          "Today's Task of this Package completed!!",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.green,

            // fontSize: displayWidth(context) * 0.05,
          ),
        ),
      );
    else if (amount == 100 && clicked >= 4)
      return ListTile(
        leading: Icon(
          Icons.arrow_right,
          color: Colors.black,
          size: 60.0,
        ),
        trailing: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 60,
        ),
        title: Text(
          packName(amount),
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.green,
            // fontSize: displayWidth(context) * 0.05,
          ),
          textScaleFactor: 1.5,
        ),
        subtitle: Text(
          "Today's Task of this Package completed!!",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.green,

            // fontSize: displayWidth(context) * 0.05,
          ),
        ),
      );
    else if (amount == 500 && clicked >= 6)
      return ListTile(
        leading: Icon(
          Icons.arrow_right,
          color: Colors.black,
          size: 60.0,
        ),
        trailing: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 60,
        ),
        title: Text(
          packName(amount),
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.green,
            // fontSize: displayWidth(context) * 0.05,
          ),
          textScaleFactor: 1.5,
        ),
        subtitle: Text(
          "Today's Task of this Package completed!!",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.green,

            // fontSize: displayWidth(context) * 0.05,
          ),
        ),
      );
    else if (amount == 1000 && clicked >= 7)
      return ListTile(
        leading: Icon(
          Icons.arrow_right,
          color: Colors.black,
          size: 60.0,
        ),
        trailing: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 60,
        ),
        title: Text(
          packName(amount),
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.green,
            // fontSize: displayWidth(context) * 0.05,
          ),
          textScaleFactor: 1.5,
        ),
        subtitle: Text(
          "Today's Task of this Package completed!!",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.green,

            // fontSize: displayWidth(context) * 0.05,
          ),
        ),
      );
    else {
      return ListTile(
        leading: Icon(
          Icons.arrow_right,
          color: Colors.black,
          size: 60.0,
        ),
        trailing: Icon(
          Icons.warning_rounded,
          color: Colors.red,
          size: 60,
        ),
        title: Text(
          packName(amount),
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.red,
            // fontSize: displayWidth(context) * 0.05,
          ),
          textScaleFactor: 1.5,
        ),
        subtitle: Text(
          "Today's Task Still Pending!!",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.red,
            // fontSize: displayWidth(context) * 0.05,
          ),
        ),
      );
    }
  }

  Widget projectWidget() {
    return FutureBuilder<List<dynamic>>(
        future: fetchTaskDetail(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                // scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.topRight,
                        //     colors: [Colors.green, Colors.transparent]),
                        // borderRadius: BorderRadius.circular(8),
                        color: Colors.white, //Color(0xFF21283A),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF21283A),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          )
                        ]),
                    child: tile(snapshot.data[index]['amount'],
                        snapshot.data[index]['clickedLinks']),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21283A),
      appBar: AppBar(
        title: Text("Task"),
      ),
      body: projectWidget(),
    );
  }
}
