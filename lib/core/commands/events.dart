import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EventCmd extends EvBaseCommand {
  EventCmd(BuildContext c) : super(c);

  ///*Events Provider*///
  EventProvider get _ep => getProvider<EventProvider>();

  ///*Auth Provider*///
  AuthProvider get _ap => getProvider<AuthProvider>();

  ///*Events Api*///
  final EventApi _api = EventApi();

  ///*Fetch Events in future date*///
  Future<void> date() async {
    final BuildContext _ctx = rootNav!.context;
    _ep.fetch = true;
    await _api.events().then((value) {
      _ep.fetch = false;
    }).catchError(
      (e) {
        _ep.fetch = false;
        showModal(
          context: _ctx,
          builder: (_) => EvDialog(
            title: 'Error',
            actionText: 'Ok',
            msg: R.S.fetchMsg,
          ),
        );
      },
    );
  }

  ///*Fetch Recommended events based on liked categories*///
  Future<void> recommend() async {
    final BuildContext _ctx = rootNav!.context;
    _ep.fetch = true;
    await _api.recommended(_ap.liked).then((value) {
      _ep.fetch = false;
    }).catchError(
      (e) {
        _ep.fetch = false;
        showModal(
          context: _ctx,
          builder: (_) => EvDialog(
            title: 'Error',
            actionText: 'Ok',
            msg: R.S.fetchMsg,
          ),
        );
      },
    );
  }

  ///*Fetch all events*///
  Future<void> events() async {
    final BuildContext _ctx = rootNav!.context;
    _ep.fetch = true;
    await _api.events().then((value) {
      _ep.fetch = false;
    }).catchError(
      (e) {
        _ep.fetch = false;
        showModal(
          context: _ctx,
          builder: (_) => EvDialog(
            title: 'Error',
            actionText: 'Ok',
            msg: R.S.fetchMsg,
          ),
        );
      },
    );
  }
}
