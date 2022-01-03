import 'package:cloud_firestore/cloud_firestore.dart';

class UserNotification {
  String title;
  String body;
  String topic;
  Timestamp time_created;
  UserNotification(
      {required this.title,
      required this.body,
      required this.time_created,
      required this.topic});
}
