import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quize_app_teacher_student_module/ui/utility/snac_bar.dart';

class PlayQuizScreenrRnd extends StatefulWidget {
  const PlayQuizScreenrRnd({super.key});

  @override
  _PlayQuizScreenrRndState createState() => _PlayQuizScreenrRndState();
}

class _PlayQuizScreenrRndState extends State<PlayQuizScreenrRnd> {
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
      print('Failed to fetch quizzes: $e');
    }
  }

  void selectOption(int optionIndex) {
    setState(() {
      selectedOptionIndex = optionIndex;
    });
  }

  void goToNextQuestion() {

    if ( selectedOptionIndex.toString() == quizzes[currentQuestionIndex]["correctAnswer"].toString()) {
      score++;
      print("score:$score");// Increase the score if the selected option is correct
      successSnackBar("Your answer is correct");
    }

    if(selectedOptionIndex==null){
      errorSnackBar("Please selected one option");
    }else{




        print("currentQuestionIndex: $currentQuestionIndex");
        print("selectedOptionIndex: $selectedOptionIndex");
        print("quizzes.length: ${quizzes.length}");
        print("quizzes[currentQuestionIndex][correctAnswer: ${quizzes[currentQuestionIndex]["correctAnswer"]}");



        setState(() {
          currentQuestionIndex++;
          selectedOptionIndex = null; // Reset selected option for the next question

        });



      // Handle end of quiz
      // You can show the final score or navigate to another screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Quiz'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Quiz Question',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            if (quizzes.isNotEmpty)
              Text(
                quizzes[currentQuestionIndex]['question'],
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 16.0),
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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: goToNextQuestion,
              child: Text('Next'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Score: $score', // Display the current score
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Text(
              'Remaining Quiz: ${quizzes.length - currentQuestionIndex - 1}', // Display the remaining quiz count
              style: TextStyle(fontSize: 16),
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

  OptionTile({super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isSelected ? Colors.blue : Colors.white,
      title: Text(option),
      onTap: onTap,
    );
  }
}
