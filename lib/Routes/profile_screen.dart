import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var name = "name";
  var username = "user123";
  var id = "43-1111";
  var isLoading = true;

  Future<void> getUserInfo() async {
    //await get info from db
    isLoading = false;
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding:
                    EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
                alignment: Alignment.center,
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
                  Text("Username: " + username,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.left),
                  Text("ID: " + id,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.left)
                ])));
  }
}
