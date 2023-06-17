/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/model/create_user_model.dart';

class CreateUserController extends GetxController {
  static CreateUserController get instance => Get.find();

  final _fireStoreDb = FirebaseFirestore.instance;

  createUser(CreateUserModel userModel) async {
    await _fireStoreDb
        .collection("users")
        .add(userModel.toJson())
        .whenComplete(
          () => Get.snackbar(
            "Success",
            "Your Account has been created",
            icon: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.check, color: Colors.white)),
            snackPosition: SnackPosition.TOP,
          ),
        )
        .catchError((error, stackTrace) {
      Get.snackbar(
        "Error",
        "Something went wrong, try again!",
        icon: const CircleAvatar (backgroundColor: Colors.red, child: Icon(Icons.error_outline, color: Colors.white)),
        snackPosition: SnackPosition.TOP,
      );
    });
  }
}
*/
