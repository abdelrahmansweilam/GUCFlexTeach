import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexteach/Models/course.dart';

final auth = FirebaseAuth.instance;

Future<void> signup(email, password) async {
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

Future<void> completeSignup(String name, String app_id, bool isInstructor,
    String major, var courses) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set({
      'name': name,
      'app_id': app_id,
      'isInstructor': isInstructor,
      'major': major,
      'courses': courses,
      'profile_photo': null,
    });
  } catch (e) {
    print(e.toString());
    rethrow;
  }
  try {
    for (String courseCode in courses) {
      Course? newCourse;
      String? courseId;
      if (isInstructor) {
        await FirebaseFirestore.instance
            .collection("courses")
            .where('code', isEqualTo: courseCode)
            .limit(1)
            .get()
            .then((snapshot) {
          for (var doc in snapshot.docs) {
            courseId = doc.id;
            newCourse = Course(
                code: doc['code'],
                name: doc['name'],
                instructors: doc['instructors'],
                deadlines: []);
          }
        });

        newCourse!.instructors.add(name);
        await FirebaseFirestore.instance
            .collection("courses")
            .doc(courseId)
            .update({'instructors': newCourse!.instructors}).then((doc) {
          print('Updated Successfully');
        });
      }
    }
  } catch (e) {
    print(e.toString());
    rethrow;
  }
}

Future<void> login(email, password) async {
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
