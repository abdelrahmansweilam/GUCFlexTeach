import 'package:flutter/material.dart';

class UserInfoProvider with ChangeNotifier {
  String appID = '';
  List<String> courses = [];
  bool isInstructor = false;
  String major = '';
  String name = '';

  void setInfo(String id, List<String> c, bool inst, String m, String n) {
    appID = id;
    courses = c;
    isInstructor = inst;
    major = m;
    name = n;
    notifyListeners();
  }

  String get getID {
    return appID;
  }

  List<String> get getCourses {
    return courses;
  }

  bool get instructor {
    return isInstructor;
  }

  String get getMajor {
    return major;
  }

  String get getName {
    return name;
  }
}
