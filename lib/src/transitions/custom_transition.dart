import 'package:flutter/material.dart';

typedef CustomTransitionBuilder = Widget Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    );

class CustomTransitionPage extends PageRouteBuilder {
  final Widget page;
  final CustomTransitionBuilder transitionsBuilder;

  CustomTransitionPage({
    required this.page,
    required this.transitionsBuilder,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return transitionsBuilder(
        context,
        animation,
        secondaryAnimation,
        child,
      );
    },
    transitionDuration: duration,
  );
}