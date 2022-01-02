import '../Models/discussion.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Discussion>> getCoursesDiscussions(String courseCode) async {
  List<Discussion> discussions = [];

  try {
    await FirebaseFirestore.instance
        .collection("discussions")
        .where('course', isEqualTo: courseCode)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        Discussion newDiscussion = Discussion(
            id: doc.reference.id,
            body: doc['body'],
            open: doc['open'],
            course: doc['course'],
            replies: doc['replies'],
            timestamp: doc['time_stamp'],
            title: doc['title'],
            userId: doc['user_id']);
        discussions.add(newDiscussion);
        print(doc.reference.id);
      });
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }

  print(discussions);
  return discussions;
}
