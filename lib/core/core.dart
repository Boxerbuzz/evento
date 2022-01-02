import 'package:evento/exports.dart';
import 'package:firebase_core/firebase_core.dart';

enum _EvEnv { dev }

class ApiCore {
  static const _EvEnv env = _EvEnv.dev;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage store = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  static const host = '192.168.56.41';

  Future<void> init({bool sandbox = true}) async {
    await Firebase.initializeApp();
    db.enablePersistence(const PersistenceSettings(synchronizeTabs: true));
    if (env == _EvEnv.dev && sandbox) {
      db.useFirestoreEmulator(host, 8080);
      auth.useAuthEmulator(host, 9099);
      store.useStorageEmulator(host, 9199);
    }
  }
}
