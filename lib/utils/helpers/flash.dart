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

  static TextStyle _titleStyle(BuildContext context, [Color? color]) {
    var theme = Theme.of(context);
    return (theme.dialogTheme.titleTextStyle ?? theme.textTheme.headline6)!
        .copyWith(color: color);
  }

  static TextStyle _contentStyle(BuildContext context, [Color? color]) {
    var theme = Theme.of(context);
    return (theme.dialogTheme.contentTextStyle ?? theme.textTheme.bodyText2)!
        .copyWith(color: color);
  }

  static Future<T?>? busy<T>(BuildContext context,
      {required Completer<T> completer}) {
    var controller = FlashController<T>(
      context,
      persistent: true,
      builder: (context, FlashController<T> controller) => Flash.dialog(
        controller: controller,
        barrierDismissible: false,
        backgroundColor: Colors.black87,
        margin: const EdgeInsets.only(left: 40.0, right: 40.0),
        borderRadius: Corners.s5Border,
        child: const Padding(
          padding: EdgeInsets.all(30.0),
          child: CircularProgressIndicator(),
        ),
        useSafeArea: false,
      ),
    );
    completer.future.then((value) => controller.dismiss(value));
    return controller.show();
  }

  static Future<T?> snack<T>(
    BuildContext context, {
    String? title,
    required String message,
    MessageStatus status = MessageStatus.info,
    Duration duration = const Duration(seconds: 10),
  }) {
    Color color = status == MessageStatus.error
        ? Colors.redAccent
        : status == MessageStatus.info
            ? Colors.amber
            : Colors.greenAccent;
    IconData icon = status == MessageStatus.error
        ? Icons.close
        : status == MessageStatus.info
            ? Icons.info
            : Icons.check;
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            content: Text(message, style: _contentStyle(context, Colors.white)),
            icon: Icon(icon, color: color),
            indicatorColor: color,
          ),
          alignment: Alignment.bottomRight,
        );
      },
    );
  }
}

enum MessageStatus { error, info, success }

typedef ChildBuilder<T> = Widget Function(
    BuildContext context, FlashController<T> controller, StateSetter setState);
