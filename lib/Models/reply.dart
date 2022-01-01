import 'package:cloud_firestore/cloud_firestore.dart';

class Reply {
  String id;
  String userId;
  String body;
  Timestamp timeStamp;
  Reply(
      {required this.id,
      required this.userId,
      required this.body,
      required this.timeStamp});
  int compareTo(Reply r) {
    return timeStamp.compareTo(r.timeStamp);
  }
}
