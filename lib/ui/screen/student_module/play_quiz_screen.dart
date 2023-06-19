import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      final snapshot = await FirebaseFirestore.instance.collection('quiz').get();
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
    if (currentQuestionIndex < quizzes.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOptionIndex = null; // Reset selected option for the next question
      });
    } else {
      // Handle end of quiz
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
            const Text(
              'Quiz Question',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            if (quizzes.isNotEmpty)
              Text(
                quizzes[currentQuestionIndex]['question'],
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 16.0),
            if (quizzes.isNotEmpty)
              Column(
                children: List.generate(4, (index) {
                  final option = quizzes[currentQuestionIndex]['answers'][index];
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
              buttonText: 'Next',
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

  const OptionTile({super.key,
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
