import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/homepage.dart';
import 'pages/taskpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskPage(),
    );
  }
}
