import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flexteach/Services/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/user_info_provider.dart';
import 'Routes/login_screen.dart';
import 'Routes/complete_signup_screen.dart';
import 'Routes/main_screen.dart';
import 'Routes/profile_discussions.dart';
import 'Routes/signup_screen.dart';
import 'Routes/course_discussion_screen.dart';
import 'Routes/course_screen.dart';
import 'Routes/profile_screen.dart';
import 'Routes/home_page.dart';
import 'Routes/discussion_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.notification!.body}");
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => UserInfoProvider(),
      child: MaterialApp(
        title: 'GUC FlexTeach',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.red,
          accentColor: Colors.red,
        ), // standard dark theme
        themeMode: ThemeMode.system, // device controls theme
        initialRoute: '/',
        routes: {
          '/': (ctx) => const MainScreen(),
          '/homePage': (ctx) => const HomePage(),
          '/loginRoute': (ctx) => LoginScreen(),
          '/register': (ctx) => SignupScreen(),
          '/completeSignup': (ctx) => const CompleteSignupScreen(),
          '/profileRoute': (ctx) => const ProfileScreen(),
          '/courseRoute': (ctx) => CourseScreen(),
          "/courseDiscussionsRoute": (ctx) => CourseDiscussionScreen(),
          '/discussionRoute': (ctx) => DiscussionScreen(),
          '/mydiscussions': (ctx) => ProfileDiscussionsScreen()
        },
      ),
    );
  }
}
