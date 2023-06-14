
import 'package:flutter/material.dart';

import '../utility/colors.dart';

class GradiantButton extends StatelessWidget {

  final String buttonText;
  final VoidCallback onPressed;

  const GradiantButton({
    super.key, required this.buttonText, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:onPressed,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              gradient:  const LinearGradient(
                colors: [primaryColor, secondaryColor, endColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child:  Center(
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),);
  }
}