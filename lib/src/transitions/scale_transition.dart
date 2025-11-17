import 'package:flutter/material.dart';

class ScaleTransitionPage extends PageRouteBuilder {
  final Widget page;

  ScaleTransitionPage({
    required this.page,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: curve,
        ),
        child: child,
      );
    },
    transitionDuration: duration,
  );
}