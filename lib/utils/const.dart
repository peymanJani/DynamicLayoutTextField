import 'package:flutter/material.dart';

class Const {


  static Color get backGroundColor {
    return Color(0xffFCFCFC);
  }

  static Color get baseAppColor {
    return Color(0xFF314A68); // Color(0xffebae1f);
  }


  static Color get hintTextColor {
    return Color(0xFF4D4737); //??????
  }

  static Color get videoBorderColor {
    return Colors.black87;
  }

  static Color get backgroundColor {
    return Color(0xffF3F4F6);
  }

  static Color get baseTextColor {
    return Colors.white70;
  }


  Const._();

  static double width = 0.0;
  static double height = 0.0;

  static void setWithAndHeight(context) {
    Const.width = MediaQuery.of(context).size.width;
    Const.height = MediaQuery.of(context).size.height;
  }
}
