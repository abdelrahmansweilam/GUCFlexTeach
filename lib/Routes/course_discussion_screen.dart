import 'dart:io';
import 'package:flexteach/Backend/discussion.dart';
import 'package:flutter/material.dart';

import '../Models/discussion.dart';
import '../Backend/course_discussions.dart';

class CourseDiscussionScreen extends StatefulWidget {
  @override
  State<CourseDiscussionScreen> createState() => _CourseDiscussionScreenState();
}

class _CourseDiscussionScreenState extends State<CourseDiscussionScreen> {
  List<Discussion> discussions = [];
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
    content: Text('Your discussion has been added successfully!'),
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final courseName = routeArgs["course"];
    getCoursesDiscussionsList(courseName);
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final courseName = routeArgs["course"];
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(courseName! + "'s Discussions"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0))),
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Add a Discussion to ' + courseName,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                  labelText: "Discussion Title"),
                              controller: titleController,
                              keyboardType: TextInputType.text,
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                  labelText: "Discussion Body"),
                              controller: bodyController,
                              keyboardType: TextInputType.text,
                            ),
                            ElevatedButton(
                              child: const Text('Add'),
                              onPressed: () {
                                if (titleController.text != "" &&
                                    bodyController.text != "") {
                                  addDiscussion(titleController.text,
                                          bodyController.text, courseName)
                                      .then((value) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(successSnackBar);
                                    Navigator.pop(context);
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(errorSnackBar);
                                  Navigator.pop(context);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.create))
        ],
      ),
      body: Column(
        children: [
          // Container(
          //   margin: const EdgeInsets.all(10),
          //   width: double.infinity,
          //   child: const Text(
          //     "Discussions",
          //     softWrap: true,
          //     overflow: TextOverflow.fade,
          //     style: TextStyle(
          //       fontSize: 28,
          //       fontWeight: FontWeight.bold,
          //     ),
          //     textAlign: TextAlign.left,
          //   ),
          // ),
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
                    discussions[index].title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(discussions[index].body),
                  onTap: () {
                    Navigator.of(context).pushNamed("/discussionRoute",
                        arguments: {
                          "discussionId": discussions[index].id
                        }).then((_) {
                      getCoursesDiscussionsList(courseName);
                    });
                  },
                  trailing: discussions[index].open
                      ? Platform.isIOS
                          ? const Icon(Icons.arrow_forward_ios)
                          : const Icon(Icons.arrow_forward)
                      : const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 40,
                        ));
            },
            itemCount: discussions.length,
          ),
        ],
      ),
    );
  }

  void getCoursesDiscussionsList(String courseName) async {
    List<Discussion> courseDiscussionsListAsync =
        await getCoursesDiscussions(courseName);
    setState(() {
      discussions = courseDiscussionsListAsync;
      print(discussions);
    });
  }
}
