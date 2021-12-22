import 'package:flexteach/Routes/assignments_screen.dart';
import 'package:flexteach/Routes/courses_screen.dart';
import 'package:flexteach/Routes/notifications_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'dart:io' show Platform;

import 'package:flexteach/Assets/icons.dart';
import 'discussions_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> tabsScreens = [
    DiscussionsScreen(),
    CoursesScreen(),
    NotificationsScreen(),
    AssignmentsScreen(),
  ];
  var selectedTabIndex = 0;
  void switchPage(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      //iOS Code
      return Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text(
                  "Username goes here!!",
                  style: TextStyle(),
                ),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  Navigator.of(context).pushNamed('/profileRoute');
                },
              ),
              ListTile(
                title: const Text('My Discussions'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ), // Populate the Drawer in the next step.
        ),
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.account_circle_rounded,
                  size: 36,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: const Text(
            "GUC FlexTeach",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: tabsScreens[selectedTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: discussion_icon, label: 'Discussions'),
            BottomNavigationBarItem(icon: courses_icon, label: 'Courses'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  size: 36,
                ),
                label: 'Notifications'),
            BottomNavigationBarItem(
                icon: assignment_icon, label: 'Assignments'),
          ],
          currentIndex: selectedTabIndex,
          onTap: switchPage,
        ),
      );
    } else {
      // Android Code
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Text(
                    "Username goes here!!",
                    style: TextStyle(),
                  ),
                ),
                ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.of(context).pushNamed('/profileRoute');
                  },
                ),
                ListTile(
                  title: const Text('My Discussions'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ), // Populate the Drawer in the next step.
          ),
          appBar: AppBar(
            backgroundColor: Colors.red,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.account_circle_rounded,
                    size: 36,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            title: const Text(
              "GUC FlexTeach",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            bottom: TabBar(
              tabs: [
                // Discussions Tab
                Tab(icon: discussion_icon),
                // Courses Tab
                Tab(icon: courses_icon),
                // Notifications Tab
                Tab(
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    size: 36,
                  ),
                ),
                // Due Assignments Tab
                Tab(icon: assignment_icon),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              DiscussionsScreen(),
              CoursesScreen(),
              NotificationsScreen(),
              AssignmentsScreen()
            ],
          ),
        ),
      );
    }
  }
}
