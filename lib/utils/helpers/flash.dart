import 'dart:async';
import 'dart:collection';

import 'package:evento/exports.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class _MessageItem<T> {
  final String message;
  Completer<Future<T>> completer;

  _MessageItem(this.message) : completer = Completer<Future<T>>();
}

class FlashHelper {
  static Completer<BuildContext> _buildCompleter = Completer<BuildContext>();
  static final Queue<_MessageItem> _messageQueue = Queue<_MessageItem>();

  static void init(BuildContext context) {
    if (_buildCompleter.isCompleted == false) {
      _buildCompleter.complete(context);
    }
  }

  static void dispose() {
    _messageQueue.clear();
    if (_buildCompleter.isCompleted == false) {
      _buildCompleter.completeError('NotInitialize');
    }
    _buildCompleter = Completer<BuildContext>();
  }

  static TextStyle _titleStyle([Color? color]) => TextStyles.body1.textColor(color!).bold;

  static TextStyle _contentStyle([Color? color]) {
    return TextStyles.body3.textColor(color!);
  }

  static Future<T?>? busy<T>(BuildContext context, {required Completer<T> completer}) {
    return showFlash(
      context: context,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          child: const Padding(
            padding: EdgeInsets.all(30.0),
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  static Future<T?> snack<T>(
    BuildContext context, {
    String? title,
    required String message,
    EvFS status = EvFS.info,
    Duration duration = const Duration(seconds: 10),
  }) {
    Color color = status == EvFS.error
        ? Colors.redAccent
        : status == EvFS.info
            ? Colors.amber
            : Colors.greenAccent;
    IconData icon = status == EvFS.error
        ? Icons.close
        : status == EvFS.info
            ? Icons.info
            : Icons.check;
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          child: FlashBar(
            title: Text(title ?? 'Evento', style: _titleStyle(Colors.white)),
            content: Text(message, style: _contentStyle(Colors.white)),
            icon: Icon(icon, color: color),
            indicatorColor: color,
            controller: controller,
          ),
        );
      },
    );
  }
}

enum EvFS { error, info, success }

typedef ChildBuilder<T> = Widget Function(BuildContext context, FlashController<T> controller, StateSetter setState);
