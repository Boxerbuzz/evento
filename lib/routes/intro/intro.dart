import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 50),
            Expanded(
              flex: 3,
              child: PageView.builder(
                pageSnapping: true,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) => setState(() => pageIndex = value),
                itemCount: MockData.splashData.length,
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 240,
                              width: 240,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360.0),
                                color: ColorHelper.shiftHsl(
                                    theme.accent.withOpacity(.1), .2),
                              ),
                              child: SvgPicture.asset(
                                MockData.splashData[index]['image']!,
                                height: 210,
                                width: 210,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.primary,
                  boxShadow: Shadows.m(theme.grey, .2),
                  borderRadius: BorderRadius.only(
                    topLeft: Corners.s8Radius,
                    topRight: Corners.s8Radius,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: Insets.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Spacer(),
                    Container(
                      height: 30,
                      width: 80,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: theme.accent,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Text(
                      MockData.splashData[pageIndex]['head']!,
                      textAlign: TextAlign.center,
                      style: TextStyles.h4.textColor(theme.surface),
                    ),
                    const VSpace(10),
                    Text(
                      MockData.splashData[pageIndex]['text']!,
                      style: TextStyles.h3
                          .textColor(Colors.white70)
                          .size(15)
                          .textHeight(1.9),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                    const Spacer(flex: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Skip',
                          style: TextStyles.body1.textColor(theme.surface).bold,
                        ).rClick(() {}),
                        Text(
                          'Next',
                          style: TextStyles.body1.textColor(theme.surface).bold,
                        ).rClick(
                          () => Navigator.pushAndRemoveUntil(
                              context,
                              RouteHelper.fadeScale(() => const AuthScreen()),
                              (route) => false),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
