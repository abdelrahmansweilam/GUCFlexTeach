import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

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
          backgroundColor: Colors.red,
        ),
        body: Container(
          width: double.infinity,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(discussion.title),
                Text(discussion.body),
                Text(name)
              ],
            ),
          ),
        ));
  }

  void getDiscussionAsync(discussionId) async {
    Discussion discussionAsync = await getDiscussion(discussionId);
    String nameAsync = await getUserName(discussionAsync.userId);
    List<Reply> repliesAsync = await getReplies(discussionAsync.replies);
    
    setState(() {
      discussion = discussionAsync;
      name = nameAsync;
      replies = repliesAsync;
    });
  }
}
