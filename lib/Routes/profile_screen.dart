import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flexteach/Providers/user_info_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    final appID = userInfoProvider.getID;
    final coursesList = userInfoProvider.getCourses;
    final major = userInfoProvider.getMajor;
    final name = userInfoProvider.getName;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Profile"),
        ),
        body: Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Column(children: [
              const CircleAvatar(
                radius: 100,
                // user's profile pic if present
                //foregroundImage: NetworkImage(userAvatarUrl),

                // generic avatar otherwise
                backgroundImage: NetworkImage(
                    "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),

                // alternatively, the user's intials could be used if they don't have a profile pic
                //backgroundColor: Colors.grey.shade800,
                //child: const Text('AH'),
              ),
              Text("Name: " + name,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.left),
              Text("ID: " + appID,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.left),
              Text("Major: " + major,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.left),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: const Text(
                  "Courses",
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
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 1,
                  thickness: 2,
                ),
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(
                      coursesList[index],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("/courseDiscussionsRoute",
                          arguments: {"course": coursesList[index]});
                    },
                    trailing: Platform.isIOS
                        ? Icon(Icons.arrow_forward_ios)
                        : Icon(Icons.arrow_forward),
                  );
                },
                itemCount: coursesList.length,
              ),
            ]))));
  }
}
