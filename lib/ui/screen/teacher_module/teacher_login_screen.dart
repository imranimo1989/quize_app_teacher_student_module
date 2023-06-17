import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/authentication/login_controller.dart';
import 'package:quize_app_teacher_student_module/ui/screen/sign_up_screen.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';

import '../../widget/app_Text_Form_Field_Widget.dart';
import '../../widget/app_text_widget.dart';
import '../../widget/gradian_color.dart';
import '../../widget/gradiant_button.dart';

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({Key? key}) : super(key: key);

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

final _formKeyLogin = GlobalKey<FormState>();

final controller = Get.put(LoginController());

bool isChecked = false;
bool isLoginLoading = false;

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

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

  void isCheckedCheckbox() {
    if (isChecked) {
      controller.email.text;
      controller.password.text;
    } else {
      controller.email.clear();
      controller.password.clear();
    }
  }

  void _handleLogin() {
    if (_formKeyLogin.currentState!.validate()) {
      // Perform signup logic here

      LoginController.instance.loginWithFirebase(
          controller.email.text.trim(), controller.password.text.trim());

      isCheckedCheckbox();
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
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: Form(
                    key: _formKeyLogin,
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                              controller: controller.email,
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
                              controller: controller.password,
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
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
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
                                buttonText: 'Login', onPressed: _handleLogin),
                            const SizedBox(
                              height: 18,
                            ),
                            GradiantButton(
                              buttonText: 'Register',
                              onPressed: () {
                                Get.to(() => const SignupScreen(),
                                    duration: const Duration(milliseconds: 500),
                                    transition: Transition.rightToLeftWithFade);
                              },
                            ),
                          ],
                        ),
                      ],
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
