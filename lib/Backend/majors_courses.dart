import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> getMajors() async {
  List<String> majors = ["Major"];
  try {
    await FirebaseFirestore.instance
        .collection("majors")
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        majors.add(doc["major"]);
      });
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }
  return majors;
}

Future<List<String>> getMajorCourses(String major) async {
  List<String> courses = [];
  try {
    await FirebaseFirestore.instance
        .collection("majors")
        .where('major', isEqualTo: major)
        .limit(1)
        .get()
        .then((snapshot) {
      for (var item in snapshot.docs[0]['courses']) {
        courses.add(item as String);
      }
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }
  print(courses);
  return courses;
}
