import 'package:flutter/material.dart';
import 'package:vam/screens/download.dart';
import 'package:vam/screens/home.dart';
import 'package:vam/screens/plan%20.dart';
import 'package:vam/screens/profile.dart';
import 'package:vam/screens/income.dart';
import 'package:vam/screens/task.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Home(),
    Income(),
    Task(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        iconSize: 25.0,
        backgroundColor: Color(0xFF21283A), //Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 1, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.money),
            title: Text('Income'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.task),
            title: Text('Tasks'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Me'),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
