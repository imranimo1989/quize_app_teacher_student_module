
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/ui/screen/student_module/student_login_screen.dart';
import 'package:quize_app_teacher_student_module/ui/screen/teacher_module/teacher_login_screen.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';
import 'package:quize_app_teacher_student_module/ui/widget/gradian_color.dart';


class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({Key? key}) : super(key: key);

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: gradiantColor(
        child:  Center(
          child:Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("You Are?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
                const SizedBox(height: 24,),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 4, backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)
                      ),
                      ),
                      onPressed:(){

                        Get.to(() =>   const TeacherLoginScreen(),
                            duration: const Duration(milliseconds: 600),
                            transition: Transition.rightToLeftWithFade);

                  }, child: const Text("Teacher",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),)),
                ),
                const SizedBox(height: 12,),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 4, backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)
                        ),
                      ),
                      onPressed:(){

                        Get.to(() =>  const StudentLoginScreen(),
                            duration: const Duration(milliseconds: 500),
                            transition: Transition.rightToLeftWithFade);


                      }, child: const Text("Student",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),)),
                )



              ],
            ),
          ),
        ),
      ),
    );
  }
}
