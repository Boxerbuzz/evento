import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvSvgIc extends StatelessWidget {
  const EvSvgIc(this.icon, {this.size, this.color, Key? key}) : super(key: key);
  final String icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return SvgPicture.asset(
      icon,
      width: size ?? Sizes.iconMed,
      height: size ?? Sizes.iconMed,
      color: color ?? theme.txt,
      fit: BoxFit.contain,
    );
  }
}
