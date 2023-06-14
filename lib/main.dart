import 'package:flutter/material.dart';
import 'package:quize_app_teacher_student_module/ui/screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.transparent, // Set primary color to transparent
      ),
      home: const SplashScreen(),
    );
  }
}


