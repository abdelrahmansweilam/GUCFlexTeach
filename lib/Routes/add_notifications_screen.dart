import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexteach/Backend/notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Providers/user_info_provider.dart';

class AddNotificationsScreen extends StatefulWidget {
  const AddNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<AddNotificationsScreen> createState() => _AddNotificationsScreenState();
}

class _AddNotificationsScreenState extends State<AddNotificationsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  List<dynamic> courses = ["Course"];
  String course = "Course";
  bool isDeadline = false;
  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  final errorSnackBar = const SnackBar(
    backgroundColor: Colors.red,
    content: Text('Error: All the input fields required.'),
  );
  final dateErrorSnackBar = const SnackBar(
    backgroundColor: Colors.red,
    content: Text('Error: A deadline must have a selected date and time.'),
  );
  final successSnackBar = const SnackBar(
    backgroundColor: Colors.green,
    content: Text('Success!!'),
  );

  @override
  void initState() {
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    setState(() {
      courses = [];
      courses.add("Course");
      for (var element in userInfoProvider.getCourses) {
        courses.add(element);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.only(
                top: 100, right: 15, left: 15, bottom: 15),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    "Send out Notifications",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  TextField(
                    decoration:
                        const InputDecoration(labelText: "Notification Title"),
                    controller: titleController,
                    keyboardType: TextInputType.text,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: "Notification Message"),
                    controller: bodyController,
                    keyboardType: TextInputType.text,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownButton<String>(
                        items: courses
                            .map((dynamic item) => DropdownMenuItem<String>(
                                child: Text(item.toString()), value: item))
                            .toList(),
                        value: course,
                        onChanged: (String? newValue) {
                          if (newValue != "Course") {
                            setState(() {
                              course = newValue!;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Deadline Notification"),
                      Checkbox(
                          value: isDeadline,
                          onChanged: (bool? newValue) {
                            setState(() {
                              isDeadline = newValue!;
                            });
                          }),
                    ],
                  ),
                  if (isDeadline)
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2023))
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  pickedDate = DateTime(
                                      value.year, value.month, value.day);
                                });
                              }
                            });
                          },
                          child: const Text("Select Date"),
                        ),
                        const Spacer(),
                        if (pickedDate != null)
                          Text("Selected Date: " +
                              DateFormat('dd MMM yyyy').format(pickedDate!)),
                      ],
                    ),
                  if (isDeadline)
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.input,
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  pickedTime = value;
                                  if (pickedDate == null) {
                                    pickedDate = DateTime(
                                        pickedTime!.hour, pickedTime!.minute);
                                  } else {
                                    pickedDate = DateTime(
                                        pickedDate!.year,
                                        pickedDate!.month,
                                        pickedDate!.day,
                                        pickedTime!.hour,
                                        pickedTime!.minute);
                                  }
                                });
                              }
                            });
                          },
                          child: const Text("Select Time"),
                        ),
                        const Spacer(),
                        if (pickedTime != null)
                          Text("Selected Time: " +
                              DateFormat('kk:mm').format(pickedDate!)),
                      ],
                    ),
                  ElevatedButton(
                    onPressed: () {
                      if (course != "Course" &&
                          titleController.text != "" &&
                          bodyController.text != "") {
                        if (pickedDate == null && !isDeadline) {
                          addNotification(course, titleController.text,
                                  bodyController.text, isDeadline)
                              .then((value) {
                            setState(() {
                              course = "Course";
                              titleController = TextEditingController();
                              bodyController = TextEditingController();
                              isDeadline = false;
                              pickedDate = null;
                              pickedTime = null;
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(successSnackBar);
                          });
                        } else if (pickedDate != null && isDeadline) {
                          addDeadline(
                                  course,
                                  titleController.text,
                                  bodyController.text,
                                  isDeadline,
                                  Timestamp.fromDate(pickedDate!))
                              .then((value) {
                            setState(() {
                              course = "Course";
                              titleController = TextEditingController();
                              bodyController = TextEditingController();
                              isDeadline = false;
                              pickedDate = null;
                              pickedTime = null;
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(successSnackBar);
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(dateErrorSnackBar);
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(errorSnackBar);
                      }
                    },
                    child: const Text("Send"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
