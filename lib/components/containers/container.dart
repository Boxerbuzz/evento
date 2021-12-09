import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EVContainer extends StatelessWidget {
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? shadows;
  final Widget? child;
  final double? width;
  final double? height;
  final Alignment? align;
  final EdgeInsets? margin;
  final Duration? duration;
  final BoxBorder? border;

  const EVContainer(
      {Key? key,
      this.color,
      this.borderRadius,
      this.shadows,
      this.child,
      this.width,
      this.height,
      this.align,
      this.margin,
      this.duration,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Container(
      width: width,
      height: height,
      child: child,
      margin: margin,
      alignment: align,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color ?? theme.primary,
        borderRadius: borderRadius,
        boxShadow: shadows,
        border: border,
      ),
    ).animate(duration ?? Durations.medium, Curves.bounceInOut);
  }
}
