import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvCheckbox extends StatelessWidget {
  final bool? value;
  final double? size;
  final Function(bool?)? onChanged;

  const EvCheckbox({Key? key, this.value, this.size = 24, this.onChanged})
      : super(key: key);

  void _handleTapUp() {
    if (value == true) {
      onChanged!(false);
    } else if (value == false) {
      onChanged!(null);
    } else if (value == null) {
      onChanged!(true);
    }
  }

  Widget _getIconForCurrentState() {
    if (value == true) {
      return EvSvgIc(R.I.check.svgT, color: Colors.white, size: 15);
    }
    if (value == null) {
      return EvSvgIc(R.I.minus.svgT, color: Colors.white, size: 15);
    }
    return Container();
  }

  Widget _wrapGestures(Widget child) {
    if (onChanged == null) return child;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleTapUp,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        opaque: true,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: value == false ? Colors.transparent : theme.primary,
        borderRadius: Corners.s3Border,
        border: Border.all(
          color: value == false ? theme.grey : theme.primary,
          width: 1.5,
        ),
      ),
      child: _wrapGestures(_getIconForCurrentState()),
    );
  }
}
