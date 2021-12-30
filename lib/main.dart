import 'package:flutter/material.dart';

import 'Routes/login_screen.dart';
import 'Routes/complete_signup_screen.dart';
import 'Routes/main_screen.dart';
import 'Routes/signup_screen.dart';
import 'Routes/course_discussion_screen.dart';
import 'Routes/course_screen.dart';
import 'Routes/profile_screen.dart';
import 'Routes/home_page.dart';

void main() {
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
    return MaterialApp(
      title: 'GUC FlexTeach',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ), // standard dark theme
      themeMode: ThemeMode.system, // device controls theme
      initialRoute: '/',
      routes: {
        '/': (ctx) => MainScreen(),
        '/homePage': (ctx) => HomePage(),
        '/loginRoute': (ctx) => LoginScreen(),
        '/register': (ctx) => SignupScreen(),
        '/completeSignup': (ctx) => CompleteSignupScreen(),
        '/profileRoute': (ctx) => ProfileScreen(),
        '/courseRoute': (ctx) => CourseScreen(),
        "/courseDiscussionsRoute": (ctx) => CourseDiscussionScreen(),
      },
    );
  }
}
