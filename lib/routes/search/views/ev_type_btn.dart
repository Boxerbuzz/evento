import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvEventTypeBtn extends StatefulWidget {
  const EvEventTypeBtn(
      {this.selected = false, required this.icon, this.label, Key? key})
      : super(key: key);
  final bool selected;
  final String icon;
  final String? label;

  @override
  State<EvEventTypeBtn> createState() => _EvEventTypeBtnState();
}

class _EvEventTypeBtnState extends State<EvEventTypeBtn> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Column(
      children: [
        AnimatedContainer(
          duration: 200.milliseconds,
          height: 67,
          width: 67,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            border: Border.all(
              color: widget.selected ? theme.primary : theme.grey,
              width: 2,
            ),
            color: widget.selected ? theme.primary : Colors.transparent,
            boxShadow: widget.selected ? Shadows.m(theme.grey, .1) : null,
          ),
          child: EvSvgIc(
            widget.icon,
            color: widget.selected ? theme.surface : theme.primary,
          ).padding(all: 20),
        ),
        VSpace.md,
        Text(widget.label ?? '', style: TextStyles.body1),
      ],
    ).padding(right: 20);
  }
}
