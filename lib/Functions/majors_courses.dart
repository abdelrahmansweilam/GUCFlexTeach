import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

Future<dynamic> getMajorCourses(String major) async {
  try {
    List courses = [];
    await FirebaseFirestore.instance
        .collection("majors")
        .where('major', isEqualTo: major)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        courses = doc['courses'];
      });
      return courses;
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }
}
