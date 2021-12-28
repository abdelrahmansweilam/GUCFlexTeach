import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

Future signup(email, password) async {
  try {
    UserCredential authResult = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authResult.user!.uid)
        .set({
      'email': email,
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }
}

void completeSignup(String name, String app_id, bool isInstructor, String major,
    var courses) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set({
      'name': name,
      'app_id': app_id,
      'isInstructor': isInstructor,
      'major': major,
      'course': courses,
      'profile_photo': null,
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }
}

void login(email, password) async {
  try {
    UserCredential authResult = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (e) {
    print(e.toString());
    rethrow;
  }
}
