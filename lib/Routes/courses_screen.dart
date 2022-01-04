import 'dart:io';

import 'package:flexteach/Backend/course_description.dart';
import 'package:flexteach/Models/course.dart';
import 'package:flexteach/Widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flexteach/Providers/user_info_provider.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    List<dynamic> coursesList = userInfoProvider.getCourses;
    List<Course> coursesDescriptionList =
        userInfoProvider.getCourseDescriptionList;
    return Column(children: [
      Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        child: const Text(
          "Enrolled Courses",
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
              coursesDescriptionList[index].code,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(coursesDescriptionList[index].name),
            onTap: () {
              Navigator.of(context).pushNamed("/courseRoute",
                  arguments: {"course": coursesDescriptionList[index].code});
            },
            trailing: Platform.isIOS
                ? const Icon(Icons.arrow_forward_ios)
                : const Icon(Icons.arrow_forward),
          );
        },
        itemCount: coursesDescriptionList.length,
      ),
    ]);
  }
}
