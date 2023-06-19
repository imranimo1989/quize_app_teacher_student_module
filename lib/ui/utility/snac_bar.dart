import 'package:flutter/material.dart';
import 'package:get/get.dart';

void errorSnackBar(errorMessage) {
  Get.snackbar("Error", errorMessage,
      icon: const CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.error_outline, color: Colors.white)),
      snackPosition: SnackPosition.TOP,
      barBlur: 15);
}

void successSnackBar(successMessage) {
  Get.snackbar(
    "Success",
    successMessage,
    icon: const CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(Icons.check, color: Colors.white)),
    snackPosition: SnackPosition.TOP,
  );
}
