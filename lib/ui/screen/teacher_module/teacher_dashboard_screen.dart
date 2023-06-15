import 'package:flutter/material.dart';
import 'package:quize_app_teacher_student_module/ui/widget/gradiant_card.dart';

import '../../widget/gradian_color.dart';

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({Key? key}) : super(key: key);

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Teacher Dashboard"),
        flexibleSpace: gradiantColor(),
      ),
      body:  const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradiantDashboardCard(title: "Total Questions", number: 50,),
                  SizedBox(width: 8,),
                  GradiantDashboardCard(title: "Total Answers", number: 30,),

                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradiantDashboardCard(title: "Total Students", number: 150,),
                  SizedBox(width: 8,),
                  GradiantDashboardCard(title: "Inactive Student",number: 30,),

                ],
              ),
            ],
          ),
        ),
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
