
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_teacher_student_module/ui/screen/user_selection_screen.dart';
import 'package:quize_app_teacher_student_module/ui/widget/gradian_color.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3))
        .then((value) => Get.off(() => const UserSelectionScreen()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: gradiantColor(
        child: const Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Iqra Quiz", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),),
              SizedBox(height: 16,),
              Text("version: 1.0", style: TextStyle(color: Colors.white60 ),),
              SizedBox(height: 24,),
              Text("This Quiz Apps Design, Development & publish by\n Mohammed Imran\n OSTAD Bach 02 - 2023", style: TextStyle(color: Colors.white60, height: 1.5),textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }
}
