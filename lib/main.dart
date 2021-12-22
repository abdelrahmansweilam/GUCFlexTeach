import 'package:flexteach/Routes/profile_screen.dart';
import 'package:flutter/material.dart';

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
        accentColor: Colors.red,
      ), // standard dark theme
      themeMode: ThemeMode.system, // device controls theme
      initialRoute: '/',
      routes: {
        '/': (ctx) => const HomePage(),
        '/profileRoute': (ctx) => const ProfileScreen(),
      },
    );
  }
}
