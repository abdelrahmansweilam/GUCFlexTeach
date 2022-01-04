import 'package:flutter/material.dart';

import '../Backend/user_auth.dart';
import '../Backend/majors_courses.dart';

class CompleteSignupScreen extends StatefulWidget {
  const CompleteSignupScreen({Key? key}) : super(key: key);

  @override
  _CompleteSignupScreenState createState() => _CompleteSignupScreenState();
}

class _CompleteSignupScreenState extends State<CompleteSignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController appIDController = TextEditingController();
  List<String> majorsList = [];
  List<String> courses = [];
  List<bool> coursesSelection = [];

  bool instructor = false;
  bool student = false;
  String major = 'Major';

  @override
  void initState() {
    getMajorslist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SnackBar createSnackBar(String message) {
      return SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "GUC FlexTeach",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
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
                    onChanged: (String? newValue) async {
                      if (newValue != "Major") {
                        List<String> newCourses =
                            await getMajorCourses(newValue as String);
                        setState(() {
                          courses = newCourses;
                          major = newValue;
                          courses.forEach((element) {
                            coursesSelection.add(false);
                          });
                        });
                      }
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
                  onPressed: () async {
                    List<String> userCourses = [];
                    for (var i = 0; i < coursesSelection.length; i++) {
                      if (coursesSelection[i] == true) {
                        userCourses.add(courses[i]);
                      }
                    }
                    if (nameController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                          createSnackBar('Name must not be empty'));
                    } else {
                      if (appIDController.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            createSnackBar('Application ID must not be empty'));
                      } else {
                        if (!instructor && !student) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              createSnackBar(
                                  'Choose whether you are student or instructor'));
                        } else {
                          if (major == 'Major') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(createSnackBar('Choose a major'));
                          } else {
                            if (userCourses.length == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  createSnackBar(
                                      'You musr choose atleast one course'));
                            } else {
                              try {
                                await completeSignup(
                                    nameController.text.trimRight(),
                                    appIDController.text.trim(),
                                    instructor,
                                    major,
                                    userCourses);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/homePage',
                                    (Route<dynamic> route) => false);
                              } catch (e) {
                                List l = e.toString().split("]");
                                String errorMessage = l[1];

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(createSnackBar(errorMessage));
                              }
                            }
                          }
                        }
                      }
                    }
                  },
                  child: Text("Sign up")),
            ],
          ),
        ),
      ),
    );
  }

  void getMajorslist() async {
    List<String> newMajorsList = await getMajors();
    setState(() {
      majorsList = newMajorsList;
    });
  }
}
