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
                  final Event event = Event(
                    title: deadlines[index].course_code,
                    description: deadlines[index].title,
                    startDate: deadlines[index].deadline_date.toDate(),
                    endDate: deadlines[index].deadline_date.toDate(),
                  //TODO Add reminder in IOS
                    // iosParams: IOSParams(
                    //   reminder: Duration(
                    //       /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
                    // ),
                  );
                  Add2Calendar.addEvent2Cal(event);
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
