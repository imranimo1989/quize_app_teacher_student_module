import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/quiz_creation_screen.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';
import 'package:quize_app_teacher_student_module/ui/widget/gradian_color.dart';

class QuizListScreen extends StatefulWidget {
  const QuizListScreen({Key? key}) : super(key: key);

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  List<Question> questions = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Teacher Dashboard"),
        flexibleSpace: gradiantColor(),
      ),
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: (){
          Get.to(()=>QuizCreationScreen(),
              duration: const Duration(milliseconds: 0),
              transition: Transition.cupertino);

          },
        label: const Text('New Quiz'),
        icon: const Icon(Icons.add),
        backgroundColor: secondaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16,),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
               // Question question = questions[index];
                return  Card(
                  margin: const EdgeInsets.only(left: 12,right: 12, bottom: 8),
                  elevation: 2,
                  child: ListTile( leading: CircleAvatar(
                    backgroundColor: primaryColor,
                    child: Text("${index+1}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                    title: const Text(" What is name of capital city in bangladesh"),
                    subtitle: const Text('Correct Option:  Dhaka'),
                    horizontalTitleGap: 12,

                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}





