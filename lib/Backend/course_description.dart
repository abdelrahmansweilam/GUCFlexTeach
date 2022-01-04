import 'package:flexteach/Models/deadline.dart';

import '../Models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'notifications.dart';

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
        for (var doc in snapshot.docs) {
          Course newCourse = Course(
              code: doc['code'],
              name: doc['name'],
              instructors: doc['instructors'],
              deadlines: []);
          courses.add(newCourse);
        }
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
  Course newCourse = Course(code: '', name: '', instructors: [], deadlines: []);
  try {
    await FirebaseFirestore.instance
        .collection("courses")
        .where('code', isEqualTo: courseCode)
        .limit(1)
        .get()
        .then((snapshot) async {
      for (var doc in snapshot.docs) {
        List<Deadline> deadlines = await getCourseDeadlines(doc['code']);
        newCourse = Course(
          code: doc['code'],
          name: doc['name'],
          instructors: doc['instructors'],
          deadlines: deadlines,
        );
      }
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }

  print(newCourse);
  return newCourse;
}
