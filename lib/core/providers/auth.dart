import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  RegisterModel _reg = RegisterModel();
  RegisterModel get reg => _reg;

  set reg(RegisterModel value) {
    _reg = value;
    notifyListeners();
  }

  LoginModel _login = LoginModel();
  LoginModel get login => _login;

  set login(LoginModel value) {
    _login = value;
    notifyListeners();
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  bool _isSignup = false;
  bool get isSignup => _isSignup;

  set isSignup(bool value) {
    _isSignup = value;
    notifyListeners();
  }

  bool? _rememberMe;
  bool? get rememberMe => _rememberMe;

  set rememberMe(bool? value) {
    _rememberMe = value;
    notifyListeners();
  }
}
