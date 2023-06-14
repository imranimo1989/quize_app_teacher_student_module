

import 'package:flutter/material.dart';

Widget textHeading (text){

  return Text(text, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600));
}

Widget textSubHeading (text){

  return Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18));
}

Widget textRegular (text){

  return Text(text, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14));
}

Widget textRegularGrey (text){

  return Text(text, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey));
}

