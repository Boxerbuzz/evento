import 'package:evento/exports.dart';
import 'package:flutter/material.dart';
import './views/item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    bool hasData = true;
    return Scaffold(
      appBar: EvAppBar(title: R.S.notification),
      body: hasData == true
          ? Column(
              children: const [
                NotificationItem(),
                NotificationItem(mini: true),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EvSvgIc(
                  R.I.directNotification.svgB,
                  size: 100,
                  color: ColorHelper.shiftHsl(theme.primary, .15),
                ).center(),
                VSpace.sm,
                Text(
                  'No Notifications',
                  style: TextStyles.h6.bold.textColor(theme.txt),
                ),
                Text(
                  R.S.notifyMsg,
                  style: TextStyles.body1.textColor(theme.txt).textHeight(1.5),
                  textAlign: TextAlign.center,
                ).padding(horizontal: Insets.l, top: Insets.sm),
              ],
            ),
    );
  }
}
