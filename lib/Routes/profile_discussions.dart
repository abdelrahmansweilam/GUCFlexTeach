import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import '../Backend/discussion.dart';

import '../Models/discussion.dart';
import 'package:flutter/material.dart';
import '../Backend/user_discussions.dart';

class ProfileDiscussionsScreen extends StatefulWidget {
  @override
  State<ProfileDiscussionsScreen> createState() =>
      _ProfileDiscussionsScreenState();
}

class _ProfileDiscussionsScreenState extends State<ProfileDiscussionsScreen> {
  List<Discussion> discussions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    getMyDiscussionsList(userId);
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Discussions"),
        backgroundColor: Colors.red,
      ),
      body: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 1,
          thickness: 2,
        ),
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(
              discussions[index].title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(discussions[index].body),
            onTap: () {
              Navigator.of(context).pushNamed("/discussionRoute",
                  arguments: {"discussionId": discussions[index].id});
            },
            trailing: discussions[index].open
                ? Platform.isIOS
                    ? const Icon(Icons.arrow_forward_ios)
                    : const Icon(Icons.arrow_forward)
                : const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 40,
                  ),
          );
        },
        itemCount: discussions.length,
      ),
    );
  }

  void getMyDiscussionsList(String userId) async {
    List<Discussion> courseDiscussionsListAsync =
        await getMyDiscussions(userId);
    setState(() {
      discussions = courseDiscussionsListAsync;
      print(discussions);
    });
  }
}
