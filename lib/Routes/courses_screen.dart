import 'package:flexteach/Widgets/course_card.dart';
import 'package:flutter/material.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
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
          "Enrolled Courses",
          softWrap: true,
          overflow: TextOverflow.fade,
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          return CourseCard(courseName: coursesList[index]);
        },
        itemCount: coursesList.length,
      ),
    ]);
  }
}
