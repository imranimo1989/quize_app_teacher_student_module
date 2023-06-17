import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/authentication/auth_controller.dart';
import 'package:quize_app_teacher_student_module/model/create_user_model.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();

  //TextField controllers to get data from text  field
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final mobileNumber = TextEditingController();

// final createUserController = Get.put(CreateUserController());

  //call this function from design & it will do the rest
  void registration(String email, String password) {
    AuthController.instance.createUserWithEmailAndPassword(email, password);

    print(email.toString());
    print(password.toString());
  }

  Future<void> createUser(CreateUserModel user) async {
   // await createUserController.createUser(user);
  }
}