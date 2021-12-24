import 'package:flutter/material.dart';

class CourseDiscussionScreen extends StatefulWidget {
  @override
  State<CourseDiscussionScreen> createState() => _CourseDiscussionScreenState();
}

class _CourseDiscussionScreenState extends State<CourseDiscussionScreen> {
  List<String> instructors = [];
  var discussions;
  Future<void> getCourseInfo() async {
    //await course info from DB
    instructors = ["Dr. x", "TA y"];
    discussions = [];
  }

  @override
  void initState() {
    getCourseInfo();
    super.initState();
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
              "Instructors",
              softWrap: true,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return Text(instructors[index],
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  textAlign: TextAlign.left);
            },
            itemCount: instructors.length,
          ),
        ],
      ),
    );
  }
}
