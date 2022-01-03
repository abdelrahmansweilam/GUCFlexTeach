import 'package:flexteach/Models/discussion.dart';
import '../Models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Discussion>> getMyDiscussions(String userId) async {
 List<Discussion> discussions = [];

  try {
    await FirebaseFirestore.instance
        .collection("discussions")
        .where('user_id', isEqualTo: userId)
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
      //  print(doc.reference.id);
      });
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }
  print("object");
  print(discussions);
  return discussions;



}