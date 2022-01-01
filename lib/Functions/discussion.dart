import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/reply.dart';
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

Future<String> getUserName(String userId) async {
  String name = '';
  print(userId);
  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get()
        .then((document) {
      print(document);
      name = document['name'].toString();
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }
  print(name);
  return name;
}

Future<List<Reply>> getReplies(List<dynamic> repliesIdsDynamic) async {
  List<Reply> replies = [];
  List<String> repliesIds = [];
  for (dynamic dynamicId in repliesIdsDynamic) {
    repliesIds.add(dynamicId.toString());
  }

  for (String replyID in repliesIds) {
    try {
      await FirebaseFirestore.instance
          .collection("replies")
          .doc(replyID)
          .get()
          .then((doc) {
        Reply newReply = Reply(
            id: doc.reference.id,
            body: doc['body'],
            timeStamp: doc['time_stamp'],
            userId: doc['user_id']);
        replies.add(newReply);

        print(doc.reference.id);
      });
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
  replies.sort((a, b) {
    return a.compareTo(b);
  });

  for (Reply reply in replies) {
    print(reply.body);
  }
  return replies;
}
