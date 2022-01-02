import 'package:evento/exports.dart';

class AuthApi extends BaseApi {
  Future login(String email, psw) async {
    await auth.signInWithEmailAndPassword(email: email, password: psw);
  }

  Future signup(RegisterModel model) async {
    await auth
        .createUserWithEmailAndPassword(
            email: model.email!, password: model.password!)
        .then((value) async {
      credential = value;
      assert(credential != null);
      await _setup(model.toJson());
    });
  }

  Future _setup(Map<String, dynamic> vars) async {
    vars.update('id', (val) => credential?.user?.uid);

    await db.collection(R.S.dbUser).doc(credential?.user?.uid).set(vars);
  }
}
