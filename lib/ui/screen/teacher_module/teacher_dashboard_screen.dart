
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quize_app_teacher_student_module/ui/widget/app_text_widget.dart';
import 'package:quize_app_teacher_student_module/ui/widget/gradiant_card.dart';

import '../../../authentication/user_auth.dart';


class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({Key? key}) : super(key: key);

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    UserAuth.getTeacherProfileData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:   StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('quiz').snapshots(),

        builder: (context, snapshot) {
          final questions = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                textHeading("Teacher Dashboard"),
                const SizedBox(height: 60,),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradiantDashboardCard(title: "Total Questions", number: questions.length,),
                    const SizedBox(width: 8,),
                    const GradiantDashboardCard(title: "Total Answers", number: 30,),

                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradiantDashboardCard(title: "Total Students", number: 150,),
                    SizedBox(width: 8,),
                    GradiantDashboardCard(title: "Inactive Student",number: 30,),

                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class GradiantDashboardCard extends StatelessWidget {
  final String title;
  final int number;
  const GradiantDashboardCard({
    super.key, required this.title, required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return  GradientCard(child:
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$number",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
          const SizedBox(height: 8,),
          FittedBox(child: Text(title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),)),
        ],
      ),
    ),);
  }
}
