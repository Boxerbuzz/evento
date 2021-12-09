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
  late Color greyWeak;
  late Color error;
  late Color focus;

  late Color txt;
  late Color accentTxt;

  AppTheme(this.isDark) {
    txt = isDark ? Colors.white : const Color(0xff323B56);
    accentTxt = isDark ? Colors.white : const Color(0xff050715);
  }

  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.light:
        return AppTheme(false)
          //Color(0xFFF8F8FF) Color(0xFFF4F4F4)
          ..background = const Color(0xFFF8F8FF)
          ..bg2 = const Color(0xffFFFBFA)
          ..surface =  Colors.white
          ..primary = const Color(0xff1EB980)
          ..primaryVariant = const Color(0xff045D56)
          ..secondary = const Color(0xffFF6859)
          ..secondaryVariant = const Color(0xffFFCF44)
          ..accent = const Color(0xffB15DFF)
          ..greyWeak = const Color(0xff909f9c)
          ..grey = const Color(0xff515d5a)
          ..greyStrong = const Color(0xff151918)
          ..error = Colors.redAccent
          ..focus = const Color(0xFF0ee2b1);

      case ThemeType.dark:
        return AppTheme(true)
          ..background = const Color(0xff121212)
          ..bg2 = const Color(0xff2c2c2c)
          ..surface = const Color(0xff252525)
          ..primary = const Color(0xff00a086)
          ..primaryVariant = const Color(0xff00caa5)
          ..secondary = const Color(0xff00caa5)
          ..secondaryVariant = const Color(0xfff19e46)
          ..accent = const Color(0xff5BC91A)
          ..greyWeak = const Color(0xffa8b3b0)
          ..grey = const Color(0xffced4d3)
          ..greyStrong = const Color(0xffffffff)
          ..error = const Color(0xffe55642)
          ..focus = const Color(0xff0ee2b1);
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
        primaryVariant: primaryVariant,
        secondary: secondary,
        secondaryVariant: ColorHelper.shiftHsl(secondaryVariant, -.2),
        background: background,
        surface: surface,
        onBackground: txt,
        onSurface: txt,
        onError: txt,
        onPrimary: accentTxt,
        onSecondary: accentTxt,
        error: error,
      ),
    );
    return t.copyWith(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: greyWeak,
        selectionHandleColor: Colors.transparent,
        cursorColor: primary,
      ),
      highlightColor: primary,
      toggleableActiveColor: primary,
    );
  }

  Color shift(Color c, double d) =>
      ColorHelper.shiftHsl(c, d * (isDark ? -1 : 1));
}
