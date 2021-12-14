import 'dart:math';

import 'package:flutter/material.dart';
import 'package:evento/exports.dart';

class SkewH extends StatefulWidget {
  const SkewH({Key? key, this.items = const [], this.onChange})
      : super(key: key);
  final List<dynamic> items;
  final Function? onChange;

  @override
  _SkewHState createState() => _SkewHState();
}

class _SkewHState extends State<SkewH> with SingleTickerProviderStateMixin {
  final double _maxRotation = 20;

  late PageController _pageController;

  double _cardWidth = 160;
  double _cardHeight = 200;
  double _normalizedOffset = 0;
  double _prevScrollX = 0;
  bool _isScrolling = false;

  AnimationController? _tweenController;
  Tween<double>? _tween;
  Animation<double>? _tweenAnim;

  @override
  Widget build(BuildContext context) {
    _cardHeight = (context.heightPct(.38)).clamp(130.0, 230.0);
    _cardWidth = context.widthPct(.83);
    _pageController = PageController(
      initialPage: 1,
      viewportFraction:
          widget.items.length > 1 ? _cardWidth / context.widthPx : 0.89,
    );

    Widget listContent = SizedBox(
      height: _cardHeight,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: widget.items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => _buildItemRenderer(i),
      ),
    );

    return Listener(
      onPointerUp: _handlePointerUp,
      child: NotificationListener(
        onNotification: _handleScrollNotifications,
        child: listContent,
      ),
    );
  }

  Widget _buildItemRenderer(int itemIndex) {
    return _Rotation3d(
      rotationY: _normalizedOffset * _maxRotation,
      child: _RenderItem(
        _normalizedOffset,
        item: widget.items[itemIndex % widget.items.length],
        cardWidth: _cardWidth,
        color: itemIndex == 0 ? Colors.indigoAccent : Colors.pinkAccent,
        cardHeight: _cardHeight,
        length: widget.items.length,
      ),
    );
  }

  bool _handleScrollNotifications(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_isScrolling) {
        double dx = notification.metrics.pixels - _prevScrollX;
        double scrollFactor = .01;
        double newOffset = (_normalizedOffset + dx * scrollFactor);
        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      _prevScrollX = notification.metrics.pixels;
      widget.onChange!(widget.items
          .elementAt(_pageController.page!.round() % widget.items.length));
    }
    //Scroll Start
    else if (notification is ScrollStartNotification) {
      _isScrolling = true;
      _prevScrollX = notification.metrics.pixels;
      if (_tween != null) {
        _tweenController?.stop();
      }
    }
    return true;
  }

  void _handlePointerUp(PointerUpEvent event) {
    if (_isScrolling) {
      _isScrolling = false;
      _startOffsetTweenToZero();
    }
  }

  void _setOffset(double value) => setState(() => _normalizedOffset = value);

  void _startOffsetTweenToZero() {
    int tweenTime = 1000;
    if (_tweenController == null) {
      _tweenController =
          AnimationController(vsync: this, duration: tweenTime.milliseconds);
      _tween = Tween<double>(begin: -1, end: 0);
      _tweenAnim = _tween?.animate(
          CurvedAnimation(parent: _tweenController!, curve: Curves.elasticOut));
      _tweenAnim?.addListener(() => _setOffset(_tweenAnim!.value));
    }
    _tween?.begin = _normalizedOffset;
    _tweenController?.reset();
    _tween?.end = 0;
    _tweenController?.forward();
  }
}

class _Rotation3d extends StatelessWidget {
  //Degrees to rads constant
  static const double degrees2Radians = pi / 160;

  final Widget child;
  final double rotationX;
  final double rotationY;
  final double rotationZ;

  const _Rotation3d(
      {Key? key,
      required this.child,
      this.rotationX = 0,
      this.rotationY = 0,
      this.rotationZ = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(rotationX * degrees2Radians)
        ..rotateY(rotationY * degrees2Radians)
        ..rotateZ(rotationZ * degrees2Radians),
      child: child,
    );
  }
}

class _RenderItem extends StatelessWidget {
  const _RenderItem(
    this.offset, {
    Key? key,
    this.cardWidth = 250,
    required this.item,
    this.cardHeight,
    this.color,
    this.length = 0,
  }) : super(key: key);
  final double offset;
  final double? cardWidth;
  final double? cardHeight;
  final dynamic item;
  final Color? color;
  final int length;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return SizedBox(
      width: length == 1 ? context.widthPx : cardWidth,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          EvContainer(
            margin: EdgeInsets.only(
              top: 30,
              left: length == 1 ? 0 : 12,
              right: length == 1 ? 0 : 12,
              bottom: 12,
            ),
            color: ColorHelper.shiftHsl(color!, .1),
            borderRadius: Corners.s5Border,
            shadows: Shadows.m(theme.grey, .1),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(Insets.l),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            EvContainer(
                              height: 30,
                              width: 30,
                              color: color,
                              borderRadius: Corners.s5Border,
                              shadows: Shadows.m(color!, .1),
                            ),
                            HSpace.sm,
                            Text(
                              'Some title',
                              style: TextStyles.body1.bold
                                  .textColor(theme.surface),
                            ),
                          ],
                        ),
                        const Spacer(flex: 6),
                        Text(
                          'Some more title',
                          style: TextStyles.h6.textColor(theme.background),
                        ),
                        const Spacer(flex: 2),
                        Row(
                          children: [
                            Text(
                              '₦ ',
                              style: TextStyles.h4
                                  .textColor(theme.background)
                                  .copyWith(fontFamily: ''),
                            ),
                            Text(
                              'Some Extra',
                              style: TextStyles.h5.textColor(theme.background),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                EvContainer(
                  height: double.infinity,
                  width: 70,
                  color: color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      VSpace.md,
                      EvIcBtn(
                        EvSvgIc(R.I.add.svgT, color: theme.surface),
                      ),
                      const Spacer(flex: 1),
                      EvIcBtn(
                        EvSvgIc(R.I.settings.svgT, color: theme.surface),
                      ),
                      VSpace.md,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
