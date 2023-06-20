
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quize_app_teacher_student_module/ui/widget/app_text_widget.dart';
import '../../widget/gradiant_dashboard_card.dart';


class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({Key? key}) : super(key: key);

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int totalStudents = 0;



  Future<void> getStudent()async{
    try {
      final snapshot = await FirebaseFirestore.instance.collection('students').get();
      setState(() {
        final students =  snapshot.docs;
        totalStudents = students.length;
      });
    } catch (e) {
      log('Failed to fetch quizzes: $e');
    }

  }
@override
  void initState() {
getStudent();
super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:   StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('quiz').snapshots(),

        builder: (context, snapshot) {
          final questions = snapshot.data?.docs;
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
                    GradiantDashboardCard(title: "Total Questions", number: questions?.length??0 ,),
                    const SizedBox(width: 8,),
                    const GradiantDashboardCard(title: "Total Answers", number: 0,),

                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradiantDashboardCard(title: "Total Students", number: totalStudents,),
                    SizedBox(width: 8,),
                    GradiantDashboardCard(title: "Inactive Student",number: 0,),

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


