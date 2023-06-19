import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/ui/screen/student_module/student_login_screen.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/teacher_login_screen.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';
import 'package:quize_app_teacher_student_module/ui/utility/snac_bar.dart';
import '../../widget/app_Text_Form_Field_Widget.dart';
import '../../widget/gradian_color.dart';
import '../../widget/gradiant_button.dart';

class TeacherRegistrationScreen extends StatefulWidget {
  const TeacherRegistrationScreen({super.key});

  @override
  _TeacherRegistrationScreenState createState() => _TeacherRegistrationScreenState();
}

class _TeacherRegistrationScreenState extends State<TeacherRegistrationScreen> {

  final GlobalKey<FormState> _formKeyTeacherRegister = GlobalKey<FormState>();


  final _teacherEmailController = TextEditingController();
  final _teacherPassController = TextEditingController();
  final _teacherConPassController = TextEditingController();
  final _teacherFirstNameController = TextEditingController();
  final _teacherLastNameController = TextEditingController();
  final _teacherMobileNumberController = TextEditingController();



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

    if (_formKeyTeacherRegister.currentState!.validate()) {

      if(_teacherPassController.text == _teacherConPassController.text){
        registerUser();
      }
      else{
        errorSnackBar("Password does not Match");
      }




    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> registerUser() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _teacherEmailController.text.trim(),
        password: _teacherPassController.text.trim(),
      );

      // Get the newly registered user's UID
      String uid = userCredential.user!.uid;

      // Store the user's profile data in Firestore
      await _firestore.collection('teacher').doc(uid).set({
        'email': _teacherEmailController.text.trim(),
        'firstName': _teacherFirstNameController.text.trim(),
        'lastName': _teacherLastNameController.text.trim(),
        'mobileNumber': _teacherMobileNumberController.text.trim(),
      });


      log('Registration successful');


      successSnackBar("Registration Successfully");


      Get.offAll(() =>  const TeacherLoginScreen(),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeftWithFade);

    } catch (e) {
      log('Error registering user: $e');


      errorSnackBar("Something went wrong, registration not completed, $e");
    }
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Student Registration"),
        flexibleSpace: gradiantColor(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKeyTeacherRegister,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    controller: _teacherEmailController,
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
                    obSecureText: true,
                    preFixIcon: const Icon(Icons.password),
                    controller: _teacherPassController,
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
                    obSecureText: true,
                    controller: _teacherConPassController,
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
                    controller: _teacherFirstNameController,
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
                    controller: _teacherLastNameController,
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
                    controller: _teacherMobileNumberController,
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
    Get.to(() => const StudentLoginScreen(),
        duration: const Duration(milliseconds: 500),
        transition: Transition.rightToLeftWithFade);
  }

}


