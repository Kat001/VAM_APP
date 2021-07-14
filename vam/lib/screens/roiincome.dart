import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

class RoiIncome extends StatefulWidget {
  RoiIncome({
    Key key,
    this.amount,
  }) : super(key: key);

  final String amount;
  @override
  _RoiIncomeState createState() => _RoiIncomeState();
}

class _RoiIncomeState extends State<RoiIncome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget projectWidget() {
    return FutureBuilder(
      future: _checkDailyIncome(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(5), child: dataBody(snapshot.data)),
              )
            ],
          );
        }

        return Center();
      },
    );
  }

  SingleChildScrollView dataBody(List<dynamic> listIncome) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortColumnIndex: 0,
        showCheckboxColumn: false,
        columns: [
          DataColumn(
              label: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8),
                          // color: Colors.green,
                          // gradient: LinearGradient(
                          //     begin: Alignment.topLeft,
                          //     end: Alignment.topRight,
                          //     colors: [
                          //       Colors.green,
                          //       Colors.transparent,
                          //     ]),
                          //color: Colors.black45, //Color(0xFF21283A),
                          boxShadow: [
                        BoxShadow(
                          color: Color(0xFF21283A),
                          blurRadius: 5.0,
                          spreadRadius: 5.0,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Date"),
                  )),
              numeric: false,
              tooltip: "Next"),
          DataColumn(
            label: Container(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Amount"),
            )),
            numeric: false,
            tooltip: "Previous",
          ),
          DataColumn(
              label: Container(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Status"),
              )),
              numeric: false,
              tooltip: "Next"),
        ],
        rows: listIncome
            .map(
              (income) => DataRow(
                  onSelectChanged: (b) {
                    // print(sale.next);
                  },
                  cells: [
                    DataCell(Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          income['date'].substring(0, 10),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Roboto",
                              color: Colors.white),
                        ),
                      ),
                    )),
                    DataCell(
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            income['amount'].toString(),
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "Roboto",
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green,
                            // gradient: LinearGradient(
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.topRight,
                            //     colors: [
                            //       Colors.green,
                            //       Colors.transparent,
                            //     ]),
                            //color: Colors.black45, //Color(0xFF21283A),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF21283A),
                                blurRadius: 5.0,
                                spreadRadius: 5.0,
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Paid",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "Roboto",
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ]),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21283A),
      appBar: AppBar(
        title: Text("Income.."),
      ),
      body: projectWidget(),
    );
  }

  Future<List<dynamic>> _checkDailyIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    Map data = {
      "amount": widget.amount,
    };

    var body = json.encode(data);

    var url = Uri.parse('http://127.0.0.1:8000/api/check-daily-income/');
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
      body: body,
    );
    var responseData = json.decode(res.body);
    return responseData['data'];
  }
}
