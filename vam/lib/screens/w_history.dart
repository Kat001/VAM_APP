import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WithdrawalHistory extends StatefulWidget {
  @override
  _WithdrawalHistoryState createState() => _WithdrawalHistoryState();
}

class _WithdrawalHistoryState extends State<WithdrawalHistory> {
  Future<List<dynamic>> fetchWithdrawal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    var url =
        Uri.parse('https://www.cryptocraze.co.in/api/withdrawal-history/');
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
        future: fetchWithdrawal(),
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
                    child: ListTile(
                      leading: Icon(
                        Icons.arrow_right,
                        color: Colors.blue,
                        size: 60.0,
                      ),
                      trailing: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 60,
                      ),
                      title: Text(
                        snapshot.data[index]['date'],
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.green,
                          // fontSize: displayWidth(context) * 0.05,
                        ),
                        textScaleFactor: 1.5,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amount : " +
                                snapshot.data[index]['amount'].toString(),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.green,

                              // fontSize: displayWidth(context) * 0.05,
                            ),
                          ),
                          Text(
                            snapshot.data[index]['address'].toString(),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.green,

                              // fontSize: displayWidth(context) * 0.05,
                            ),
                          ),
                        ],
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
        title: Text("Withdrawal History"),
      ),
      body: projectWidget(),
    );
  }
}
