import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/ui/screen/splash_screen.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.transparent,
        colorScheme: ThemeData().colorScheme.copyWith(
          secondary: secondaryColor,
          primary: primaryColor,
        ),
        // Set primary color to transparent
      ),
      home: const SplashScreen(),
    );
  }
}


