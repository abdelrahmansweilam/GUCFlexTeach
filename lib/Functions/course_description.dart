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
              deadlines: doc['deadlines'],
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
