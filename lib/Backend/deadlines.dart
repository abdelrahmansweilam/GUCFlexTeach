import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/deadline.dart';

Future<List<Deadline>> getStudentDeadlines(List<dynamic> coursesCodes) async {
  List<Deadline> result = [];
  try {
    await FirebaseFirestore.instance
        .collection("deadlines")
        .orderBy("deadline_date", descending: false)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        if (coursesCodes.contains(doc.data()['course_code'] as String)) {
          Deadline newDeadline = Deadline(
              course_code: doc['course_code'],
              title: doc['title'],
              deadline_date: doc['deadline_date']);

          result.add(newDeadline);
        }
      }
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }
  print(result);
  return result;
}
