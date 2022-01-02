import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Functions/discussion.dart';
import '../Models/discussion.dart';
import '../Models/reply.dart';

class DiscussionScreen extends StatefulWidget {
  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  Discussion discussion = Discussion(
      body: "",
      course: "",
      id: "",
      open: true,
      replies: [],
      timestamp: Timestamp.now(),
      title: "",
      userId: "");
  String name = '';
  List<Reply> replies = [];
  TextEditingController replyController = TextEditingController();
  Map<String, String> userIdsAndNames = {};
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final discussionId = routeArgs["discussionId"];
    getDiscussionAsync(discussionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name + "'s Discussion"),
          backgroundColor: Colors.red,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.account_circle_rounded,
                        size: 50,
                      ),
                      title: Text(
                        name,
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(DateFormat('yyyy-MM-dd kk:mm a')
                          .format(discussion.timestamp.toDate())),
                      trailing: discussion.userId ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? Icon(Icons.more_vert)
                          : Container(
                              width: 1,
                              height: 1,
                            ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                      child: Text(
                        discussion.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                      child: Text(
                        discussion.body,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
                            child: TextField(
                              controller: replyController,
                              decoration: InputDecoration(hintText: 'Reply'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: IconButton(
                            icon: Icon(Icons.reply_rounded),
                            onPressed: () {
                              sendReply(discussion.id, replyController.text,
                                  FirebaseAuth.instance.currentUser!.uid);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 2,
                    margin: const EdgeInsets.all(2),
                    child: ListTile(
                      title: Text(userIdsAndNames[replies[index].userId]! +
                          ":" +
                          '\n' +
                          replies[index].body),
                      subtitle: Text(DateFormat('yyyy-MM-dd kk:mm a')
                          .format(replies[index].timeStamp.toDate())),
                      isThreeLine: true,
                    ),
                  );
                },
                itemCount: replies.length,
              ),
            ],
          ),
        ));
  }

  void getDiscussionAsync(discussionId) async {
    Discussion discussionAsync = await getDiscussion(discussionId);
    String nameAsync = await getUserName(discussionAsync.userId);
    List<Reply> repliesAsync = [];
    Map<String, String> usersIdMapAsync = {};
    print(discussionAsync.replies.length);
    if (discussionAsync.replies.length > 1) {
      repliesAsync = await getReplies(discussionAsync.replies);
      List<String> usersIds = [];
      for (Reply reply in repliesAsync) {
        usersIds.add(reply.userId);
      }
      print(usersIds);
      usersIdMapAsync = await getUserNames(usersIds);
    }

    setState(() {
      discussion = discussionAsync;
      name = nameAsync;
      replies = repliesAsync;
      userIdsAndNames = usersIdMapAsync;
    });
  }
}
