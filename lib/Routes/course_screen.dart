import 'package:flexteach/Assets/icons.dart';
import 'package:flexteach/Models/deadline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Backend/course_description.dart';
import '../Models/course.dart';

class CourseScreen extends StatefulWidget {
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  List<String> instructors = [];
  String courseName = '';
  List<Deadline> deadlines = [];

  var discussions;

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
        backgroundColor: Colors.red,
        title: Text(courseCode),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
        child: SingleChildScrollView(
          child: Column(children: [
            const CircleAvatar(
              radius: 100,
              // user's profile pic if present
              //foregroundImage: NetworkImage(userAvatarUrl),

              // generic avatar otherwise
              backgroundImage: NetworkImage(
                  "https://www.jobiano.com/uploads/jobs/22495/image/othyf-edary-baljamaa-alalmany-6022c0ed4f4c0.jpg"),

              // alternatively, the user's intials could be used if they don't have a profile pic
              //backgroundColor: Colors.grey.shade800,
              //child: const Text('AH'),
            ),
            Text(courseCode,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.left),
            Text(courseName,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
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
                    instructors[index],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              },
              itemCount: instructors.length,
            ),
            const Divider(),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Deadlines",
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
                return Card(
                  child: ListTile(
                    leading: assignment_icon,
                    trailing: Text(
                      deadlines[index].course_code,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      deadlines[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Due on " +
                          DateFormat('dd MMM yyyy kk:mm a')
                              .format(deadlines[index].deadline_date.toDate()),
                    ),
                  ),
                );
              },
              itemCount: deadlines.length,
            ),
          ]),
        ),
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
      deadlines = course.deadlines;
      print(courseCode);
    });
  }
}
