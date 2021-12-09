import 'package:evento/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(this.icon, {this.size, this.color, Key? key}) : super(key: key);
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
