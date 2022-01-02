import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({this.mini = false, Key? key}) : super(key: key);
  final bool mini;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return EvContainer(
      color: theme.surface,
      margin: EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.m),
      borderRadius: Corners.s5Border,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EvAltAvatar(
            '',
            email: 'boxerbuzz559@gmail.com',
            size: 45,
          ),
          HSpace.md,
          Expanded(
            child: Column(
              children: [
                Text(
                  R.S.lorem,
                  style: TextStyles.body2.textHeight(1.5),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                VSpace.md,
                mini == false
                    ? Row(
                        children: [
                          EvSecBtn(
                            onPressed: () {},
                            child: Text(
                              'Decline',
                              style: TextStyles.body1.textColor(theme.primary),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: Insets.l,
                            ),
                          ),
                          HSpace.md,
                          EvIcBtn(
                            Text(
                              'Accept',
                              style:
                                  TextStyles.body1.textColor(theme.background),
                            ),
                            bgColor: theme.primary,
                            onPressed: () {},
                            padding: EdgeInsets.symmetric(horizontal: Insets.l),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ).padding(top: 5),
          ),
          Text(
            'Just now',
            style: TextStyles.body2.textColor(theme.primary),
          ).padding(top: 5),
        ],
      ).padding(all: Insets.m),
    );
  }
}
