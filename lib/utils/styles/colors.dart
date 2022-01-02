import 'package:flutter/material.dart';

class AppColors {
  static const _baseBlue = 0xFF0d47a1;
  static const _baseOrange = 0xFFbf360c;
  static MaterialColor dark = const MaterialColor(
    0xFF444444,
    <int, Color>{
      50: Color(0xFFfafafa),
      100: Color(0xFFf5f5f5),
      200: Color(0xFFefefef),
      300: Color(0xFFe2e2e2),
      400: Color(0xFFbfbfbf),
      500: Color(0xFFa0a0a0),
      600: Color(0xFF777777),
      700: Color(0xFF636363),
      800: Color(0xFF444444),
      900: Color(0xFF232323),
    },
  );
  static MaterialColor white = const MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFfafafa),
      200: Color(0xFFf5f5f5),
      300: Color(0xFFf0f0f0),
      400: Color(0xFFdedede),
      500: Color(0xFFc2c2c2),
      600: Color(0xFF979797),
      700: Color(0xFF818181),
      800: Color(0xFF606060),
      900: Color(0xFF3c3c3c),
    },
  );
  static MaterialColor aquaBlue = const MaterialColor(
    _baseBlue,
    <int, Color>{
      50: Color(0xFFe3f2fd),
      100: Color(0xFFbbdefb),
      200: Color(0xFF90caf9),
      300: Color(0xFF64b5f6),
      400: Color(0xFF42a5f5),
      500: Color(0xFF2196f3),
      600: Color(0xFF1e88e5),
      700: Color(0xFF1976d2),
      800: Color(0xFF1565c0),
      900: Color(_baseBlue),
    },
  );
  static MaterialColor deepOrange = const MaterialColor(
    _baseOrange,
    <int, Color>{
      50: Color(0xFFfbe9e7),
      100: Color(0xFFffccbc),
      200: Color(0xFFffab91),
      300: Color(0xFFff8a65),
      400: Color(0xFFff7043),
      500: Color(0xFFff5722),
      600: Color(0xFFf4511e),
      700: Color(0xFFe64a19),
      800: Color(0xFFd84315),
      900: Color(_baseOrange),
    },
  );
}
