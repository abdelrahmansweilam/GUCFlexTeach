import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexteach/Providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:flexteach/Assets/icons.dart';
import 'package:provider/provider.dart';
import 'courses_screen.dart';
import 'notifications_screen.dart';
import 'assignments_screen.dart';
import 'discussions_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> tabsScreens = [
    const DiscussionsScreen(),
    const CoursesScreen(),
    const NotificationsScreen(),
    const AssignmentsScreen(),
  ];
  var selectedTabIndex = 0;
  void switchPage(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var myProvider = Provider.of<UserInfoProvider>(context, listen: false);
    myProvider.fetchUserInfoFromServer(currentUserId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    final name = userInfoProvider.getName;
    if (Platform.isIOS) {
      //iOS Code
      return Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: Text(
                  name,
                  style: TextStyle(),
                ),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  Navigator.of(context).pushNamed('/profileRoute');
                },
              ),
              const Divider(
                height: 1,
                thickness: 2,
              ),
              ListTile(
                title: const Text('My Discussions'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              const Divider(
                height: 1,
                thickness: 2,
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  // '/' must stay in the stack for the user
                  // to be able to login again
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
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
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Text(
                    name,
                    style: TextStyle(),
                  ),
                ),
                ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.of(context).pushNamed('/profileRoute');
                  },
                ),
                const Divider(
                  height: 1,
                  thickness: 2,
                ),
                ListTile(
                  title: const Text('My Discussions'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                const Divider(
                  height: 1,
                  thickness: 2,
                ),
                ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/loginRoute', (Route<dynamic> route) => false);
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
