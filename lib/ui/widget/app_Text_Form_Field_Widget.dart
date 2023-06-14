import 'package:flutter/material.dart';

import '../utility/colors.dart';

class AppTextEditingStyle extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obSecureText;
  final int? multiLine;
  final TextInputType? textInputType;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final String? labelText;
  final Icon? preFixIcon;



  final Function(String)? onChanged;

  final String? Function(String?)? validator;

  const AppTextEditingStyle({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    this.obSecureText,
    this.multiLine,
    this.validator,
    this.onChanged,
    this.textInputType,
    this.maxLength,
    this.textInputAction,
    this.labelText,
    this.preFixIcon,
  }) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,
      maxLines: multiLine ?? 1,
      obscureText: obSecureText ?? false,
      validator: validator,
      onChanged: onChanged,
      maxLength: maxLength,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 0,),
        prefixIcon: preFixIcon,
        prefixIconColor: primaryColor,

        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 1.0,
          ),
        ),
      ),
    );


  }
}


