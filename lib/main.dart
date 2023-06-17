import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/authentication/auth_controller.dart';
import 'package:quize_app_teacher_student_module/authentication/login_controller.dart';
import 'package:quize_app_teacher_student_module/authentication/sign_up_controller.dart';
import 'package:quize_app_teacher_student_module/ui/screen/splash_screen.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';

import 'firebase_options.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.transparent,
        colorScheme: ThemeData().colorScheme.copyWith(
          secondary: secondaryColor,
          primary: primaryColor,
        ),
        // Set primary color to transparent
      ),
      home: const SplashScreen(),
      initialBinding: StoreBindings(),
    );
  }
}


class StoreBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
    Get.put(LoginController());
  // Get.put(CreateUserController());


  }
}