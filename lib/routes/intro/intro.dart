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
      body: Stack(
        children: [
          PageView.builder(
            pageSnapping: true,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (value) => setState(() => pageIndex = value),
            itemCount: MockData.splashData.length,
            itemBuilder: (context, index) => Container(
              color: theme.accentVariant,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(flex: 2),
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
                              color: ColorHelper.shiftHsl(theme.background, .2),
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
                  const Spacer(flex: 6),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: context.widthPx,
              height: context.heightPct(.4),
              decoration: BoxDecoration(
                color: theme.background,
                boxShadow: Shadows.m(theme.grey, .2),
                borderRadius: BorderRadius.only(
                  topLeft: Corners.s10Radius,
                  topRight: Corners.s10Radius,
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
                      color: theme.primary.withOpacity(.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                          3,
                          (index) => Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: Corners.s10Border,
                              color: index == pageIndex
                                  ? theme.primary
                                  : theme.greyStrong,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                  Text(
                    MockData.splashData[pageIndex]['head']!,
                    textAlign: TextAlign.center,
                    style: TextStyles.h4.textColor(theme.txt),
                  ),
                  const VSpace(10),
                  Text(
                    MockData.splashData[pageIndex]['text']!,
                    style: TextStyles.h3
                        .textColor(theme.greyStrong)
                        .size(15)
                        .textHeight(1.9),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  const Spacer(flex: 2),
                  EvPriBtn(
                    child: const Text('Get started'),
                    onPressed: () => Navigator.push(context,
                        RouteHelper.fadeScale(() => const SignupScreen())),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
