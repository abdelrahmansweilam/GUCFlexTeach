import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/discussion.dart';

Future<Discussion> getDiscussion(String discussionId) async {
  Discussion discussion = Discussion(
      body: "",
      course: "",
      id: discussionId,
      open: true,
      replies: [],
      timestamp: Timestamp.now(),
      title: "",
      userId: "");

  try {
    await FirebaseFirestore.instance
        .collection("discussions")
        .doc(discussionId)
        .get()
        .then((document) {
      discussion = Discussion(
          body: document['body'],
          course: document['course'],
          id: discussionId,
          open: document['open'],
          replies: document['replies'],
          timestamp: document['time_stamp'],
          title: document['title'],
          userId: document['user_id']);
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }
  print(discussion);
  return discussion;
}
