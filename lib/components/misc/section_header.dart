import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvSectionHeader extends StatelessWidget {
  const EvSectionHeader(
      {required this.title, this.more = false, this.click, Key? key})
      : super(key: key);
  final String title;
  final bool more;
  final Function()? click;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Column(
      children: [
        Row(
          children: [
            Text(title, style: TextStyles.h6.semiBold),
            Expanded(child: Container()),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'More..',
                  style: TextStyles.button.textColor(theme.primary),
                ),
                HSpace.sm,
                EvSvgIc(R.I.arrowRight.svgT, size: 15),
              ],
            ).rippleClick(() => click),
          ],
        ),
        VSpace.lg
      ],
    );
  }
}
