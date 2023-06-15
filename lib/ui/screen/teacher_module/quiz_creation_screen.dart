import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';

import '../../widget/gradian_color.dart';

class Question {
  String questionText;
  List<String> options;
  int correctOptionIndex;

  Question(
      {required this.questionText,
      required this.options,
      required this.correctOptionIndex});
}

class QuizCreationScreen extends StatefulWidget {
  @override
  _QuizCreationScreenState createState() => _QuizCreationScreenState();
}

class _QuizCreationScreenState extends State<QuizCreationScreen> {
  List<Question> questions = [];

  String questionText = "";
  List<String> options = ["", "", "", ""];
  int correctOptionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add New Quiz"),
        flexibleSpace: gradiantColor(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  questionText = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Question',
              ),
            ),
            const SizedBox(height: 16.0),
            for (int i = 0; i < options.length; i++)
              Row(
                children: [
                  Radio<int>(
                    value: i,
                    groupValue: correctOptionIndex,
                    onChanged: (int? value) {
                      setState(() {
                        correctOptionIndex = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          options[i] = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Option ${i + 1}',
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                ),
                onPressed: () {
                  if (questionText.isNotEmpty &&
                      options.every((option) => option.isNotEmpty)) {
                    setState(() {
                      questions.add(Question(
                        questionText: questionText,
                        options: options,
                        correctOptionIndex: correctOptionIndex,
                      ));
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
