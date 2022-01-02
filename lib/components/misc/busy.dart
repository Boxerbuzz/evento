import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvBusy extends StatelessWidget {
  const EvBusy({this.color, Key? key}) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(theme.txt),
        backgroundColor: color ?? theme.primary,
      ).center(),
    ).alignment(Alignment.center);
  }
}
