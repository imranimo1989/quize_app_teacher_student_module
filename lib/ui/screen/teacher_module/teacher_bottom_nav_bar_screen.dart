import 'package:flutter/material.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/quiz_list_screen.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/student_list_screen.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/teacher_dashboard_screen.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';

class TeacherBottomNavBarScreen extends StatefulWidget {
  const TeacherBottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<TeacherBottomNavBarScreen> createState() => _TeacherBottomNavBarScreenState();
}

class _TeacherBottomNavBarScreenState extends State<TeacherBottomNavBarScreen> {
  final List<Widget> navScreenItem = [
    const TeacherDashboardScreen(),
    const QuizListScreen(),
    const StudentListScreen(),

  ];
  int _selectedIndex =0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          selectedItemColor: secondaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          elevation: 16,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb), label: "Quiz"),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle_rounded), label: "Student"),

          ],
        ),
        body: navScreenItem.elementAt(_selectedIndex));
  }
}
