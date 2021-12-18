import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var name = "name";
  var username = "user123";
  var id = "43-1111";
  Future<void> getUserInfo() async {}

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 100,
            // user's profile pic if present
            //foregroundImage: NetworkImage(userAvatarUrl),

            // generic avatar otherwise
            backgroundImage: NetworkImage(
                "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),

            // alternatively, the user's intials could be used if they don't have a profile pic
            //backgroundColor: Colors.grey.shade800,
            //child: const Text('AH'),
          )),
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
    ]));
  }
}
