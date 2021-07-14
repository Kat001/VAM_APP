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

  Future<List<dynamic>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    var url = Uri.parse('http://127.0.0.1:8000/api/return-pack/');
    var res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
    );
    var responseData = json.decode(res.body);
    print(responseData['data']);
    return responseData['data'];
  }

  Future<List<dynamic>> fetchLevelIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    var url = Uri.parse('http://127.0.0.1:8000/api/level-income/');
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

    var url = Uri.parse('http://127.0.0.1:8000/api/roi-on-roi/');
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
    return FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                // scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data[index]['amount'] == 10.0) {
                    return cardWidget("01", "10", "0.1", "200");
                  }
                  if (snapshot.data[index]['amount'] == 50.0) {
                    return cardWidget("02", "50", "1", "125");
                  }
                  if (snapshot.data[index]['amount'] == 100.0) {
                    return cardWidget("03", "100", "2", "125");
                  }
                  if (snapshot.data[index]['amount'] == 500.0) {
                    return cardWidget("04", "500", "15", "100");
                  }
                  if (snapshot.data[index]['amount'] == 1000.0) {
                    return cardWidget("05", "1000", "30", "1000");
                  }
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget popUp(String amount) {
    int amt = int.parse(amount);
    if (amt == 10) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
        ],
      );
    }
    if (amt == 50) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
        ],
      );
    }
    if (amt == 100) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
        ],
      );
    }
    if (amt == 500) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
        ],
      );
    }
    if (amt == 1000) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
          InkWell(
            onTap: () => launch(
                'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
            child: Text('https://pypi.org/project/django-rest-passwordreset/',
                style:
                    TextStyle(fontFamily: "Roboto", color: Color(0xFF465A64))),
          ),
        ],
      );
    }
  }

  Widget cardWidget(String name, String amount, String profit, String day) {
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
                      " Cheak Daily Income ",
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
                            title: Text(
                                'Are you sure, to complete this task then follow the link!!',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Color(0xFF465A64))),
                            content: popUp(amount),
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
      body: getTabBarPages(),
    );
  }
}
