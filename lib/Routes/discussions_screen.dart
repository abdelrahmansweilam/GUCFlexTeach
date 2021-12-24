import 'dart:io';

import 'package:flexteach/Widgets/course_card.dart';
import 'package:flutter/material.dart';

class DiscussionsScreen extends StatefulWidget {
  const DiscussionsScreen({Key? key}) : super(key: key);

  @override
  State<DiscussionsScreen> createState() => _DiscussionsScreenState();
}

class _DiscussionsScreenState extends State<DiscussionsScreen> {
  var coursesList;

  Future<void> getMyCourses() async {
    // await coursesList = get from DB
    coursesList = ["CSEN1114", "CSEN901"];
  }

  @override
  void initState() {
    getMyCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        child: const Text(
          "Courses' Discussions",
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
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 1,
          thickness: 2,
        ),
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(
              coursesList[index],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Course Name"),
            onTap: () {
              Navigator.of(context).pushNamed("/courseDiscussionsRoute",
                  arguments: {"course": coursesList[index]});
            },
            trailing: Platform.isIOS
                ? Icon(Icons.arrow_forward_ios)
                : Icon(Icons.arrow_forward),
          );
        },
        itemCount: coursesList.length,
      ),
    ]);
  }
}
