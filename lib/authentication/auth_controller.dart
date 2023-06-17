import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/authentication/signup_exceptions.dart';
import 'package:quize_app_teacher_student_module/ui/screen/splash_screen.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/teacher_bottom_nav_bar_screen.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/teacher_login_screen.dart';

import '../ui/screen/user_selection_screen.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  //variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const UserSelectionScreen())
        : Get.offAll(() => const TeacherBottomNavBarScreen());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const TeacherBottomNavBarScreen())
          : Get.offAll(() => const SplashScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar(
        "Error",
        ex.message,
        icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.TOP,
      );
      log("FIREBASE AUTH EXCEPTIONS - ${ex.message}");

      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      Get.snackbar(
        "Error",
        ex.message,
        icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.TOP,
      );
      log("EXCEPTIONS - ${ex.message}");

      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);

      Get.snackbar(
        "Error",
        ex.message,
        icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.TOP,
      );
      log("FIREBASE AUTH EXCEPTIONS - ${ex.message}");


      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      Get.snackbar(
        "Error",
        ex.message,
        icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.TOP,
      );
      log("EXCEPTIONS - ${ex.message}");

      throw ex;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
     // Get.offAll(const TeacherLoginScreen()); // Replace LoginScreen with the desired screen to navigate after logout
    } catch (e) {
      // Handle logout error
      Get.snackbar('Error', e.toString());
    }
  }
}
