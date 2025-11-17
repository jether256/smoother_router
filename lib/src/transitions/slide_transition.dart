import 'package:flutter/material.dart';
import 'package:smoother_router/smooth_router.dart';

class SlideTransitionPage extends PageRouteBuilder {
  final Widget page;
  final SlideDirection direction;

  SlideTransitionPage({
    required this.page,
    this.direction = SlideDirection.right,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
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

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: duration,
  );
}