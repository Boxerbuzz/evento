import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Column(
      children: [
        EvContainer(
          color: theme.surface,
          child: Column(
            children: [
              Row(
                children: [
                  HSpace.lg,
                  Expanded(
                    child: Text(R.S.profile, style: TextStyles.h5.semiBold),
                  ),
                  EvIcBtn(
                    EvSvgIc(R.I.moreSquare.svgT),
                    onPressed: () {},
                  ),
                  HSpace.md,
                ],
              ),
              VSpace.lg,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EvIcBtn(
                    EvSvgIc(R.I.logout.svgB, color: theme.surface),
                    onPressed: () => AuthCmd(context).signOut(),
                    padding: const EdgeInsets.all(9),
                    bgColor: ColorHelper.shiftHsl(theme.primary, .1),
                  ),
                  HSpace.lg,
                  const EvAltAvatar(
                    '',
                    email: 'boxerbuzz559@gmail.com',
                    size: 90,
                  ),
                  HSpace.lg,
                  EvIcBtn(
                    EvSvgIc(R.I.ticketStar.svgB, color: theme.surface),
                    bgColor: ColorHelper.shiftHsl(theme.primary, .1),
                    padding: const EdgeInsets.all(9),
                  ),
                ],
              ),
              VSpace.lg,
              Text(
                'Timothy Ofie',
                style: TextStyles.h5.size(26).semiBold,
              ),
              VSpace.sm,
              Text(
                'Boxerbuzz559@gmail.com',
                style: TextStyles.body1.textColor(Colors.grey.shade600),
              ),
              VSpace.lg,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('12.9K', style: TextStyles.body1.bold),
                      VSpace.md,
                      Text(
                        'Followers',
                        style: TextStyles.body1.semiBold.textColor(Colors.grey),
                      ),
                    ],
                  ),
                  HSpace.md,
                  VerticalDivider(color: theme.grey).height(40),
                  HSpace.md,
                  Column(
                    children: [
                      Text('200', style: TextStyles.body1.bold),
                      VSpace.md,
                      Text(
                        'Following',
                        style: TextStyles.body1.semiBold.textColor(Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              VSpace.lg,
              EvSecBtn(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EvSvgIc(R.I.edit.svgT, color: theme.primary),
                    HSpace.md,
                    Text(
                      'Edit Profile',
                      style: TextStyles.body1.textColor(theme.primary),
                    ),
                  ],
                ),
              ),
              VSpace.lg,
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Insets.l),
            child: Column(
              children: const [],
            ),
          ),
        ),
      ],
    );
  }
}
