import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/ui/screen/student_module/student_login_screen.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';
import 'package:quize_app_teacher_student_module/ui/utility/snac_bar.dart';
import '../../widget/app_Text_Form_Field_Widget.dart';
import '../../widget/gradian_color.dart';
import '../../widget/gradiant_button.dart';

class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  _StudentRegistrationScreenState createState() => _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {

  final GlobalKey<FormState> _formKeyStdRegister = GlobalKey<FormState>();


  final _stdEmailController = TextEditingController();
  final _stdPassController = TextEditingController();
  final _stdConPassController = TextEditingController();
  final _stdFirstNameController = TextEditingController();
  final _stdLastNameController = TextEditingController();
  final _stdMobileNumberController = TextEditingController();



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

    if (_formKeyStdRegister.currentState!.validate()) {

      if(_stdPassController.text == _stdConPassController.text){
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
        email: _stdEmailController.text.trim(),
        password: _stdPassController.text.trim(),
      );

      // Get the newly registered user's UID
      String uid = userCredential.user!.uid;

      // Store the user's profile data in Firestore
      await _firestore.collection('students').doc(uid).set({
        'email': _stdEmailController.text.trim(),
        'firstName': _stdFirstNameController.text.trim(),
        'lastName': _stdLastNameController.text.trim(),
        'mobileNumber': _stdMobileNumberController.text.trim(),
      });


      log('Registration successful');


      successSnackBar("Registration Successfully");


      Get.offAll(() =>  const StudentLoginScreen(),
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
              key: _formKeyStdRegister,
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
                    controller: _stdEmailController,
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
                    controller: _stdPassController,
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
                    controller: _stdConPassController,
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
                    controller: _stdFirstNameController,
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
                    controller: _stdLastNameController,
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
                    controller: _stdMobileNumberController,
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


