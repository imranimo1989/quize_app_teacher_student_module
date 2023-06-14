


import 'package:flutter/material.dart';
import 'package:quize_app_teacher_student_module/ui/utility/colors.dart';

 Widget gradiantColor({child}){

  return Container(
    child: child,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          primaryColor, secondaryColor, endColor

        ],
      ),
    ),
  );
}