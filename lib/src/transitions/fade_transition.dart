import 'package:flutter/material.dart';

class FadeTransitionPage extends PageRouteBuilder {
  final Widget page;

  FadeTransitionPage({
    required this.page,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: curve,
        ),
        child: child,
      );
    },
    transitionDuration: duration,
  );
}