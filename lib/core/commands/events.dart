import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EventCmd extends EvBaseCommand {
  EventCmd(BuildContext c) : super(c);

  EventProvider get events => getProvider<EventProvider>();

  Future<void> run() async {}
}
