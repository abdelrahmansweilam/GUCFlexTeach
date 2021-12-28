// ignore_for_file: file_names

import 'package:flexteach/Functions/user_auth.dart';

import '../Functions/majors_courses.dart';
import 'package:flutter/material.dart';

class CompleteSignupScreen extends StatefulWidget {
  const CompleteSignupScreen({Key? key}) : super(key: key);

  @override
  _CompleteSignupScreenState createState() => _CompleteSignupScreenState();
}

class _CompleteSignupScreenState extends State<CompleteSignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController appIDController = TextEditingController();
  //TODO get List of Majors From DB
  List<String> majorsList = [];
  //TODO get List of Courses from DB according to Major
  List<String> courses = [];
  List<bool> coursesSelection = [];

  bool instructor = false;
  bool student = false;
  String major = 'Major';

  @override
  void initState() {
    setState(() {
      majorsList = getMajors() as List<String>;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "GUC FlexTeach",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: 600,
        margin: EdgeInsets.only(top: 25, left: 10, right: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Name"),
                  controller: nameController,
                  keyboardType: TextInputType.name,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Application ID"),
                  controller: appIDController,
                  keyboardType: TextInputType.text,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text("Instructor"),
                        Checkbox(
                            value: instructor,
                            onChanged: (bool? newValue) {
                              setState(() {
                                instructor = newValue!;
                                if (instructor & student) {
                                  student = false;
                                }
                              });
                            }),
                      ],
                    ),
                    new VerticalDivider(
                      width: 85,
                    ),
                    Row(
                      children: [
                        Text("Student"),
                        Checkbox(
                            value: student,
                            onChanged: (bool? newValue) {
                              setState(() {
                                student = newValue!;
                                if (instructor & student) {
                                  instructor = false;
                                }
                              });
                            }),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      items: majorsList
                          .map((String item) => DropdownMenuItem<String>(
                              child: Text(item), value: item))
                          .toList(),
                      value: major,
                      onChanged: (String? newValue) {
                        setState(() {
                          major = newValue!;
                          courses = getMajorCourses(major) as List<String>;
                          courses.forEach((element) {
                            coursesSelection.add(false);
                          });
                        });
                      },
                    ),
                  ],
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                          title: Text(courses[index]),
                          autofocus: true,
                          activeColor: Colors.red,
                          checkColor: Colors.white,
                          selected: coursesSelection[index],
                          value: coursesSelection[index],
                          onChanged: (bool? newValue) {
                            setState(() {
                              coursesSelection[index] = newValue!;
                            });
                          });
                    }),
                ElevatedButton(
                    onPressed: () {
                      List<String> userCourses = [];
                      for (var i = 0; i < coursesSelection.length; i++) {
                        if (coursesSelection[i] == true) {
                          userCourses.add(courses[i]);
                        }
                      }
                      completeSignup(
                          nameController.text.trimRight(),
                          appIDController.text.trim(),
                          instructor,
                          major,
                          userCourses);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/homePage', (Route<dynamic> route) => false);
                    },
                    child: Text("Sign up")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
