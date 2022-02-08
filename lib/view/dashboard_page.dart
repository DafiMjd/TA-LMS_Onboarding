import 'package:flutter/material.dart';
import 'package:lms_onboarding/provider/dashboard_tab_provider.dart';
import 'package:provider/provider.dart';

int _currentIndex = 0;

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardTab(),
      child: Page(),
    );
  }

  Scaffold Page() {
    final tabs = [
      Center(child: Text("Home")),
      Center(
        child: Text("Task"),
      ),
      Center(
        child: Text("Account"),
      )
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.amber,
          flexibleSpace: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Selamat Datang!",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 40),
                  child: Text("Name",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Job Title",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                )
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // background
          Container(
            color: Colors.amber,
          ),
          // white circular background
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
          ),
          //* Content

          // tulisan explore
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(20),
            child: Text("Explore",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w400)),
          ),

          Consumer<DashboardTab>(
            builder: (context, dashboardTab, _) => Container(
              child: tabs[dashboardTab.page],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardTab>(
        builder: (context, dashboardTab, _) => BottomNavigationBar(
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "",
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.task),
                    label: "",
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_box_rounded),
                    label: "",
                    backgroundColor: Colors.white),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  dashboardTab.page = index;
                });
              },
            ));
  }
}
