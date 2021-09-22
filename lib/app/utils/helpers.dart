import 'dart:math';

import 'package:flutter/material.dart';

class Helpers {
  Helpers._();

  static double getTitleSize(MediaQueryData mediaQueryData) {
    if (mediaQueryData.size.width < 500) {
      return 17.0;
    } else if (mediaQueryData.size.width < 600) {
      return 18.0;
    } else {
      return 20.0;
    }
  }

  static double imageSize(MediaQueryData mediaQueryData){
    if (mediaQueryData.size.width < 500) {
      return 300;
    } else if (mediaQueryData.size.width < 600) {
      return 350;
    } else {
      return 380;
    }
  }
}

class UniqueColorGenerator {
  static Random random = Random();
  static Color getColor() {
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}
