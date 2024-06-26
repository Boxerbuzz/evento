import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvHScroll extends StatefulWidget {
  final Duration? autoScrollDuration;
  final Curve? autoScrollCurve;
  final Widget child;
  final ScrollPhysics? physics;

  const EvHScroll({
    this.autoScrollDuration,
    this.autoScrollCurve,
    required this.child,
    Key? key,
    this.physics,
  }) : super(key: key);

  @override
  State createState() => _EvHScrollState();
}

class _EvHScrollState extends State<EvHScroll> {
  late GlobalKey _childContainerKey;
  late GlobalKey _scrollViewKey;
  double _childWidth = 0.0;
  double _scrollWidth = 0.0;
  late ScrollController _scrollController;

  @override
  void initState() {
    _childContainerKey = GlobalKey();
    _scrollViewKey = GlobalKey();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  set childWidth(double width) {
    if (width != _childWidth) {
      // NOTE: CE: We are not setting the state here because we don't want to trigger a rebuild of the widget
      // _childWidth is not used for building, only as a cache value
      _childWidth = width;
      scrollQueryToEnd();
    }
  }

  set scrollWidth(double width) {
    if (width != _scrollWidth) {
      // NOTE: CE: We are not setting the state here because we don't want to trigger a rebuild of the widget
      // _scrollWidth is not used for building, only as a cache value
      _scrollWidth = width;
      scrollQueryToEnd();
    }
  }

  void scrollQueryToEnd() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: widget.autoScrollDuration ?? 500.milliseconds,
          curve: widget.autoScrollCurve ?? Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Hook into these sub-widgets and rebuild once they callback with their current size
    AppHelper.getFutureSizeFromGlobalKey(
        _childContainerKey, (size) => childWidth = size.width);
    AppHelper.getFutureSizeFromGlobalKey(
        _scrollViewKey, (size) => scrollWidth = size.width);

    return SingleChildScrollView(
      key: _scrollViewKey,
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      physics: widget.physics ?? const ClampingScrollPhysics(),
      child: Container(key: _childContainerKey, child: widget.child),
    );
  }
}
