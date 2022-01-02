import 'dart:io';

import '../Models/discussion.dart';
import 'package:flutter/material.dart';
import '../Functions/course_discussions.dart';

class CourseDiscussionScreen extends StatefulWidget {
  @override
  State<CourseDiscussionScreen> createState() => _CourseDiscussionScreenState();
}

class _CourseDiscussionScreenState extends State<CourseDiscussionScreen> {
  List<Discussion> discussions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final courseName = routeArgs["course"];
    getCoursesDiscussionsList(courseName);
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final courseName = routeArgs["course"];

    return Scaffold(
      appBar: AppBar(
        title: Text(courseName! + "'s Discussions"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: const Text(
              "Discussions",
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
                      ? Platform.isIOS
                          ? Icon(Icons.arrow_forward_ios)
                          : Icon(Icons.arrow_forward)
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

  void getCoursesDiscussionsList(String courseName) async {
    List<Discussion> courseDiscussionsListAsync =
        await getCoursesDiscussions(courseName);
    setState(() {
      discussions = courseDiscussionsListAsync;
      print(discussions);
    });
  }
}
