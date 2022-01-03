import '../Models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Course>> getCoursesDescription(List<dynamic> coursesCodes) async {
  List<Course> courses = [];
  for (String code in coursesCodes) {
    try {
      await FirebaseFirestore.instance
          .collection("courses")
          .where('code', isEqualTo: code)
          .limit(1)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((doc) {
          Course newCourse = Course(
              code: doc['code'],
              name: doc['name'],
              instructors: doc['instructors']);
          courses.add(newCourse);
        });
      });
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
  print(courses);
  return courses;
}

Future<Course> getCourseDetails(String courseCode) async {
  Course newCourse = Course(code: '', name: '', instructors: []);
  try {
    await FirebaseFirestore.instance
        .collection("courses")
        .where('code', isEqualTo: courseCode)
        .limit(1)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        newCourse = Course(
            code: doc['code'],
            name: doc['name'],
            instructors: doc['instructors']);
      });
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }

  print(newCourse);
  return newCourse;
}
