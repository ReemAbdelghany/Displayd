import 'package:flutter/material.dart';
import 'package:my_project_name/ar_drawing_screen.dart';
import 'package:my_project_name/login_screen.dart'; // Import your login screen here

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AR Drawing APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Change the home to your login screen instead of ArDrawingScreen()
      home: const LoginScreen(),
    );
  }
}
