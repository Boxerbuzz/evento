import 'package:evento/exports.dart';

class AuthApi extends BaseApi {
  Future<UserCredential?> login(String email, psw) async {
    return await auth.signInWithEmailAndPassword(email: email, password: psw);
  }

  Future<UserCredential?> signup(RegisterModel model) async {
    return await auth
        .createUserWithEmailAndPassword(
            email: model.email!, password: model.password!)
        .then((value) async {
      credential = value;
      assert(credential != null);
      return await _setup(model.toJson());
    });
  }

  Future<UserCredential?> _setup(Map<String, dynamic> vars) async {
    vars.update('id', (val) => credential?.user?.uid);

    await db.collection(R.S.dbUser).doc(credential?.user?.uid).set(vars);
    return credential;
  }

  Future<bool> hasSetup() async {
    return await db
        .collection(R.S.dbUser)
        .doc(fbUser!.uid)
        .get()
        .then((doc) => doc.exists);
  }

  Future<DocumentSnapshot?> user() async {
    bool setup = await hasSetup();
    if (setup) {
      return await db.collection(R.S.dbUser).doc(fbUser!.uid).get();
    }
    return null;
  }
}
