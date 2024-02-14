import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvSecTextBtn extends StatelessWidget {
  final String label;
  final Function()? onPressed;

  const EvSecTextBtn(this.label, {Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    TextStyle txtStyle = TextStyles.footnote.textColor(theme.accentVariant);
    return EvSecBtn(
      onPressed: onPressed,
      child: Text(label, style: txtStyle),
    );
  }
}

class EvSecIcBtn extends StatelessWidget {
  final String icon;
  final Function()? onPressed;
  final Color? color;

  const EvSecIcBtn(this.icon, {Key? key, this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return EvSecBtn(
      onPressed: onPressed,
      minHeight: 36,
      minWidth: 36,
      contentPadding: EdgeInsets.all(Insets.sm),
      child: EvSvgIc(icon, size: 20, color: color ?? theme.grey),
    );
  }
}

class EvSecBtn extends StatefulWidget {
  final Widget? child;
  final Function()? onPressed;
  final double? minWidth;
  final double? minHeight;
  final EdgeInsets? contentPadding;
  final Function(bool)? onFocusChanged;

  const EvSecBtn(
      {Key? key, this.child, this.onPressed, this.minWidth, this.minHeight, this.contentPadding, this.onFocusChanged})
      : super(key: key);

  @override
  State<EvSecBtn> createState() => _EvSecBtnState();
}

class _EvSecBtnState extends State<EvSecBtn> {
  bool _isMouseOver = false;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return MouseRegion(
      onEnter: (_) => setState(() => _isMouseOver = true),
      onExit: (_) => setState(() => _isMouseOver = false),
      child: BaseBtn(
        minWidth: widget.minWidth ?? 78,
        minHeight: widget.minHeight ?? 42,
        contentPadding: widget.contentPadding ?? EdgeInsets.all(Insets.m),
        bgColor: theme.surface,
        outlineColor: (_isMouseOver ? theme.primary : theme.primary),
        hoverColor: theme.surface,
        onFocusChanged: widget.onFocusChanged,
        downColor: theme.grey.withOpacity(.35),
        borderRadius: Corners.s5,
        onPressed: widget.onPressed,
        child: IgnorePointer(child: widget.child),
      ),
    );
  }
}
