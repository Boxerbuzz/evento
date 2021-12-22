import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Column(
      children: [
        EvContainer(
          color: theme.surface,
          child: EvCalendar(
            firstDate: DateTime(2020),
            lastDate: DateTime(2061),
            initialDate: DateTime.now(),
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.m),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EvContainer(
            height: 40,
            width: 40,
            borderRadius: Corners.s5Border,
            color: ColorHelper.shiftHsl(theme.primary, .2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Mar',
                  style: TextStyles.body1
                      .textColor(theme.primaryVariant)
                      .letterSpace(1.5),
                ),
                Text(
                  '17',
                  style: TextStyles.h5.semiBold
                      .textColor(theme.primaryVariant)
                      .letterSpace(6),
                ),
              ],
            ),
          ),
          HSpace.md,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('WED, 17TH MARCH, 2021', style: TextStyles.body3.bold),
              VSpace.sm,
              EvContainer(
                height: 65,
                width: context.widthPct(.75),
                borderRadius: Corners.s5Border,
                child: Row(
                  children: const [],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
