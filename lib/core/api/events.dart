import 'package:evento/exports.dart';

class EventApi extends BaseApi {
  Future<QuerySnapshot> events() async {
    CollectionReference ref = db.collection(R.S.dbEvents);
    return await ref.get();
  }

  Future<QuerySnapshot> nearDate() async {
    DateTime date = DateTime.now();
    Query ref = db.collection(R.S.dbEvents).where('event_date',
        isGreaterThanOrEqualTo: date.millisecondsSinceEpoch);
    return await ref.get();
  }

  Future<QuerySnapshot> recommended(List<String> likes) async {
    Query ref = db
        .collection(R.S.dbEvents)
        .where('category', arrayContainsAny: [...likes]);
    return await ref.get();
  }
}
