import 'package:flutter/material.dart';
import 'package:quize_app_teacher_student_module/ui/widget/gradiant_card.dart';

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