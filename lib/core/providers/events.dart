import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  List<EventModel> _events = [];
  List<EventModel> get events => _events;

  set events(List<EventModel> value) {
    _events = value.map((e) => e).toList();
    notifyListeners();
  }

  bool _fetch = false;
  bool get fetch => _fetch;

  set fetch(bool value) {
    _fetch = value;
    notifyListeners();
  }
}
