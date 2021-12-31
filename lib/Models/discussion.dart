import 'package:cloud_firestore/cloud_firestore.dart';

class Discussion {
  String id;
  String title;
  String body;
  bool open;
  String course;
  Timestamp timestamp;
  String userId;
  List<dynamic> replies;
  Discussion(
      {required this.id,
      required this.title,
      required this.body,
      required this.open,
      required this.timestamp,
      required this.userId,
      required this.replies,
      required this.course});
}
