import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class BaseBtn extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Function(bool)? onFocusChanged;
  final Function(bool)? onHighlightChanged;
  final Color? bgColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? downColor;
  final EdgeInsets? contentPadding;
  final double? minWidth;
  final double? minHeight;
  final double? borderRadius;
  final bool useBtnText;
  final bool autoFocus;
  final double? width;

  final ShapeBorder? shape;

  final Color outlineColor;

  const BaseBtn({
    Key? key,
    required this.child,
    this.onPressed,
    this.onFocusChanged,
    this.onHighlightChanged,
    this.bgColor,
    this.focusColor,
    this.contentPadding,
    this.minWidth,
    this.minHeight,
    this.borderRadius,
    this.hoverColor,
    this.downColor,
    this.shape,
    this.useBtnText = true,
    this.autoFocus = false,
    this.outlineColor = Colors.transparent,
    this.width,
  }) : super(key: key);

  @override
  _BaseBtnState createState() => _BaseBtnState();
}

class _BaseBtnState extends State<BaseBtn> {
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(debugLabel: "", canRequestFocus: true);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != _isFocused) {
        setState(() => _isFocused = _focusNode.hasFocus);
        widget.onFocusChanged?.call(_isFocused);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.bgColor ?? theme.txt,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? Corners.s5),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                    color: theme.surface.withOpacity(0.25),
                    offset: Offset.zero,
                    blurRadius: 8.0,
                    spreadRadius: 0.0),
                BoxShadow(
                    color: widget.bgColor ?? theme.surface,
                    offset: Offset.zero,
                    blurRadius: 8.0,
                    spreadRadius: -4.0),
              ]
            : [],
      ),
      foregroundDecoration: _isFocused
          ? ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.8, color: theme.txt),
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? Corners.s5,
                ),
              ),
            )
          : null,
      child: RawMaterialButton(
        focusNode: _focusNode,
        autofocus: widget.autoFocus,
        textStyle: widget.useBtnText ? TextStyles.button : null,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        splashColor: Colors.transparent,
        mouseCursor: SystemMouseCursors.click,
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        focusElevation: 0,
        fillColor: Colors.transparent,
        hoverColor: widget.hoverColor ?? theme.surface,
        highlightColor:
            widget.downColor ?? theme.primaryVariant.withOpacity(.1),
        focusColor: widget.focusColor ?? Colors.grey.withOpacity(0.35),
        child: Opacity(
          child: Padding(
            padding: widget.contentPadding ?? const EdgeInsets.all(18),
            child: widget.child,
          ),
          opacity: widget.onPressed != null ? 1 : .7,
        ),
        constraints: BoxConstraints(
          minHeight: widget.minHeight ?? 0,
          minWidth: widget.minWidth ?? context.widthPct(.7),
        ),
        onPressed: widget.onPressed,
        shape: widget.shape ??
            RoundedRectangleBorder(
              side: BorderSide(color: widget.outlineColor, width: 1.5),
              borderRadius:
                  BorderRadius.circular(widget.borderRadius ?? Corners.s5),
            ),
      ),
    );
  }
}

class EvPriBtn extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final bool? loading;

  const EvPriBtn({Key? key, required this.child, this.onPressed, this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return BaseBtn(
      minWidth: context.widthPct(.7),
      width: context.widthPct(.7),
      minHeight: 50,
      useBtnText: true,
      bgColor: theme.primaryVariant,
      hoverColor: theme.isDark ? theme.accentVariant : theme.accentVariant,
      downColor: theme.primary,
      borderRadius: Corners.s5,
      child: Stack(
        children: [
          child.center(),
          loading == true
              ? const SizedBox(
                      child: EvBusy(color: Colors.white), height: 12, width: 12)
                  .alignment(Alignment.centerRight)
              : const SizedBox.shrink(),
        ],
      ),
      onPressed: () {
        AppHelper.unFocus();
        loading == true ? null : onPressed!();
      },
    );
  }
}

class EvPriTextBtn extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final bool? loading;

  const EvPriTextBtn(this.label,
      {Key? key, this.onPressed, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle txtStyle = (TextStyles.body1).textColor(Colors.white);
    return EvPriBtn(
      onPressed: onPressed,
      child: Text(label, style: txtStyle).center(),
      loading: loading,
    );
  }
}
