import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

//Requires the animations package

typedef PageBuilder = Widget Function();

class RouteHelper {
  static const double kDuration = .35;
  static const Curve kEaseFwd = Curves.easeOut;
  static const Curve kEaseReverse = Curves.easeOut;

  static Route<T> fade<T>(PageBuilder builder, [double dur = kDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (dur * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => builder(),
      maintainState: true,
      opaque: true,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Route<T> fadeThrough<T>(PageBuilder builder, [double dur = kDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (dur * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => builder(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child);
      },
    );
  }

  static Route<T> fadeScale<T>(PageBuilder builder,
      [double dur = kDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (dur * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => builder(),
      opaque: true,
      maintainState: true,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(
          animation: animation,
          child: Overlay(
            initialEntries: [
              OverlayEntry(builder: (context) => child),
            ],
          ),
        );
      },
    );
  }

  static Route<T> sharedAxis<T>(PageBuilder builder,
      [SharedAxisTransitionType type = SharedAxisTransitionType.scaled,
      double duration = kDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => builder(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: type,
        );
      },
    );
  }

  static Route<T> slide<T>(PageBuilder builder,
      {double duration = kDuration,
      Offset startOffset = const Offset(1, 0),
      Curve easeFwd = kEaseFwd,
      Curve easeReverse = kEaseReverse}) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => builder(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        bool reverse = animation.status == AnimationStatus.reverse;
        return SlideTransition(
          position: Tween<Offset>(begin: startOffset, end: const Offset(0, 0))
              .animate(CurvedAnimation(
                  parent: animation, curve: reverse ? easeReverse : easeFwd)),
          child: child,
        );
      },
    );
  }
}
