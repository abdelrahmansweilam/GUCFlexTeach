// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscurePassword = true;
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isObscureConfirmPassword = true;
  //TODO get List of Majors From DB
  final List<String> majorsList = ['Major', 'MET', 'IET', 'EMS'];
  //TODO get List of Courses from DB according to Major
  List<String> courses = [
    "CSEN 1114",
    "CSEN 901",
    "CSEN 1022",
    "DMET 901",
    "CSEN 903",
    "CSEN 907",
    "CSEN 1115"
  ];
  List<bool> coursesSelection = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  bool instructor = false;
  bool student = false;
  String major = 'Major';

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
                  decoration: InputDecoration(labelText: "Email"),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                        icon: Icon(_isObscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscurePassword = !_isObscurePassword;
                          });
                        }),
                  ),
                  controller: passwordController,
                  obscureText: _isObscurePassword,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    suffixIcon: IconButton(
                        icon: Icon(_isObscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscureConfirmPassword =
                                !_isObscureConfirmPassword;
                          });
                        }),
                  ),
                  controller: confirmPasswordController,
                  obscureText: _isObscureConfirmPassword,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    new Spacer(),
                    Row(
                      children: [
                        Text("Studnet"),
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
                          //TODO grab the courses attached to this major
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
                      loginORsignup();
                    },
                    child: Text("Sign up")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginORsignup() {}
}
