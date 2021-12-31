import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscussionCard extends StatefulWidget {
  String id;
  String title;
  String body;
  Timestamp time;
  DiscussionCard({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
  });

  @override
  State<DiscussionCard> createState() => _DiscussionCardState();
}

class _DiscussionCardState extends State<DiscussionCard> {
  navigateToDiscussionScreen(BuildContext myContext) {
    Navigator.of(myContext)
        .pushNamed("/discussionRoute", arguments: {"discussion_id": widget.id});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigateToDiscussionScreen(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(widget.title),
            Text(widget.body),
            
          ],
        ),
      ),
    );
  }
}
