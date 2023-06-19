import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('students').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final questions = snapshot.data!.docs;

            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final questionData = questions[index].data() as Map<String, dynamic>;
                final lastName = questionData['lastName'] as String;
                final firstName = questionData['firstName'] as String;
                final email = questionData['email'] as String;
                final mobileNumber = questionData['mobileNumber'] as String;

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: primaryColor,foregroundColor: Colors.white,child: Text("${index+1}"),),
                    title: Text("$firstName $lastName"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: $email'),
                        const SizedBox(height: 4,),
                        Text('Mobile: $mobileNumber'),
                      ],
                    ),
                    trailing: const Text("Score: 0"),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error retrieving students data'),
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





