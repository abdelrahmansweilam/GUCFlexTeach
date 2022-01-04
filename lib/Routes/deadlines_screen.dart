import 'package:flexteach/Backend/notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

import '../Providers/user_info_provider.dart';
import '../Models/deadline.dart';
import '../Assets/icons.dart';

class DeadlinesScreen extends StatefulWidget {
  const DeadlinesScreen({Key? key}) : super(key: key);

  @override
  State<DeadlinesScreen> createState() => _DeadlinesScreenState();
}

class _DeadlinesScreenState extends State<DeadlinesScreen> {
  List<Deadline> deadlines = [];

  @override
  void initState() {
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    getDeadlines(userInfoProvider.getCourses);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: const Text(
            "Due Deadlines",
            softWrap: true,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return InkWell(
                onDoubleTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Confirmation Required'),
                      content: const Text(
                          'Are you sure you want to add this deadline to your calendar?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            final Event event = Event(
                              title: deadlines[index].course_code,
                              description: deadlines[index].title,
                              startDate:
                                  deadlines[index].deadline_date.toDate(),
                              endDate: deadlines[index].deadline_date.toDate(),
                              //iOS
                              iosParams: const IOSParams(
                                reminder: Duration(
                                  hours: 1,
                                ), // on iOS, you can set alarm notification after your event.
                              ),
                            );
                            Add2Calendar.addEvent2Cal(event);
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: assignment_icon,
                    trailing: Text(
                      deadlines[index].course_code,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      deadlines[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Due on " +
                          DateFormat('dd MMM yyyy kk:mm a')
                              .format(deadlines[index].deadline_date.toDate()),
                    ),
                  ),
                ),
              );
            },
            itemCount: deadlines.length,
          ),
        ),
      ],
    );
  }

  void getDeadlines(List<dynamic> courses) async {
    List<Deadline> newDeadlines = await getStudentDeadlines(courses);
    setState(() {
      deadlines = newDeadlines;
    });
  }
}
