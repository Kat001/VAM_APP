import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

class Team extends StatefulWidget {
  Team({
    Key key,
    this.level,
  }) : super(key: key);

  final String level;
  @override
  _TeamState createState() => _TeamState();
}

class _TeamState extends State<Team> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>> fetchData() async {
    String level = widget.level;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    var url = Uri.parse('https://www.cryptocraze.co.in/api/level-$level/');
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

  Widget projectWidget() {
    return FutureBuilder<List<dynamic>>(
        future: fetchData(),
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
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [Colors.green, Colors.transparent]),
                        borderRadius: BorderRadius.circular(8),
                        //color: Colors.black45, //Color(0xFF21283A),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF21283A),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          )
                        ]),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        snapshot.data[index]["username"],
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          // fontSize: displayWidth(context) * 0.05,
                        ),
                        textScaleFactor: 1.5,
                      ),
                      // trailing: Icon(
                      //   Icons.arrow_forward_ios_outlined,
                      //   color: Colors.white,
                      // ),
                      subtitle: Text(
                        snapshot.data[index]['first_name'] +
                            " " +
                            snapshot.data[index]['last_name'],
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          // fontSize: displayWidth(context) * 0.05,
                        ),
                      ),
                    ),
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
        title: Text("My Team"),
      ),
      body: projectWidget(),
    );
  }
}
