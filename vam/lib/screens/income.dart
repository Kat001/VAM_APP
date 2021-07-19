import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vam/screens/login.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:vam/screens/roiincome.dart';

class Income extends StatefulWidget {
  @override
  _IncomeState createState() => _IncomeState();
}

class _IncomeState extends State<Income> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    fetchLevelIncome();
    fetchRoiOnRoiIncome();
    tabController = TabController(vsync: this, length: 3);
    tabController.index = 0;
  }

  Widget getTabBar() {
    return TabBar(
        controller: tabController,
        indicatorColor: Colors.red, //indicator: BoxDecoration(

        tabs: [
          Tab(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Text(
                "ROI Income",
              ),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Text(
                "Direct ROI Income",
              ),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Text(
                "Level Income",
              ),
            ),
          ),
        ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: tabController, children: <Widget>[
      projectWidget(),
      directRoiWidget(),
      levelWidget(),
    ]);
  }

  Future<Map<String, dynamic>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    var url = Uri.parse('https://www.cryptocraze.co.in/api/return-pack/');
    var res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
    );
    Map<String, dynamic> responseData = json.decode(res.body);

    return responseData;
  }

  Future<void> updateLinkClick(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    var url = Uri.parse('https://www.cryptocraze.co.in/api/link-click/');
    Map data = {
      "amount": amount,
    };

    var body = json.encode(data);
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
      body: body,
    );
    // print(res.body);
    var responseData = json.decode(res.body);
    print("message-->" + responseData['message']);
    return res;
  }

  Future<List<dynamic>> fetchLevelIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    var url = Uri.parse('https://www.cryptocraze.co.in/api/level-income/');
    var res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
    );
    // print(res.body);
    var responseData = json.decode(res.body);
    return responseData['data'];
  }

  Future<List<dynamic>> fetchRoiOnRoiIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    var url = Uri.parse('https://www.cryptocraze.co.in/api/roi-on-roi/');
    var res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
    );
    // print(res.body);
    var responseData = json.decode(res.body);
    return responseData['data'];
  }

  Widget projectWidget() {
    return FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                // scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data['data'].length,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data['data'][index]['amount'] == 10.0) {
                    return cardWidget(
                      "01",
                      "10",
                      "0.1",
                      "200",
                      snapshot.data['links'][0]['link1'],
                      snapshot.data['links'][0]['link2'],
                      snapshot.data['links'][0]['link3'],
                      snapshot.data['links'][0]['link4'],
                      snapshot.data['links'][0]['link5'],
                      snapshot.data['links'][0]['link6'],
                      snapshot.data['links'][0]['link7'],
                    );
                  }
                  if (snapshot.data['data'][index]['amount'] == 50.0) {
                    return cardWidget(
                      "02",
                      "50",
                      "1",
                      "125",
                      snapshot.data['links'][0]['link1'],
                      snapshot.data['links'][0]['link2'],
                      snapshot.data['links'][0]['link3'],
                      snapshot.data['links'][0]['link4'],
                      snapshot.data['links'][0]['link5'],
                      snapshot.data['links'][0]['link6'],
                      snapshot.data['links'][0]['link7'],
                    );
                  }
                  if (snapshot.data['data'][index]['amount'] == 100.0) {
                    return cardWidget(
                      "03",
                      "100",
                      "2",
                      "125",
                      snapshot.data['links'][0]['link1'],
                      snapshot.data['links'][0]['link2'],
                      snapshot.data['links'][0]['link3'],
                      snapshot.data['links'][0]['link4'],
                      snapshot.data['links'][0]['link5'],
                      snapshot.data['links'][0]['link6'],
                      snapshot.data['links'][0]['link7'],
                    );
                  }
                  if (snapshot.data['data'][index]['amount'] == 500.0) {
                    return cardWidget(
                      "04",
                      "500",
                      "15",
                      "100",
                      snapshot.data['links'][0]['link1'],
                      snapshot.data['links'][0]['link2'],
                      snapshot.data['links'][0]['link3'],
                      snapshot.data['links'][0]['link4'],
                      snapshot.data['links'][0]['link5'],
                      snapshot.data['links'][0]['link6'],
                      snapshot.data['links'][0]['link7'],
                    );
                  }
                  if (snapshot.data['data'][index]['amount'] == 1000.0) {
                    return cardWidget(
                      "05",
                      "1000",
                      "30",
                      "1000",
                      snapshot.data['links'][0]['link1'],
                      snapshot.data['links'][0]['link2'],
                      snapshot.data['links'][0]['link3'],
                      snapshot.data['links'][0]['link4'],
                      snapshot.data['links'][0]['link5'],
                      snapshot.data['links'][0]['link6'],
                      snapshot.data['links'][0]['link7'],
                    );
                  }
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget popUp(
    String amount,
    String link1,
    String link2,
    String link3,
    String link4,
    String link5,
    String link6,
    String link7,
  ) {
    int amt = int.parse(amount);
    if (amt == 10) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              launch(link1);
              updateLinkClick(amt);
            },
            child: Text(
              link1,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link2);
              updateLinkClick(amt);
            },
            child: Text(
              link2,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
        ],
      );
    }
    if (amt == 50) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              launch(link1);
              updateLinkClick(amt);
            },
            child: Text(
              link1,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link2);
              updateLinkClick(amt);
            },
            child: Text(
              link2,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link3);
              updateLinkClick(amt);
            },
            child: Text(
              link3,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link4);
              updateLinkClick(amt);
            },
            child: Text(
              link4,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
        ],
      );
    }
    if (amt == 100) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              launch(link1);
              updateLinkClick(amt);
            },
            child: Text(
              link1,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link2);
              updateLinkClick(amt);
            },
            child: Text(
              link2,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link3);
              updateLinkClick(amt);
            },
            child: Text(
              link3,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link4);
              updateLinkClick(amt);
            },
            child: Text(
              link4,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
        ],
      );
    }
    if (amt == 500) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              launch(link1);
              updateLinkClick(amt);
            },
            child: Text(
              link1,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link2);
              updateLinkClick(amt);
            },
            child: Text(
              link2,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link3);
              updateLinkClick(amt);
            },
            child: Text(
              link3,
              style: TextStyle(fontFamily: "Roboto", color: Colors.blue),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link4);
              updateLinkClick(amt);
            },
            child: Text(
              link4,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link5);
              updateLinkClick(amt);
            },
            child: Text(
              link5,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link6);
              updateLinkClick(amt);
            },
            child: Text(
              link6,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
        ],
      );
    }
    if (amt == 1000) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              launch(link1);
              updateLinkClick(amt);
            },
            child: Text(
              link1,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link2);
              updateLinkClick(amt);
            },
            child: Text(
              link2,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link3);
              updateLinkClick(amt);
            },
            child: Text(
              link3,
              style: TextStyle(fontFamily: "Roboto", color: Colors.blue),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link4);
              updateLinkClick(amt);
            },
            child: Text(
              link4,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link5);
              updateLinkClick(amt);
            },
            child: Text(
              link5,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link6);
              updateLinkClick(amt);
            },
            child: Text(
              link6,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(link7);
              updateLinkClick(amt);
            },
            child: Text(
              link7,
              style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget cardWidget(
    String name,
    String amount,
    String profit,
    String day,
    String link1,
    String link2,
    String link3,
    String link4,
    String link5,
    String link6,
    String link7,
  ) {
    return Center(
      child: new Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.green,
                    Colors.transparent,
                  ]),
              //color: Colors.black45, //Color(0xFF21283A),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF21283A),
                  blurRadius: 5.0,
                  spreadRadius: 5.0,
                )
              ]),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  "BNB - $name",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "RobotoBold",
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 10.0),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "  Amount    ",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                        ),
                      ),
                      Text(
                        amount + " BUSD",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Daily Income",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        profit + " BUSD",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "      day     ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        day,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [Colors.orange, Colors.pink]),
                  //Color(0xFF21283A),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RoiIncome(
                                amount: amount,
                              )),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 60.0, right: 60.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      " Check Daily Income ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.black,
                  // gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.topRight,
                  //     colors: [Colors.orange, Colors.pink]),
                  //Color(0xFF21283A),
                ),
                child: InkWell(
                  onTap: () {
                    return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    colors: [Colors.orange, Colors.pink]),
                                //Color(0xFF21283A),
                              ),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 60.0,
                                    right: 60.0,
                                    top: 5.0,
                                    bottom: 5.0),
                                child: Text(
                                  'Are you sure, to complete this task then follow the link!!',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            content: popUp(amount, link1, link2, link3, link4,
                                link5, link6, link7),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
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
                    margin: EdgeInsets.only(
                        left: 60.0, right: 60.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      " Complete Your task ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          )),
    );
  }

  Widget levelWidget() {
    return FutureBuilder(
      future: fetchLevelIncome(),
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

  Widget directRoiWidget() {
    return FutureBuilder(
      future: fetchRoiOnRoiIncome(),
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
                    padding: EdgeInsets.all(5),
                    child: dataBody2(snapshot.data)),
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
                child: Text("Level"),
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
                          income['date'],
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
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            income['level'].toString(),
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

  SingleChildScrollView dataBody2(List<dynamic> listIncome) {
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
              child: Text("Income"),
            )),
            numeric: false,
            tooltip: "Previous",
          ),
          DataColumn(
              label: Container(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("User"),
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
                          income['date'],
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
                            income['income'].toString(),
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
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            income['from_user']['username'].toString(),
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
        title: Text("Purchased Packages"),
        bottom: getTabBar(),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 100.0),
        child: getTabBarPages(),
      ),
    );
  }
}
