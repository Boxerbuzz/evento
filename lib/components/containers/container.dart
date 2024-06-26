import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvContainer extends StatelessWidget {
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? shadows;
  final Widget? child;
  final double? width;
  final double? height;
  final Alignment? align;
  final EdgeInsetsGeometry? margin;
  final Duration? duration;
  final BoxBorder? border;

  const EvContainer(
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
      margin: margin,
      alignment: align,
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color ?? theme.primary,
        borderRadius: borderRadius,
        boxShadow: shadows,
        border: border,
      ),
      child: child,
    ).animate(duration ?? AppDurations.medium, Curves.bounceInOut);
  }
}
