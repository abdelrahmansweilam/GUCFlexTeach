import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/notification.dart';
import '../Models/deadline.dart';

Future<void> addNotification(String course_code, String title, String body,
    bool isDeadline, Timestamp deadline_date) async {
  try {
    await FirebaseFirestore.instance.collection('deadlines').add({
      'course_code': course_code,
      'title': title,
      'body': body,
      'isDeadline': isDeadline,
      'deadline_date': deadline_date,
      'time_created': Timestamp.now(),
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }
}

Future<List<UserNotification>> getUserNotifications(
    List<dynamic> courses) async {
  List<UserNotification> result = [];
  try {
    await FirebaseFirestore.instance
        .collection("deadlines")
        .orderBy("time_created", descending: false)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        if (courses.contains(doc.data()['course_code'] as String)) {
          String notification_title = doc['title'];
          String notification_body =
              doc['title'] + " is now posted on the CMS.";
          UserNotification newNotification = UserNotification(
            title: doc['title'],
            body: doc['body'],
            topic: doc['course_code'],
            time_created: doc['time_created'],
          );
          result.add(newNotification);
        }
      }
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }
  return result;
}

Future<List<Deadline>> getStudentDeadlines(List<dynamic> coursesCodes) async {
  List<Deadline> result = [];
  try {
    await FirebaseFirestore.instance
        .collection("deadlines")
        .where('isDeadline', isEqualTo: true)
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
  result.sort((a, b) {
    return a.compareTo(b);
  });
  return result;
}
