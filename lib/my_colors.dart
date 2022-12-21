import 'package:flutter/material.dart';

class MyColors {
  static const main = 0xFFA34016;
  static const accent = 0xFF373A3C;
  static const secondary = 0xFFCAA95D;
  static const MaterialColor mainMaterial = MaterialColor(main, <int, Color>{
    50: Color(0xFFD19F8A),
    100: Color(0xFFC78C73),
    200: Color(0xFFBE795B),
    300: Color(0xFFB56644),
    400: Color(0xFFAC532D),
    500: Color(0xFFA34016),
    600: Color(0xFF923913),
    700: Color(0xFF823311),
    800: Color(0xFF722C0F),
    900: Color(0xFF61260D),
  });

  static const MaterialColor accentMaterial =
      MaterialColor(accent, <int, Color>{
    50: Color(0xFF9B9C9D),
    100: Color(0xFF87888A),
    200: Color(0xFF737576),
    300: Color(0xFF5E6162),
    400: Color(0xFF4B4D4F),
    500: Color(0xFF373A3C),
    600: Color(0xFF313436),
    700: Color(0xFF2C2E30),
    800: Color(0xFF26282A),
    900: Color(0xFF212224),
  });
}
