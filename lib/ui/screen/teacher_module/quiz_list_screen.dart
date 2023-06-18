import 'package:cloud_firestore/cloud_firestore.dart';
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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: (){
          Get.to(()=> const NewQuizQuestionScreen(),
              duration: const Duration(milliseconds: 0),
              transition: Transition.cupertino);

          },
        label: const Text('New Quiz'),
        icon: const Icon(Icons.add),
        backgroundColor: secondaryColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('quiz').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final questions = snapshot.data!.docs;

            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final questionData = questions[index].data() as Map<String, dynamic>;
                final question = questionData['question'] as String;
                final answers = questionData['answers'] as List<dynamic>;
                final correctAnswer = answers[0] as String; // Set value at index 0

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: primaryColor,foregroundColor: Colors.white,child: Text("${index+1}"),),
                    title: Text(question),
                    subtitle: Text('Answer: $correctAnswer'),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error retrieving quiz questions'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}





