import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flexteach/Backend/notifications.dart';
import 'package:flexteach/Models/notification.dart';
import '../Providers/user_info_provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<UserNotification> notifications = [];
  @override
  void initState() {
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    getNotifications(userInfoProvider.getCourses);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: const Text(
            "Notifications",
            softWrap: true,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.notification_important_rounded,
                    size: 40,
                  ),
                  isThreeLine: true,
                  title: Text(
                    notifications[index].topic +
                        ": " +
                        notifications[index].title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(notifications[index].body +
                      " Posted on " +
                      DateFormat('dd MMM yyyy')
                          .format(notifications[index].time_created.toDate()) +
                      "at " +
                      DateFormat('kk:mm')
                          .format(notifications[index].time_created.toDate())),
                ),
              );
            },
            itemCount: notifications.length,
          ),
        ),
      ],
    );
  }

  Future<void> getNotifications(List<dynamic> courses) async {
    List<UserNotification> newNotification =
        await getUserNotifications(courses);
    setState(() {
      notifications = newNotification;
    });
  }
}
