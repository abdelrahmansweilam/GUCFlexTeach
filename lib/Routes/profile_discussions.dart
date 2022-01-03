import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import '../Backend/discussion.dart';

import '../Models/discussion.dart';
import 'package:flutter/material.dart';
import '../Backend/user_discussions.dart';

class ProfileDiscussionsScreen extends StatefulWidget {
  @override
  State<ProfileDiscussionsScreen> createState() => _ProfileDiscussionsScreenState();
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
    AddDiscussions('body', 'title', 'course', userId);
    getMyDiscussionsList(userId);

  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;


    return Scaffold(
      appBar: AppBar(
        title: Text("My Discussions"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: const Text(
              "My Discussions",
              softWrap: true,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 1,
              thickness: 2,
            ),
            itemBuilder: (ctx, index) {
              return ListTile(
                  title: Text(
                    discussions[index].title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(discussions[index].body),
                  onTap: () {
                    Navigator.of(context).pushNamed("/discussionRoute",
                        arguments: {"discussionId": discussions[index].id});
                  },
                  trailing: discussions[index].open
                      ? Icon(Icons.arrow_forward)
                      : Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 40,
                        ));
            },
            itemCount: discussions.length,
          ),
        ],
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
    DeleteDiscussion(discussions[0].id);
  }
  
  void AddDiscussions(String body, String title, String course, String userId) async{
    await AddDiscussion(body , title , course , userId);
  }

}
