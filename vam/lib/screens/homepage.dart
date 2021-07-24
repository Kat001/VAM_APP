import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vam/Components/animate.dart';
import 'package:vam/screens/dashboard.dart';
import 'package:vam/screens/payment.dart';
import 'package:vam/screens/w_history.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _userFundTransferController = TextEditingController();
  TextEditingController _amountFundTransferController = TextEditingController();
  TextEditingController _withdrawalController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  String total_income = "";
  String total_withdrawal = "";
  String total_profit = "";
  bool isData = false;
  String username = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _launchURL() async =>
      await canLaunch("https://www.cryptocraze.co.in/add-fund/")
          ? await launch("https://www.cryptocraze.co.in/add-fund/")
          : throw 'Could not launch https://www.cryptocraze.co.in/add_tron/';

  Future<List<dynamic>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    Map data = {
      // "amount": packageAmount,
    };

    var body = json.encode(data);

    var url = Uri.parse('https://www.cryptocraze.co.in/api/main-page/');
    var res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
      // body: body,
    );
    print(res.body);
    print(res.statusCode);
    var responseData = json.decode(res.body);
    if (res.statusCode == 200) {
      setState(() {
        total_income = responseData['total_income'].toString();
        total_withdrawal = responseData['total_Withdrawal'].toString();
        total_profit = responseData['total_profit'].toString();
        username = responseData['username'].toString();
        isData = true;
      });
    } else {}

    return responseData['data'];
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 5), () {
      Navigator.push(context, SlideRightRoute(page: Dashboard()));
      //pop dialog
    });
  }

  Future _withdrawal() async {
    _onLoading();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    Map data = {
      "amount": _withdrawalController.text,
      "wallet_address": _addressController.text,
    };

    var body = json.encode(data);

    var url = Uri.parse('https://www.cryptocraze.co.in/api/withdrawal/');
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
      body: body,
    );
    var responseData = json.decode(res.body);
    print(res.body);
    if (res.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) =>
            CustomDialog("Success", responseData['message'], "Okay", 3),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              CustomDialogError("Error", responseData['message'], "Cancel"));
    }
  }

  Widget cardWidget(String name, String amount, String profit, String day) {
    return Center(
      child: new Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.topRight,
            //     colors: [
            //       Colors.black,
            //       Colors.transparent,
            //     ]),
            color: Color(0xFF9a6632),
            // boxShadow: [
            //   BoxShadow(
            //     color: Color(0xFF21283A),
            //     blurRadius: 5.0,
            //     spreadRadius: 5.0,
            //   )
            // ],
          ),
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
                        "      days     ",
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
              InkWell(
                onTap: () {
                  return showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Are you sure?',
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Color(0xFF465A64))),
                          content: Text('Do you want to Purchase this Package',
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Color(0xFF465A64))),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () async {
                                _purchasePackage(amount);
                                Navigator.of(context).pop(false);
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
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [Colors.orange, Colors.pink]),
                    //Color(0xFF21283A),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 60.0, right: 60.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      " Upgrade ",
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

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure you want add some BUSD!!'),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  print("clicked");
                  setState(() {
                    Navigator.pop(context);
                  });
                  _launchURL();
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayTextInputDialogforwithdrawal(
      BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('Enter the amount BUSD!!'),
                  TextFormField(
                    controller: _addressController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter the address.";
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 0),
                      labelText: 'Wallet Address...',
                    ),
                  ),
                  TextFormField(
                    controller: _withdrawalController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter amount.";
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 0),
                      labelText: 'amount',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('History'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WithdrawalHistory()),
                  );
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _withdrawal();
                  }
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayTwoTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Transfer fund to another user!!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _userFundTransferController,
                  decoration: InputDecoration(hintText: "Enter Username"),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _amountFundTransferController,
                  decoration: InputDecoration(hintText: "Enter Amount"),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                  if (_userFundTransferController.text != null &&
                      _amountFundTransferController.text != null) {
                    _fundTransfer();
                  }
                },
              ),
            ],
          );
        });
  }

  Widget incomeWidget() {
    return Center(
      child: new Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Colors.orange, Colors.red]),
            borderRadius: BorderRadius.circular(8),
            //color: Colors.black45, //Color(0xFF21283A),
            // boxShadow: [
            //   BoxShadow(
            //     color: Color(0xFF21283A),
            //     blurRadius: 5.0,
            //     spreadRadius: 5.0,
            //   )
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SizedBox(height: 10.0),
                  Text(
                    "Total Income",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    total_income,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 10.0),
                  Text(
                    "Total Withdrawal",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    total_withdrawal,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 10.0),
                  Text(
                    "Profit Wallet",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    total_profit,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ],
          )),
    );
  }

  Widget menuWidget() {
    return Center(
      child: new Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Colors.orange, Colors.red]),
            //color: Colors.black45, //Color(0xFF21283A),
            // boxShadow: [
            //   BoxShadow(
            //     color: Color(0xFF21283A),
            //     blurRadius: 5.0,
            //     spreadRadius: 5.0,
            //   )
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  _displayTextInputDialog(context);
                },
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      Icon(
                        Icons.mobile_friendly_rounded,
                        color: Colors.black,
                        size: 36.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Add BUSD",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _displayTextInputDialogforwithdrawal(context);
                },
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      Icon(
                        Icons.money,
                        color: Colors.black,
                        size: 36.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Withdraw",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _displayTwoTextInputDialog(context);
                },
                child: Container(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 20.0),
                          Icon(
                            Icons.transfer_within_a_station,
                            color: Colors.black,
                            size: 36.0,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Transfer",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Share.share(
                      'https://www.cryptocraze.co.in/account/sign-up/$username');
                },
                child: Container(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 20.0),
                          Icon(
                            Icons.share,
                            color: Colors.black,
                            size: 36.0,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Share",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget packageWidget() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.arrow_drop_down_circle),
            title: const Text('Card title 1'),
            subtitle: Text(
              'Secondary Text',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                textColor: const Color(0xFF6200EE),
                onPressed: () {
                  // Perform some action
                },
                child: const Text('ACTION 1'),
              ),
              FlatButton(
                textColor: const Color(0xFF6200EE),
                onPressed: () {
                  // Perform some action
                },
                child: const Text('ACTION 2'),
              ),
            ],
          ),
          Image.asset('assets/card-sample-image.jpg'),
          Image.asset('assets/card-sample-image-2.jpg'),
        ],
      ),
    );
  }

  Widget sliderWidget() {
    return SizedBox(
      height: 300.0,
      width: double.infinity,
      child: Carousel(
        boxFit: BoxFit.cover,
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 6.0,
        dotIncreasedColor: Color(0xFFFF335C),
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomCenter,
        dotVerticalPadding: 10.0,
        showIndicator: true,
        indicatorBgPadding: 7.0,
        images: [
          Container(
            margin: new EdgeInsets.only(right: 35, left: 35, bottom: 10),
            child: Image(
              image: AssetImage('assets/images/crazelogo.png'),
              height: 220.0,
              width: 220.0,
            ),
          ),
          Container(
            margin: new EdgeInsets.only(right: 35, left: 35, bottom: 10),
            child: Image(
              image: AssetImage('assets/images/vam1.jpeg'),
              height: 220.0,
              width: 220.0,
            ),
          ),
          Container(
            margin: new EdgeInsets.only(right: 35, left: 35, bottom: 10),
            child: Image(
              image: AssetImage('assets/images/vam2.jpeg'),
              height: 220.0,
              width: 220.0,
            ),
          ),
          Container(
            margin: new EdgeInsets.only(right: 35, left: 35, bottom: 10),
            child: Image(
              image: AssetImage('assets/images/vam3.jpeg'),
              height: 220.0,
              width: 220.0,
            ),
          ),
          Container(
            margin: new EdgeInsets.only(right: 35, left: 35, bottom: 10),
            child: Image(
              image: AssetImage('assets/images/vam4.jpeg'),
              height: 220.0,
              width: 220.0,
            ),
          ),
          Container(
            margin: new EdgeInsets.only(right: 35, left: 35, bottom: 10),
            child: Image(
              image: AssetImage('assets/images/vam5.jpeg'),
              height: 220.0,
              width: 220.0,
            ),
          ),
          Container(
            margin: new EdgeInsets.only(right: 35, left: 35, bottom: 10),
            child: Image(
              image: AssetImage('assets/images/vam6.jpeg'),
              height: 220.0,
              width: 220.0,
            ),
          ),
          Container(
            margin: new EdgeInsets.only(right: 35, left: 35, bottom: 10),
            child: Image(
              image: AssetImage('assets/images/vam7.jpeg'),
              height: 220.0,
              width: 220.0,
            ),
          ),
          Container(
            margin: new EdgeInsets.only(right: 35, left: 35, bottom: 10),
            child: Image(
              image: AssetImage('assets/images/vam8.jpeg'),
              height: 220.0,
              width: 220.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          // padding: EdgeInsets.all(10.0),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sliderWidget(),
          // cardWidget(),
          incomeWidget(),
          menuWidget(),
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Our Packages:',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          cardWidget("01", "10", "0.1", "200"),
          cardWidget("02", "50", "1", "125"),
          cardWidget("03", "100", "2", "125"),
          cardWidget("04", "500", "15", "100"),
          cardWidget("05", "1000", "30", "100"),
          SizedBox(height: 30.0),
        ],
      )),
    );
  }

  Future _purchasePackage(String amount) async {
    int packageAmount = int.parse(amount);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    Map data = {
      "amount": packageAmount,
    };

    var body = json.encode(data);

    var url = Uri.parse('https://www.cryptocraze.co.in/api/purchase-package/');
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
      body: body,
    );
    var responseData = json.decode(res.body);
    if (res.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
            "Success", "You have purchased this package.", "Okay", 3),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) => Center(
                child: CustomDialogError(
                    "Error", responseData['message'], "Cancel"),
              ));
    }
  }

  Future _fundTransfer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = "Token " + token;

    Map data = {
      "username": _userFundTransferController.text,
      "fund": _amountFundTransferController.text,
    };

    var body = json.encode(data);

    var url = Uri.parse('https://www.cryptocraze.co.in/api/transfer-fund/');
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
      body: body,
    );
    var responseData = json.decode(res.body);
    if (res.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) =>
            CustomDialog("Success", "You have transfered the Fund!", "Okay", 3),
      );
    }

    if (res.statusCode == 201) {
      showDialog(
          context: context,
          builder: (context) => Center(
                child: CustomDialogError("Error",
                    "You do not have enough balance to send!!", "Cancel"),
              ));
    }
    if (res.statusCode == 404) {
      showDialog(
          context: context,
          builder: (context) => Center(
                child:
                    CustomDialogError("Error", "Username is Wrong", "Cancel"),
              ));
    }
  }
}
