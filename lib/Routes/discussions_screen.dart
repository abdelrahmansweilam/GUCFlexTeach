import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/course.dart';
import '../Providers/user_info_provider.dart';
import '../Backend/course_description.dart';

class DiscussionsScreen extends StatefulWidget {
  const DiscussionsScreen({Key? key}) : super(key: key);

  @override
  State<DiscussionsScreen> createState() => _DiscussionsScreenState();
}

class _DiscussionsScreenState extends State<DiscussionsScreen> {
  // List<Course> coursesDescriptionList = [];

  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final userInfoProvider = Provider.of<UserInfoProvider>(context);
  //   final coursesList = userInfoProvider.getCourses;
  //   getCoursesDescriptionList(coursesList);
  // }

  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    List<Course> coursesDescriptionList =
        userInfoProvider.getCourseDescriptionList;
    return Column(children: [
      Container(
        margin: const EdgeInsets.all(10),
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
              coursesDescriptionList[index].code,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(coursesDescriptionList[index].name),
            onTap: () {
              Navigator.of(context).pushNamed("/courseDiscussionsRoute",
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

  // void getCoursesDescriptionList(coursesList) async {
  //   List<Course> courseDesciptionListAsync =
  //       await getCoursesDescription(coursesList);
  //   setState(() {
  //     coursesDescriptionList = courseDesciptionListAsync;
  //   });
  // }
}
