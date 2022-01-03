import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Backend/discussion.dart';
import '../Models/discussion.dart';
import '../Models/reply.dart';

class DiscussionScreen extends StatefulWidget {
  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  Discussion discussion = Discussion(
      body: "",
      course: "",
      id: "",
      open: true,
      replies: [],
      timestamp: Timestamp.now(),
      title: "",
      userId: "");
  String name = '';
  List<Reply> replies = [];
  TextEditingController replyController = TextEditingController();
  Map<String, String> userIdsAndNames = {};
  final FirebaseAuth auth = FirebaseAuth.instance;
  final successSnackBar = const SnackBar(
    backgroundColor: Colors.green,
    content: Text('Discussion deleted successfully!'),
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
    final discussionId = routeArgs["discussionId"];
    getDiscussionAsync(discussionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name + "'s Discussion"),
          backgroundColor: Colors.red,
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      trailing: discussion.userId ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? IconButton(
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Confirmation Required'),
                                    content: const Text(
                                        'Are you sure you want to delete this discussion ?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          deleteDiscussion(discussion.id)
                                              .then((value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(successSnackBar);
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.delete_rounded,
                                size: 50,
                                color: Colors.red,
                              ),
                            )
                          : const SizedBox(
                              width: 1,
                              height: 1,
                            ),
                      leading: const Icon(
                        Icons.account_circle_rounded,
                        size: 50,
                      ),
                      title: Text(
                        name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(DateFormat('yyyy-MM-dd kk:mm a')
                          .format(discussion.timestamp.toDate())),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                      child: Text(
                        discussion.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                      child: Text(
                        discussion.body,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
                            child: TextField(
                              controller: replyController,
                              decoration:
                                  const InputDecoration(hintText: 'Reply'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: IconButton(
                            icon: const Icon(Icons.reply_rounded),
                            onPressed: () {
                              sendReply(discussion.id, replyController.text,
                                  FirebaseAuth.instance.currentUser!.uid);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 2,
                    margin: const EdgeInsets.all(2),
                    child: ListTile(
                      title: Text(userIdsAndNames[replies[index].userId]! +
                          ":" +
                          '\n' +
                          replies[index].body),
                      subtitle: Text(DateFormat('yyyy-MM-dd kk:mm a')
                          .format(replies[index].timeStamp.toDate())),
                      isThreeLine: true,
                    ),
                  );
                },
                itemCount: replies.length,
              ),
            ],
          ),
        ));
  }

  void getDiscussionAsync(discussionId) async {
    Discussion discussionAsync = await getDiscussion(discussionId);
    String nameAsync = await getUserName(discussionAsync.userId);
    List<Reply> repliesAsync = [];
    Map<String, String> usersIdMapAsync = {};
    print(discussionAsync.replies.length);
    if (discussionAsync.replies.length > 1) {
      repliesAsync = await getReplies(discussionAsync.replies);
      List<String> usersIds = [];
      for (Reply reply in repliesAsync) {
        usersIds.add(reply.userId);
      }
      print(usersIds);
      usersIdMapAsync = await getUserNames(usersIds);
    }

    setState(() {
      discussion = discussionAsync;
      name = nameAsync;
      replies = repliesAsync;
      userIdsAndNames = usersIdMapAsync;
    });
  }
}
