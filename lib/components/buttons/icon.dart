import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvIcBtn extends StatelessWidget {
  final Function()? onPressed;

  final Widget? icon;
  final double? size;
  final Color? color;
  final Color? bgColor;
  final EdgeInsets? padding;
  final double? minWidth;
  final double? minHeight;
  final Function(bool)? onFocusChanged;
  final bool shrinkWrap;
  final double? radius;

  const EvIcBtn(
      this.icon, {
        Key? key,
        this.onPressed,
        this.color,
        this.size,
        this.padding,
        this.onFocusChanged,
        this.bgColor,
        this.minWidth,
        this.minHeight,
        this.shrinkWrap = false,
        this.radius,
      })  : assert((icon is Widget)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    bool mouseOver = false;
    return StatefulBuilder(
      builder: (_, setState) {
        Color iconColor = (color ?? Colors.black);
        if (mouseOver) {
          iconColor = ColorHelper.shiftHsl(iconColor, -.2);
        }
        return MouseRegion(
          onEnter: (_) => setState(() => mouseOver = true),
          onExit: (_) => setState(() => mouseOver = false),
          child: BaseBtn(
            minHeight: minHeight ?? (shrinkWrap ? 0 : 42),
            minWidth: minWidth ?? (shrinkWrap ? 0 : 42),
            bgColor: bgColor ?? Colors.transparent,
            downColor: theme.onBackground.withOpacity(.35),
            hoverColor: bgColor ?? Colors.transparent,
            onFocusChanged: onFocusChanged,
            contentPadding: padding ?? EdgeInsets.all(Insets.sm),
            onPressed: onPressed,
            borderRadius: radius,
            child: IgnorePointer(child: icon),
          ),
        );
      },
    );
  }
}
