import 'package:cloud_firestore/cloud_firestore.dart';

class Deadline {
  String course_code;
  String title;
  Timestamp deadline_date;
  Deadline(
      {required this.course_code,
      required this.title,
      required this.deadline_date});
}
