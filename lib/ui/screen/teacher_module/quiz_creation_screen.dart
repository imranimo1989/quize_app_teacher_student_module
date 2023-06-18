import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewQuizQuestionScreen extends StatefulWidget {
  const NewQuizQuestionScreen({super.key});

  @override
  _NewQuizQuestionScreenState createState() => _NewQuizQuestionScreenState();
}

class _NewQuizQuestionScreenState extends State<NewQuizQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _answerControllers = List.generate(4, (index) => TextEditingController());
  String _correctAnswer = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _submitQuizQuestion() async {
    if (_formKey.currentState!.validate()) {
      try {
        final question = _questionController.text;
        final answers = _answerControllers.map((controller) => controller.text).toList();

        await _firestore.collection('quiz').add({
          'question': question,
          'answers': answers,
          'correctAnswer': _correctAnswer,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Quiz question submitted successfully')),
        );

        _formKey.currentState!.reset();
        _questionController.clear();
        _answerControllers.forEach((controller) => controller.clear());
        setState(() {
          _correctAnswer = '';
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting quiz question')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Quiz Question'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quiz Question:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _questionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Answers:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              for (int i = 0; i < 4; i++)
                Row(
                  children: [
                    Radio<String>(
                      value: 'answer$i',
                      groupValue: _correctAnswer,
                      onChanged: (value) {
                        setState(() {
                          _correctAnswer = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _answerControllers[i],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an answer';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitQuizQuestion,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
