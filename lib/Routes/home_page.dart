import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flexteach/Providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import '../Assets/icons.dart';
import 'package:provider/provider.dart';
import 'add_notifications_screen.dart';
import 'courses_screen.dart';
import 'notifications_screen.dart';
import 'deadlines_screen.dart';
import 'discussions_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> tabsScreens = [];

  var selectedTabIndex = 0;
  void switchPage(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  bool showNotification = false;
  String notificationTitle = "";
  String notificationBody = "";

  @override
  void initState() {
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    userInfoProvider.fetchUserInfoFromServer(currentUserId);
    var fcm = FirebaseMessaging.instance;
    fcm.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // setState(() {
      //   showNotification = true;
      //   notificationTitle = message.notification!.title!;
      //   notificationBody = message.notification!.body!;
      // });
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification!.body}');
      }
    });
    for (var element in userInfoProvider.getCourses) {
      fcm.subscribeToTopic(element as String);
      print("Subscribed to " + element);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var fcm = FirebaseMessaging.instance;
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    final name = userInfoProvider.getName;
    final isInstructor = userInfoProvider.getIsInstructor;
    // if (showNotification) displaySnackBar();
    if (userInfoProvider.isInstructor) {
      setState(() {
        tabsScreens = [
          const DiscussionsScreen(),
          const CoursesScreen(),
          const NotificationsScreen(),
          const AddNotificationsScreen(),
        ];
      });
    } else {
      setState(() {
        tabsScreens = [
          const DiscussionsScreen(),
          const CoursesScreen(),
          const NotificationsScreen(),
          const DeadlinesScreen()
        ];
      });
    }
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
                  style: const TextStyle(),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle_outlined),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.of(context).pushNamed('/profileRoute');
                },
              ),
              const Divider(),
              if (!isInstructor)
                ListTile(
                  leading: const Icon(Icons.archive_outlined),
                  title: const Text('My Discussions'),
                  onTap: () {
                    Navigator.of(context).pushNamed('/mydiscussions');
                  },
                ),
              if (!isInstructor) const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  for (var element in userInfoProvider.getCourses) {
                    fcm.unsubscribeFromTopic(element as String);
                  }
                  FirebaseAuth.instance.signOut();
                  // '/' must stay in the stack for the user
                  // to be able to login again
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
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
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  size: 36,
                ),
                label: 'Notifications'),
            isInstructor
                ? const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.notification_add_outlined,
                      size: 36,
                    ),
                    label: 'Notify')
                : BottomNavigationBarItem(
                    icon: deadlines_icon, label: 'Deadlines')
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
                    style: const TextStyle(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle_outlined),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.of(context).pushNamed('/profileRoute');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.archive_outlined),
                  title: const Text('My Discussions'),
                  onTap: () {
                    Navigator.of(context).pushNamed('/mydiscussions');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
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
                const Tab(
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    size: 36,
                  ),
                ),
                // Due Assignments Tab
                isInstructor
                    ? const Tab(
                        icon: Icon(
                        Icons.notification_add_outlined,
                        size: 36,
                      ))
                    : Tab(icon: deadlines_icon),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const DiscussionsScreen(),
              const CoursesScreen(),
              const NotificationsScreen(),
              isInstructor
                  ? const AddNotificationsScreen()
                  : const DeadlinesScreen()
            ],
          ),
        ),
      );
    }

    //   Future<void> _showMyDialog() async {
    // return showDialog<void>(
    //   context: context,
    //   barrierDismissible: false, // user must tap button!
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text(notificationTitle),
    //       content: Text(notificationBody),
    //       actions: <Widget>[
    //         TextButton(
    //           child: const Text('Okay'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  // void displaySnackBar() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       duration: const Duration(days: 365),
  //       content: ListTile(
  //         leading: const Icon(Icons.notification_important),
  //         title: Text(notificationTitle),
  //         subtitle: Text(notificationBody),
  //       ),
  //       action: SnackBarAction(
  //         label: "Dismiss",
  //         onPressed: () {
  //           setState(() {
  //             showNotification = false;
  //             notificationTitle = "";
  //             notificationBody = "";
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }
}
