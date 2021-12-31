import 'package:flutter/material.dart';

class DiscussionScreen extends StatefulWidget {
  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final discussionId = routeArgs["discussionId"];
    return Scaffold(
        appBar: AppBar(
          title: Text(discussionId!),
          backgroundColor: Colors.red,
        ),
        body: Card());
  }
}
