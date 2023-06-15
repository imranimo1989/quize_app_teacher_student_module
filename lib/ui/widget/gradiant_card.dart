import 'package:flutter/material.dart';

import '../utility/colors.dart';

class GradientCard extends StatelessWidget {
  final Widget child;

  final double borderRadius;
  final double elevation;

  const GradientCard({super.key,
    required this.child,

    this.borderRadius = 8.0,
    this.elevation = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        height: 120,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient:  const LinearGradient(
            colors: [primaryColor, secondaryColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: child,
      ),
    );
  }
}