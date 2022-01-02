import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

abstract class BaseApi extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage store = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn google = GoogleSignIn();

  UserCredential? _credential;
  UserCredential? get credential => _credential;
  set credential(UserCredential? value) {
    _credential = value;
    notifyListeners();
  }
}
