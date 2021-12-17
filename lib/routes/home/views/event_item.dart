import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({required this.data, Key? key}) : super(key: key);
  final EventModel data;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return EvContainer(
      width: double.infinity,
      borderRadius: Corners.s5Border,
      color: theme.surface,
      shadows: Shadows.m(theme.grey, .1),
      margin: EdgeInsets.symmetric(horizontal: Insets.l, vertical: 10),
      child: Row(
        children: [
          Container(
            width: context.widthPct(.22),
            height: context.heightPct(.13),
            decoration: BoxDecoration(
              borderRadius: Corners.s8Border,
              image: DecorationImage(image: AssetImage(data.img)),
              boxShadow: Shadows.m(theme.grey, .1),
            ),
          ),
          HSpace.md,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.timestamp,
                  style: TextStyles.body2.textColor(theme.primary),
                ),
                VSpace.md,
                Text(
                  data.name,
                  style: TextStyles.h6.bold.textHeight(1.4),
                ),
                VSpace.md,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EvSvgIc(R.I.location.svgB),
                    HSpace.sm,
                    Expanded(
                      child: Text(
                        data.location,
                        style: TextStyles.body1,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ).padding(all: Insets.m).rippleClick(() => gotoDetails(context)),
    );
  }

  gotoDetails(BuildContext ctx) => Navigator.push(
      ctx, RouteHelper.fadeScale(() => const DetailScreen()));
}
