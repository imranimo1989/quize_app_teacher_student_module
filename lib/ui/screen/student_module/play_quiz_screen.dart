import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/ui/utility/snac_bar.dart';
import 'package:quize_app_teacher_student_module/ui/widget/gradiant_button.dart';

class PlayQuizScreen extends StatefulWidget {
  const PlayQuizScreen({super.key});

  @override
  _PlayQuizScreenState createState() => _PlayQuizScreenState();
}

class _PlayQuizScreenState extends State<PlayQuizScreen> {
  List<Map<String, dynamic>> quizzes = [];
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;

  int score = 0;

  @override
  void initState() {
    super.initState();
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('quiz').get();
      setState(() {
        quizzes = snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      log('Failed to fetch quizzes: $e');
    }
  }

  void selectOption(int optionIndex) {
    setState(() {
      selectedOptionIndex = optionIndex;
    });
  }

  void goToNextQuestion() {
    if (selectedOptionIndex == null) {
      errorSnackBar("Please select your answer");
    } else if (selectedOptionIndex.toString() !=
        quizzes[currentQuestionIndex]['correctAnswer'].toString()) {
      errorSnackBar("Your Answer is incorrect, please try again");
    } else {
      if (selectedOptionIndex != null) {
        if (selectedOptionIndex.toString() ==
            quizzes[currentQuestionIndex]['correctAnswer'].toString()) {
          successSnackBar("Good job! your ans is correct");
          setState(() {
            score++; // Increase the score if the selected option is correct
          });
        }
      }

      if (currentQuestionIndex < quizzes.length - 1) {
        setState(() {
          currentQuestionIndex++; // Move to the next question
          selectedOptionIndex =
              null; // Reset selected option for the next question
        });
      } else {

       Get.back();
        // Handle end of quiz
        // You can show the final score or navigate to another screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Quiz'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quiz Question',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Score: $score', // Display the current score
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            if (quizzes.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      quizzes[currentQuestionIndex]['question'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Quiz: ${currentQuestionIndex+1}/${quizzes.length - currentQuestionIndex - 1}',
                      // Display the remaining quiz count
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16.0),
            if (quizzes.isNotEmpty)
              Column(
                children: List.generate(4, (index) {
                  final option =
                      quizzes[currentQuestionIndex]['answers'][index];
                  final isSelected = index == selectedOptionIndex;

                  return OptionTile(
                    option: option,
                    isSelected: isSelected,
                    onTap: () => selectOption(index),
                  );
                }),
              ),
            const SizedBox(height: 16.0),
            GradiantButton(
              onPressed: goToNextQuestion,
              buttonText: currentQuestionIndex < quizzes.length - 1 ? 'Next' : 'Finish',
            ),

          ],
        ),
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: isSelected ? Colors.green[200] : Colors.white,
        title: Text(option),
        onTap: onTap,
      ),
    );
  }
}
