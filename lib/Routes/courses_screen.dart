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
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return CourseCard(courseName: coursesList[index]);
        },
        itemCount: coursesList.length,
      ),
    );
  }
}

class CourseCard extends StatefulWidget {
  var courseName;
  CourseCard({required this.courseName});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  navigateToCourseScreen(BuildContext myContext) {
    Navigator.of(myContext)
        .pushNamed("/courseRoute", arguments: {"course": widget.courseName});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateToCourseScreen(context),
      child: Card(
        color: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Text(widget.courseName,
            softWrap: true,
            overflow: TextOverflow.fade,
            style: TextStyle(color: Colors.white, fontSize: 30),
            textAlign: TextAlign.center),
      ),
    );
  }
}

class CourseScreen extends StatefulWidget {
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
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
          title: Text(courseName!),
        ),
        body: Column(
          children: [
            const Text("Instructors",
                softWrap: true,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
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
        ));
  }
}
