import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/authentication/sign_up_controller.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/teacher_login_screen.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';

import '../../widget/app_Text_Form_Field_Widget.dart';
import '../../widget/gradian_color.dart';
import '../../widget/gradiant_button.dart';

class TeacherRegistrationScreen extends StatefulWidget {
  const TeacherRegistrationScreen({super.key});

  @override
  _TeacherRegistrationScreenState createState() => _TeacherRegistrationScreenState();
}

class _TeacherRegistrationScreenState extends State<TeacherRegistrationScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final controller = Get.put(SignUpController());


  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final FocusNode _focusNodeFirstName = FocusNode();
  final FocusNode _focusNodeLastName = FocusNode();
  final FocusNode _focusNodeMobile = FocusNode();

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _focusNodeFirstName.dispose();
    _focusNodeLastName.dispose();
    _focusNodeMobile.dispose();
    super.dispose();
  }


  Future<void> handleSignup() async {
    if (_formKey.currentState!.validate()) {


      registerUser();

    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> registerUser() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: controller.email.text.trim(),
        password: controller.password.text.trim(),
      );

      // Get the newly registered user's UID
      String uid = userCredential.user!.uid;

      // Store the user's profile data in Firestore
      await _firestore.collection('users').doc(uid).set({
        'email': controller.email.text.trim(),
        'firstName': controller.firstName.text.trim(),
        'lastName': controller.lastName.text.trim(),
        'mobileNumber': controller.mobileNumber.text.trim(),
      });


      print('Registration successful');
    } catch (e) {
      print('Error registering user: $e');
    }
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Teacher Registration"),
        flexibleSpace: gradiantColor(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  AppTextFormFieldWidget(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter valid email id";
                      }
                      return null;
                    },
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    preFixIcon: const Icon(Icons.mail),
                    controller: controller.email,
                    focusNode: _focusNodeEmail,),
                  const SizedBox(height: 8.0),

                  AppTextFormFieldWidget(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                    hintText: 'Password',
                    textInputType: TextInputType.visiblePassword,
                    preFixIcon: const Icon(Icons.password),
                    controller: controller.password,
                    focusNode: _focusNodePassword,),
                  const SizedBox(height: 8.0),

                  AppTextFormFieldWidget(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Confirm password";
                      }
                      return null;
                    },
                    hintText: 'Confirm Password',
                    textInputType: TextInputType.visiblePassword,
                    preFixIcon: const Icon(Icons.password),
                    controller: controller.confirmPassword,
                    focusNode: _focusNodeConfirmPassword,),
                  const SizedBox(height: 8.0),


                  AppTextFormFieldWidget(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter First Name";
                      }
                      return null;
                    },
                    hintText: 'First Name',
                    textInputType: TextInputType.name,
                    preFixIcon: const Icon(Icons.person),
                    controller: controller.firstName,
                    focusNode: _focusNodeFirstName,),
                  const SizedBox(height: 8.0),

                  AppTextFormFieldWidget(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your last name";
                      }
                      return null;
                    },
                    hintText: 'Last Name',
                    textInputType: TextInputType.name,
                    preFixIcon: const Icon(Icons.person),
                    controller: controller.lastName,
                    focusNode: _focusNodeLastName,),
                  const SizedBox(height: 8.0),

                  AppTextFormFieldWidget(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter phone number";
                      }
                      return null;
                    },
                    hintText: 'Mobile Number',
                    textInputType: TextInputType.phone,
                    preFixIcon: const Icon(Icons.phone_android),
                    controller: controller.mobileNumber,
                    focusNode: _focusNodeMobile,),
                  const SizedBox(height: 16.0),

                  GradiantButton(
                    buttonText: 'Register',
                    onPressed: (){handleSignup();}
                  ),
                  const SizedBox(height: 16.0),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Text('Have an account? ',style: TextStyle(color: primaryColor)),
                    TextButton(onPressed: _signInScreen, child: const Text("Login",style: TextStyle(fontWeight: FontWeight.bold),))
                  ],)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signInScreen() {
    Get.to(() => const TeacherLoginScreen(),
        duration: const Duration(milliseconds: 500),
        transition: Transition.rightToLeftWithFade);
  }

}


