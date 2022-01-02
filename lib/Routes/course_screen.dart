import 'package:flexteach/Functions/course_description.dart';

import '../Models/course.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  List<String> instructors = [];
  String courseName = '';

  var discussions;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final courseCode = routeArgs["course"];
    getCourseInfoAsync(courseCode);
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final courseCode = routeArgs["course"];
    return Scaffold(
      appBar: AppBar(
        title: Text(courseCode),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                "Course name:" + '\n' + courseName,
                style: TextStyle(fontSize: 18),
              )),
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(instructors[index],
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.left),
              );
            },
            itemCount: instructors.length,
          ),
        ],
      ),
    );
  }

  void getCourseInfoAsync(courseCode) async {
    Course course = await getCourseDetails(courseCode);
    for (dynamic instructor in course.instructors) {
      instructors.add(instructor.toString());
    }
    setState(() {
      instructors = instructors;
      courseName = course.name;
      courseCode = course.code;
      print(courseCode);
    });
  }
}
