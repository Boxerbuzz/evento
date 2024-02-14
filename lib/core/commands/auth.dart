import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class AuthCmd extends EvBaseCommand {
  AuthCmd(BuildContext c) : super(c);

  final AuthApi _api = AuthApi();
  AppAuthProvider get _ap => getProvider<AppAuthProvider>();

  Future<void> login(FormGroup form) async {
    final BuildContext ctx = rootNav!.context;
    _ap.isLogin = true;
    _ap.login = LoginModel.fromJson(form.rawValue);
    await _api.login(_ap.login.email!, _ap.login.password!).then((value) async {
      _ap.isLogin = false;
      form.value.clear();
      if (await _api.hasSetup() == false) {
        _ap.isLogin = false;
        rootNav!.pushAndRemoveUntil(RouteHelper.fadeScale(() => const SetupScreen()), (route) => false);
        return;
      }
      credential = value;
      rootNav!.pushAndRemoveUntil(RouteHelper.fadeScale(() => const MainScreen()), (route) => false);
      return;
    }).catchError((e) {
      _ap.isLogin = false;
      if (e is FirebaseAuthException) {
        FlashHelper.snack(ctx, message: e.message!, status: EvFS.error);
      }
    });
  }

  Future<void> signup(FormGroup form) async {
    final BuildContext ctx = rootNav!.context;
    _ap.isSignup = true;
    _ap.reg = RegisterModel.fromJson(form.rawValue);

    await _api.signup(_ap.reg).then((value) {
      _ap.isSignup = false;
      FlashHelper.snack(ctx, message: 'Account successfully created');
      form.value.clear();
      rootNav!.pushAndRemoveUntil(RouteHelper.fadeScale(() => const MainScreen()), (route) => false);
    }).catchError((e) {
      _ap.isSignup = false;
      auth.currentUser?.delete();
      if (e is FirebaseAuthException) {
        FlashHelper.snack(ctx, message: e.message!, status: EvFS.error);
      } else {
        FlashHelper.snack(ctx, message: "$e", status: EvFS.error);
      }
    });
  }

  Future<void> getUser() async {
    DocumentSnapshot? doc = await _api.user();
  }

  Future<void> signOut() async {
    final BuildContext ctx = rootNav!.context;
    bool? signOut = false;
    signOut = await showModal(
      context: ctx,
      builder: (_) => EvDialog(
        title: 'SIGN OUT',
        actionText: 'Yes',
        msg: 'Do you really want to sign out of your account?',
        cFunc: () => rootNav?.pop(true),
        state: EvDS.warning,
      ),
    );
    if (signOut == true) auth.signOut();
  }
}
