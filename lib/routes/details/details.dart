import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late ScrollController _ctrl;
  late EventModel model;
  bool showMore = false;

  @override
  void initState() {
    super.initState();
    _ctrl = ScrollController();
    model = EventModel.fromJson(MockData.events[0]);
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          EvAppBar(
            title: R.S.ed,
            trailing: [
              EvIcBtn(
                EvSvgIc(R.I.archive.svgB),
                onPressed: () {},
              ),
              HSpace.md,
            ],
          ),
          Expanded(
            child: NestedScrollView(
              controller: _ctrl,
              headerSliverBuilder: (context, inner) {
                return [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return EvContainer(
                        color: theme.background,
                        height: context.heightPct(.35),
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/bg.png',
                              height: context.heightPct(.28),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: context.heightPct(.245),
                              right: Insets.l,
                              left: Insets.l,
                              child: EvContainer(
                                height: 60,
                                width: double.infinity,
                                color: theme.surface,
                                shadows: Shadows.m(theme.grey, .1),
                                borderRadius: BorderRadius.circular(30),
                                child: Row(
                                  children: [
                                    HSpace.md,
                                    const Expanded(
                                      child: FacePile(
                                        facePercentOverlap: .3,
                                        faceSize: 30,
                                        urls: [
                                          'https://randomuser.me/api/portraits/men/36.jpg',
                                          'https://randomuser.me/api/portraits/men/74.jpg',
                                          'https://randomuser.me/api/portraits/men/20.jpg',
                                          'https://randomuser.me/api/portraits/men/50.jpg',
                                          'https://randomuser.me/api/portraits/men/12.jpg',
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '+ 12k Going',
                                      style: TextStyles.body2
                                          .textColor(theme.primary),
                                    ),
                                    HSpace.lg,
                                    EvIcBtn(
                                      Text(
                                        'Share',
                                        style: TextStyles.body1
                                            .textColor(theme.background),
                                      ),
                                      bgColor: theme.primary,
                                      onPressed: () {},
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Insets.l,
                                      ),
                                    ),
                                    HSpace.lg,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }, childCount: 1),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _Header(
                      Container(
                        color: theme.background,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: EvTabBar(
                          sections: const ['Details', 'Comments'],
                          index: 0,
                          onTabPressed: (value) {},
                        ).padding(horizontal: Insets.l),
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: Insets.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: TextStyles.h4
                          .letterSpace(1.9)
                          .textHeight(1.5)
                          .semiBold,
                    ),
                    VSpace.lg,
                    Row(
                      children: [
                        EvIcBtn(
                          EvSvgIc(R.I.calendar.svgB),
                          bgColor: ColorHelper.shiftHsl(theme.primary, .25),
                          onPressed: () {},
                          padding: const EdgeInsets.all(12),
                        ),
                        HSpace.md,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Event Date',
                                style: TextStyles.h6.semiBold,
                              ),
                              VSpace.sm,
                              Text(
                                '14th Dec, 21',
                                style: TextStyles.button.semiBold
                                    .textColor(theme.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    VSpace.lg,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EvIcBtn(
                          EvSvgIc(R.I.location.svgB),
                          bgColor: ColorHelper.shiftHsl(theme.primary, .25),
                          onPressed: () {},
                          padding: const EdgeInsets.all(12),
                        ),
                        HSpace.md,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const VSpace(4),
                              Text(
                                'Event Location',
                                style: TextStyles.h6.semiBold,
                              ),
                              VSpace.sm,
                              Text(
                                model.location,
                                style: TextStyles.button.semiBold
                                    .textColor(theme.primary),
                              ),
                              VSpace.md,
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: Corners.s5Border,
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/map.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    color: theme.grey,
                                    width: .9,
                                  ),
                                  boxShadow: Shadows.m(theme.grey, .1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    VSpace.lg,
                    Row(
                      children: [
                        EvIcBtn(
                          EvSvgIc(R.I.user.svgB),
                          bgColor: ColorHelper.shiftHsl(theme.primary, .25),
                          onPressed: () {},
                          padding: const EdgeInsets.all(12),
                        ),
                        HSpace.md,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Organizer',
                                style: TextStyles.h6.semiBold,
                              ),
                              VSpace.sm,
                              Text(
                                'Boxerbuzz',
                                style: TextStyles.button.semiBold
                                    .textColor(theme.primary),
                              ),
                            ],
                          ),
                        ),
                        HSpace.md,
                        EvIcBtn(
                          Text(
                            'Follow',
                            style: TextStyles.body1.textColor(theme.background),
                          ),
                          bgColor: theme.primary,
                          onPressed: () {},
                          padding: EdgeInsets.symmetric(horizontal: Insets.l),
                        ),
                      ],
                    ),
                    VSpace.lg,
                    Text(
                      'About Event',
                      style: TextStyles.h6.semiBold,
                    ),
                    VSpace.md,
                    AnimatedCrossFade(
                      duration: 600.milliseconds,
                      crossFadeState: showMore
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: Text(
                        R.S.lorem,
                        style: TextStyles.body1
                            .textColor(theme.txt)
                            .textHeight(1.5)
                            .letterSpace(.7),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      secondChild: Text(
                        R.S.lorem,
                        style: TextStyles.body1
                            .textColor(theme.txt)
                            .textHeight(1.5)
                            .letterSpace(.7),
                      ),
                      firstCurve: Curves.fastLinearToSlowEaseIn,
                      reverseDuration: 600.milliseconds,
                      secondCurve: Curves.easeInOut,
                      sizeCurve: Curves.easeInOut,
                    ),
                    VSpace.sm,
                    showMore == false
                        ? Row(
                            children: [
                              Text(
                                'Show More...',
                                style:
                                    TextStyles.button.textColor(theme.primary),
                              ).rClick(
                                  () => setState(() => showMore = true)),
                              EvSvgIc(R.I.chevronDown.svgT, size: 12),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                'Show Less...',
                                style:
                                    TextStyles.button.textColor(theme.primary),
                              ).rClick(
                                  () => setState(() => showMore = false)),
                              EvSvgIc(R.I.chevronUp.svgT, size: 12)
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends SliverPersistentHeaderDelegate {
  final Widget child;
  _Header(
    this.child,
  );
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
