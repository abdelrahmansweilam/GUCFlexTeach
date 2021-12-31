import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserInfoProvider with ChangeNotifier {
  String appID = '';
  List<dynamic> courses = [];
  bool isInstructor = false;
  String major = '';
  String name = '';

  Future<void> fetchUserInfoFromServer(var currentUserId) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(currentUserId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      appID = data?['app_id'];
      courses = data?['courses'];
      isInstructor = data?['isInstructor'];
      major = data?['major'];
      name = data?['name'];
    }
    notifyListeners();
  }

  String get getID {
    return appID;
  }

  List<dynamic> get getCourses {
    return courses;
  }

  bool get getIsInstructor {
    return isInstructor;
  }

  String get getMajor {
    return major;
  }

  String get getName {
    return name;
  }
}
