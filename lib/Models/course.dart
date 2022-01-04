// ignore_for_file: file_names

import 'package:flexteach/Models/deadline.dart';

class Course {
  String name;
  String code;
  List<dynamic> instructors;
  List<Deadline> deadlines;
  Course(
      {required this.code,
      required this.name,
      required this.instructors,
      required this.deadlines});
}
