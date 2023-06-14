
import 'package:flutter/material.dart';
import 'package:quize_app_teacher_student_module/ui/screen/login_screen.dart';
import 'package:quize_app_teacher_student_module/ui/widget/gradian_color.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    Future.delayed(const Duration(seconds: 2)).then((value) async {

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  LoginScreen()));

    });

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
              SizedBox(height: 20,),
              Text("version: 1.0", style: TextStyle(color: Colors.white60 ),)
            ],
          ),
        ),
      ),
    );
  }
}
