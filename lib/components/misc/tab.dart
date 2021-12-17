import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvTabBar extends StatelessWidget {
  final Function(int)? onTabPressed;
  final double? width;
  final List<String> sections;
  final int index;
  static const List<String> defaults = ["foo", "bar"];

  const EvTabBar({
    Key? key,
    this.width,
    this.sections = defaults,
    this.index = 0,
    this.onTabPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    List<Widget> clickableLabels =
    sections.map((e) => _clickableLabel(e, theme)).toList();

    double targetAlignX = -1 + (index * 1 / (sections.length - 1)) * 2;
    return RepaintBoundary(
      child: Stack(
        children: <Widget>[
          _roundedBox(border: Colors.black45),
          _roundedBox(fill: theme.primary)
              .fractionallySizedBox(widthFactor: 1 / sections.length)
              .alignment(Alignment(targetAlignX, 0), animate: true)
              .animate(Durations.slow, Curves.easeOut),
          Row(children: clickableLabels)
        ],
      ).height(30),
    );
  }

  Widget _roundedBox({double? width, Color? border, Color? fill}) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: Corners.s5Border,
        border: Border.all(
          color: border?.withOpacity(.35) ?? Colors.transparent,
        ),
      ),
    );
  }

  Widget _clickableLabel(String e, AppTheme theme, [double fontScale = 1]) {
    bool isSelected = sections.indexOf(e) == index;
    Color selected = theme.isDark ? theme.surface : theme.surface;
    Color notSelected = theme.isDark ? theme.greyStrong : Colors.black45;

    return AnimatedDefaultTextStyle(
      duration: Durations.fast,
      style: TextStyles.body2.bold
          .textColor(isSelected ? selected : notSelected)
          .scale(fontScale),
      child: Text(e.toUpperCase())
          .center()
          .clickable(() => onTabPressed?.call(sections.indexOf(e)),
          opaque: true)
          .expanded(),
    );
  }
}