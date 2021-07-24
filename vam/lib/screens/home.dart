import 'package:flutter/material.dart';
import 'package:vam/screens/homepage.dart';
import 'package:vam/screens/login.dart';
import 'package:vam/screens/team.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    tabController.index = 0;
  }

  Widget getTabBar() {
    return Container(
      width: 200.0,
      child: TabBar(
          controller: tabController,
          indicatorColor: Colors.red, //indicator: BoxDecoration(

          tabs: [
            Tab(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Text(
                  "HOME",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Tab(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Text(
                  "MY TEAM",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  Widget getTabBarPages() {
    return TabBarView(controller: tabController, children: <Widget>[
      HomePage(),
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Colors.blue, Colors.red]),
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
              child: ListTile(
                leading: Icon(Icons.people_sharp),
                title: Text(
                  'First Level Team',
                  textScaleFactor: 1.5,
                ),
                trailing: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Team(
                                  level: "1",
                                )),
                      );
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                    )),
                subtitle: Text('All the users of first level'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Colors.green, Colors.red]),
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
              child: ListTile(
                leading: Icon(Icons.people_sharp),
                title: Text(
                  'Second Level Team',
                  textScaleFactor: 1.5,
                ),
                trailing: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Team(
                                  level: "2",
                                )),
                      );
                    },
                    child: Icon(Icons.arrow_forward_ios_outlined)),
                subtitle: Text('All the users of second level'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Colors.pink, Colors.red]),
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
              child: ListTile(
                leading: Icon(Icons.people_sharp),
                title: Text(
                  'Third Level Team',
                  textScaleFactor: 1.5,
                ),
                trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Team(
                                level: "3",
                              )),
                    );
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined),
                ),
                subtitle: Text('All the users of third level'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Colors.teal, Colors.red]),
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
              child: ListTile(
                leading: Icon(Icons.people_sharp),
                title: Text(
                  'Fourth Level Team',
                  textScaleFactor: 1.5,
                ),
                trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Team(
                                level: "4",
                              )),
                    );
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined),
                ),
                subtitle: Text('All the users of fourth level'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
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
              child: ListTile(
                leading: Icon(Icons.people_sharp),
                title: Text(
                  'Fifth Level Team',
                  textScaleFactor: 1.5,
                ),
                trailing: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Team(
                                  level: "5",
                                )),
                      );
                    },
                    child: Icon(Icons.arrow_forward_ios_outlined)),
                subtitle: Text('All the users of Fifth level'),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      backgroundColor: Colors.white, //Color(0xFF21283A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: getTabBar(),
        // leading: Icon(Icons.leave_bags_at_home_rounded),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_sharp),
            iconSize: 25.0,
            tooltip: 'Show Snackbar',
            onPressed: () {
              return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Are you sure?',
                          style: TextStyle(
                              fontFamily: "Roboto", color: Color(0xFF465A64))),
                      content: Text('Do you want to Logout from this App',
                          style: TextStyle(
                              fontFamily: "Roboto", color: Color(0xFF465A64))),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString("token", "null");
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Login(),
                              ),
                              (route) => false,
                            );
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
          ),
        ],
      ),
      body: getTabBarPages(),
    );
  }
}
