import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController animCtrl;
  late Animation<double> appBarAnim;
  ScrollController ctrl = ScrollController();
  double opacity = 0.0;

  @override
  void initState() {
    animCtrl = AnimationController(duration: 600.milliseconds, vsync: this);
    appBarAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animCtrl,
        curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    ctrl.addListener(() {
      if (ctrl.offset >= 24) {
        if (opacity != 1.0) {
          setState(() {
            opacity = 1.0;
          });
        }
      } else if (ctrl.offset <= 24 && ctrl.offset >= 0) {
        if (opacity != ctrl.offset / 24) {
          setState(() {
            opacity = ctrl.offset / 24;
          });
        }
      } else if (ctrl.offset <= 0) {
        if (opacity != 0.0) {
          setState(() {
            opacity = 0.0;
          });
        }
      }
    });
    animCtrl.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<dynamic>>(
          future: MockData.getEvents(),
          builder: (context, AsyncSnapshot<List<dynamic>> snap) {
            if (snap.connectionState == ConnectionState.waiting &&
                snap.data == null) return const EvBusy();
            List<EventModel> events =
                snap.data!.map((e) => EventModel.fromJson(e)).toList();
            return SingleChildScrollView(
              controller: ctrl,
              padding: EdgeInsets.only(top: AppBar().preferredSize.height),
              child: Column(
                children: [
                  VSpace.lg,
                  const _InvitePromo(),
                  VSpace.xl,
                  EvSectionHeader(
                    title: R.S.upcoming,
                    more: true,
                    click: () {},
                  ).padding(horizontal: Insets.l),
                  EvShowcase(
                    items: events.take(3).toList(),
                    onChange: (value) {},
                  ),
                  VSpace.lg,
                  EvSectionHeader(
                    title: R.S.popular,
                    more: true,
                    click: () {},
                  ).padding(horizontal: Insets.l),
                  ...events.reversed
                      .take(5)
                      .map((event) => EventItem(data: event)),
                ],
              ),
            );
          },
        ),
        _HomeAppBar(animCtrl, anim: appBarAnim, opacity: opacity)
      ],
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar(this.ctrl,
      {required this.anim, required this.opacity, Key? key})
      : super(key: key);
  final AnimationController ctrl;
  final Animation<double> anim;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: ctrl,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: anim,
              child: Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  40 * (1.0 - anim.value),
                  0.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.surface.withOpacity(opacity),
                    boxShadow: Shadows.m(
                      ColorHelper.shiftHsl(theme.grey, opacity),
                      .1,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      VSpace(MediaQuery.of(context).padding.top),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16 - 8.0 * opacity,
                          bottom: 12 - 8.0 * opacity,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _renderLocationDate(),
                            EvIcBtn(
                              EvSvgIc(R.I.search.svgT),
                              onPressed: () => Navigator.push(
                                context,
                                RouteHelper.fadeScale(
                                  () => const SearchScreen(),
                                ),
                              ),
                            ),
                            HSpace.md,
                            EvIcBtn(
                              EvSvgIc(R.I.notification.svgT),
                              onPressed: () => Navigator.push(
                                context,
                                RouteHelper.fadeScale(
                                  () => const NotificationScreen(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _renderLocationDate() {
    TextStyle st = TextStyles.h7.letterSpace(1.2).size(10 + 6 - 6 * opacity);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EvSvgIc(R.I.location.svgT, size: 10 + 6 - 6 * opacity),
                HSpace.sm,
                Text(
                  "Lot 12, Apt 3B. Oakland, CA",
                  textAlign: TextAlign.left,
                  style: st,
                ),
              ],
            ),
            Row(
              children: [
                EvIcBtn(
                  EvSvgIc(R.I.arrowLeft.svgT),
                  onPressed: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: EvSvgIc(R.I.calendar.svgT),
                      ),
                      Text(
                        "16 Dec",
                        textAlign: TextAlign.left,
                        style: TextStyles.body1.letterSpace(-0.2),
                      ),
                    ],
                  ),
                ),
                EvIcBtn(
                  EvSvgIc(R.I.arrowRight.svgT),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InvitePromo extends StatelessWidget {
  const _InvitePromo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return EvContainer(
      height: context.heightPct(.15),
      width: double.infinity,
      color: ColorHelper.shiftHsl(theme.accent.withOpacity(.3), .3),
      margin: EdgeInsets.symmetric(horizontal: Insets.l),
      borderRadius: Corners.s5Border,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invite your friends',
                  style: TextStyles.h5.textColor(theme.txt),
                ),
                const Spacer(flex: 1),
                Text('Get \$20 worth of ticket', style: TextStyles.h7),
                const Spacer(flex: 1),
                EvIcBtn(
                  Text(
                    'Invite',
                    style: TextStyles.body1.textColor(theme.txt),
                  ),
                  bgColor: theme.accent,
                  onPressed: () {},
                  padding: EdgeInsets.symmetric(horizontal: Insets.l),
                ),
              ],
            ),
          ),
          Positioned(
            top: -80,
            right: -25,
            child: Image.asset(
              'assets/images/promo.png',
              fit: BoxFit.contain,
              height: 340,
              width: 340,
            ).center(),
          ),
        ],
      ),
    );
  }
}
