import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/ui/screen/student_module/student_login_screen.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';
import 'package:quize_app_teacher_student_module/ui/widget/app_text_widget.dart';
import '../../widget/gradian_color.dart';
import '../../widget/gradiant_button.dart';
import 'play_quiz_screen.dart';

class StudentDashboardScreen extends StatefulWidget {
  final String uId;

  const StudentDashboardScreen({Key? key, required this.uId}) : super(key: key);

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  String? stdFirstName, stdLastName, stdEmail, stdMobileNumber;

  //create instance for firestore and auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  getStudentProfileData() async {
    // Retrieve the user's profile data from Firestore
    DocumentSnapshot snapshot =
        await _firestore.collection('students').doc(widget.uId).get();

    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      setState(() {
        stdFirstName = userData['firstName'];
        stdLastName = userData['lastName'];
        stdMobileNumber = userData['mobileNumber'];
        stdEmail = userData['email'];
      });

      log(stdFirstName!);
    } else {
      log('User profile data not found');
    }
  }

  @override
  void initState() {
    getStudentProfileData();
    super.initState();
  }

  Future<void> _logOut() async {
    //firebase logout
    await auth.signOut();
    Get.offAll(() => const StudentLoginScreen(),
        duration: const Duration(milliseconds: 500),
        transition: Transition.rightToLeftWithFade);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: gradiantColor(
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 5),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 24,
                  child: ClipOval(
                    child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png"),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$stdFirstName $stdLastName",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    Text(
                      "$stdEmail",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: _logOut, icon: const Icon(Icons.power_settings_new))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            textHeading("Student Dashboard"),
            const SizedBox(
              height: 60,
            ),


             const Text("Score: 0",style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600,fontSize: 16),),
            const SizedBox(
              height: 16,
            ),
            GradiantButton(
              buttonText: 'Play Quiz',
              onPressed: () {
                Get.to(
                  () => PlayQuizScreen(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
