// ignore_for_file: file_names

class Course {
  String name;
  String code;
  List<dynamic> instructors;
  List<dynamic> deadlines;
  Course(
      {required this.code,
      required this.name,
      required this.instructors,
      required this.deadlines});
}
