import 'package:flutter/material.dart';
import '../helpers/helpers.dart';

enum ThemeType {
  light,
  dark,
}

class AppTheme {
  static ThemeType defaultTheme = ThemeType.light;

  late bool isDark;
  late Color background;
  late Color surface;
  late Color bg2;
  late Color primary;
  late Color primaryVariant;
  late Color secondary;
  late Color secondaryVariant;
  late Color accent;
  late Color grey;
  late Color greyStrong;
  late Color accentVariant;
  late Color error;
  late Color focus;

  late Color txt;
  late Color accentTxt;

  AppTheme(this.isDark) {
    txt = isDark ? Colors.white : const Color(0xff171766);
    accentTxt = const Color(0xff5669FF);
  }

  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.light:
        return AppTheme(false)
          ..background = const Color(0xFFF8F8FF)
          ..bg2 = const Color(0xffFFFBFA)
          ..surface = Colors.white
          ..primary = const Color(0xff5669FF)
          ..primaryVariant = const Color(0xff4A43EC)
          ..secondary = const Color(0xff29D697)
          ..secondaryVariant = const Color(0xffFF8D5D)
          ..accent = const Color(0xff00F8FF)
          ..accentVariant = const Color(0xff39D1F2)
          ..grey = const Color(0xffDADADA)
          ..greyStrong = const Color(0xff515d5a)
          ..error = const Color(0xffEE544A)
          ..focus = const Color(0xFF7D67EE);

      case ThemeType.dark:
        return AppTheme(true);
      default:
        return AppTheme.fromType(defaultTheme);
    }
  }

  ThemeData get themeData {
    ThemeData t = ThemeData.from(
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primary,
        primaryContainer: primaryVariant,
        secondary: secondary,
        secondaryContainer: ColorHelper.shiftHsl(secondaryVariant, -.2),
        background: background,
        surface: surface,
        onBackground: surface,
        onSurface: bg2,
        onError: error,
        onPrimary: accentTxt,
        onSecondary: accentTxt,
        error: error,
      ),
    );
    return t.copyWith(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: accentVariant,
        selectionHandleColor: Colors.transparent,
        cursorColor: primary,
      ),
      highlightColor: primary, checkboxTheme: CheckboxThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return primary; }
 return null;
 }),
 ), radioTheme: RadioThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return primary; }
 return null;
 }),
 ), switchTheme: SwitchThemeData(
 thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return primary; }
 return null;
 }),
 trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return primary; }
 return null;
 }),
 ),
    );
  }
}
