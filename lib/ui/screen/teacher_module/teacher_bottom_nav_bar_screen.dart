import 'package:flutter/material.dart';
import 'package:quize_app_teacher_student_module/authentication/user_auth.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/quiz_list_screen.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/student_list_screen.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/teacher_dashboard_screen.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../authentication/auth_controller.dart';
import '../../widget/gradian_color.dart';

class TeacherBottomNavBarScreen extends StatefulWidget {


  const TeacherBottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<TeacherBottomNavBarScreen> createState() => _TeacherBottomNavBarScreenState();
}

class _TeacherBottomNavBarScreenState extends State<TeacherBottomNavBarScreen> {

@override
  void initState() {
  UserAuth.getTeacherProfileData();
  super.initState();
  }

  final List<Widget> navScreenItem = [
    const TeacherDashboardScreen(),
    const QuizListScreen(),
    const StudentListScreen(),

  ];
  int _selectedIndex =0;




  Future<void> _logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    await AuthController.instance.logout();

  }


  @override
  Widget build(BuildContext context) {

    print(UserAuth.teacherEmail);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          flexibleSpace: gradiantColor(child: Container(
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 5),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 24,
                  child: ClipOval(
                    child: Image.network("https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png"),
                  ),
                ),
                const SizedBox(width: 10),
                 Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${UserAuth.teacherFirstName??""} ${UserAuth.teacherLastName ??""}",
                      style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w700,color: Colors.white),
                    ),
                    Text(UserAuth.teacherEmail??"",style: const TextStyle(color: Colors.white),),
                  ],
                )
              ],
            ),
          ),),
          actions: [
            IconButton(onPressed: _logOut, icon: const Icon(Icons.power_settings_new))
          ],
        ),
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
