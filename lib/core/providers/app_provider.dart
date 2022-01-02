import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  AppProvider();

  ThemeType get theme => _theme;
  ThemeType _theme = ThemeType.light;

  set theme(ThemeType value) {
    _theme = value;
    notifyListeners();
  }

  int get currentPage => _currentPage;
  int _currentPage = 0;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }
}
