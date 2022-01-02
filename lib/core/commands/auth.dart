import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class AuthCmd extends EvBaseCommand {
  AuthCmd(BuildContext c) : super(c);

  final AuthApi _api = AuthApi();
  AuthProvider get _ap => getProvider<AuthProvider>();

  Future login(FormGroup form) async {
    final BuildContext _ctx = rootNav!.context;
    _ap.isLogin = true;
    _ap.login = LoginModel.fromJson(form.rawValue);
    await _api.login(_ap.login.email!, _ap.login.password!).then((value) {
      _ap.isLogin = false;
      form.value.clear();
    }).catchError((e) {
      _ap.isLogin = false;
      if (e is FirebaseAuthException) {
        FlashHelper.snack(_ctx, message: e.message!, status: EvFS.error);
      }
    });
  }

  Future signup(FormGroup form) async {
    final BuildContext _ctx = rootNav!.context;
    _ap.isSignup = true;
    _ap.reg = RegisterModel.fromJson(form.rawValue);

    await _api.signup(_ap.reg).then((value) {
      _ap.isSignup = false;
      FlashHelper.snack(_ctx, message: 'Account successfully created');
      form.value.clear();
    }).catchError((e) {
      _ap.isSignup = false;
      auth.currentUser?.delete();
      if (e is FirebaseAuthException) {
        FlashHelper.snack(_ctx, message: e.message!, status: EvFS.error);
      } else {
        FlashHelper.snack(_ctx, message: "$e", status: EvFS.error);
      }
    });
  }
}
