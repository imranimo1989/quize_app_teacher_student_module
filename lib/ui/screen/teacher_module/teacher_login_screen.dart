import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/teacher_bottom_nav_bar_screen.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/teacher_registration_screen.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';
import '../../utility/snac_bar.dart';
import '../../widget/app_Text_Form_Field_Widget.dart';
import '../../widget/app_text_widget.dart';
import '../../widget/gradian_color.dart';
import '../../widget/gradiant_button.dart';


class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({Key? key}) : super(key: key);

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

final _formKeyTeacherLogin = GlobalKey<FormState>();


bool _isChecked = false;


class _TeacherLoginScreenState extends State<TeacherLoginScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  final _teacherEmailController = TextEditingController();
  final _teacherPasswordController = TextEditingController();

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  ///Checkbox
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return endColor;
    }
    return primaryColor;
  }

  void _isCheckedCheckbox() {
    if (_isChecked) {
      _teacherEmailController.text;
      _teacherPasswordController.text;
    } else {
      _teacherEmailController.clear();
      _teacherPasswordController.clear();
    }
  }

  void _handleLogin() {
    if (_formKeyTeacherLogin.currentState!.validate()) {
      // Perform signup logic here

      _isCheckedCheckbox();
      teacherLogin();
    }
  }

  Future<void> teacherLogin() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _teacherEmailController.text.trim(),
          password: _teacherPasswordController.text.trim());

      // Get the logged-in user's UID
      String uid = userCredential.user!.uid;


      log('Login successful');

      Get.offAll(() =>  TeacherBottomNavBarScreen(uid: uid,),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeftWithFade);

      successSnackBar("Login Successfully");
    } catch (e) {
      log('Error logging in: $e');

      errorSnackBar(
          "Something went wrong! please input correct user name password, or $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gradiantColor(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 500,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                    child: Form(
                      key: _formKeyTeacherLogin,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/icons/idea.png',
                            width: 50,
                            fit: BoxFit.scaleDown,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          textHeading(
                            'Teacher Login',
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          AppTextFormFieldWidget(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter valid email id";
                              }
                              return null;
                            },
                            hintText: 'Enter your registered email',
                            textInputType: TextInputType.emailAddress,
                            preFixIcon: const Icon(Icons.email),
                            controller: _teacherEmailController,
                            focusNode: _focusNodeEmail,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          AppTextFormFieldWidget(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your valid password';
                              }
                              return null;
                            },
                            hintText: 'Enter your Password',
                            obSecureText: true,
                            preFixIcon: const Icon(Icons.password),
                            controller: _teacherPasswordController,
                            focusNode: _focusNodePassword,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                MaterialStateProperty.resolveWith(
                                    getColor),
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(color: primaryColor),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          GradiantButton(
                              buttonText: 'Login',
                              onPressed: _handleLogin),
                          const SizedBox(
                            height: 18,
                          ),
                          GradiantButton(
                            buttonText: 'Register',
                            onPressed: () {
                              Get.to(
                                      () => const TeacherRegistrationScreen(),
                                  duration:
                                  const Duration(milliseconds: 500),
                                  transition:
                                  Transition.rightToLeftWithFade);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
