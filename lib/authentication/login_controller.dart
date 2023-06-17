import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/screen/teacher_module/teacher_bottom_nav_bar_screen.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  bool isLoginLoading = false;

  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> loginWithFirebase(String email, String password) async {
    isLoginLoading = true;
    update();
    await AuthController.instance.loginWithEmailAndPassword(email, password);
    isLoginLoading = false;
    update();

    Get.snackbar(
      "Success",
      "Login Successfully",
      icon: const CircleAvatar (backgroundColor: Colors.green, child: Icon(Icons.check, color: Colors.white)),
      snackPosition: SnackPosition.TOP,
    );

    Get.to(() => const TeacherBottomNavBarScreen(),
        duration: const Duration(milliseconds: 500),
        transition: Transition.rightToLeftWithFade);

    email = "";
    password = "";

  }
}
