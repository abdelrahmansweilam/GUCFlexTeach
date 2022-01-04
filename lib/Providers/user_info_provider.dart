import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexteach/Backend/course_description.dart';
import 'package:flexteach/Models/course.dart';
import 'package:flutter/material.dart';

class UserInfoProvider with ChangeNotifier {
  String appID = '';
  List<dynamic> courses = [];
  bool isInstructor = false;
  String major = '';
  String name = '';
  List<Course> courseDesciptionList = [];

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
      courseDesciptionList = await getCoursesDescription(courses);
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

  List<Course> get getCourseDescriptionList {
    return courseDesciptionList;
  }
}
