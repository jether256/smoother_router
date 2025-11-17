import 'package:flutter/material.dart';
import 'src/smooth_router.dart';

class SmoothRouterPage {
  static Widget createTransition({
    required BuildContext context,
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
    required RouteTransitions transition,
    required Duration duration,
    required Curve curve,
  }) {
    switch (transition) {
      case RouteTransitions.fade:
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: curve),
          child: child,
        );
      case RouteTransitions.slideRight:
        return _createSlideTransition(
          animation,
          curve,
          child,
          SlideDirection.right,
        );
      case RouteTransitions.slideLeft:
        return _createSlideTransition(
          animation,
          curve,
          child,
          SlideDirection.left,
        );
      case RouteTransitions.slideUp:
        return _createSlideTransition(
          animation,
          curve,
          child,
          SlideDirection.up,
        );
      case RouteTransitions.slideDown:
        return _createSlideTransition(
          animation,
          curve,
          child,
          SlideDirection.down,
        );
      case RouteTransitions.scale:
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: curve),
          child: child,
        );
      case RouteTransitions.custom:
        // For custom transitions, return the child and let user handle it
        return child;
    }
  }

  static Widget _createSlideTransition(
    Animation<double> animation,
    Curve curve,
    Widget child,
    SlideDirection direction,
  ) {
    const begin = {
      SlideDirection.right: Offset(1.0, 0.0),
      SlideDirection.left: Offset(-1.0, 0.0),
      SlideDirection.up: Offset(0.0, 1.0),
      SlideDirection.down: Offset(0.0, -1.0),
    };

    const end = Offset.zero;

    var tween = Tween(
      begin: begin[direction],
      end: end,
    ).chain(CurveTween(curve: curve));

    return SlideTransition(position: animation.drive(tween), child: child);
  }
}
