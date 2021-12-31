import 'package:cloud_firestore/cloud_firestore.dart';

import '../Functions/discussion.dart';

import '../Models/discussion.dart';
import 'package:flutter/material.dart';

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
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final discussionId = routeArgs["discussionId"];
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
              children: [Text(discussion.title), Text(discussion.body)],
            ),
          ),
        ));
  }

  void getDiscussionAsync(discussionId) async {
    Discussion discussionAsync = await getDiscussion(discussionId);
    setState(() {
      discussion = discussionAsync;
    });
  }
}
