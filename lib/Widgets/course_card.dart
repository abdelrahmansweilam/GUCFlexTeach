import 'package:flutter/material.dart';

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
