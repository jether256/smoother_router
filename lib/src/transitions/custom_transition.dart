import 'package:flutter/material.dart';

typedef CustomTransitionBuilder = Widget Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    );

class CustomTransitionPage extends PageRouteBuilder {
  @override
  final CustomTransitionBuilder transitionsBuilder;

  CustomTransitionPage({
    required super.pageBuilder,
    required this.transitionsBuilder,
    super.transitionDuration = const Duration(milliseconds: 300),
    super.reverseTransitionDuration,
    super.opaque = true,
    super.barrierDismissible = false,
    super.barrierColor,
    super.barrierLabel,
    super.maintainState = true,
    super.fullscreenDialog = false,
    super.settings,
  }) : super(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return transitionsBuilder(context, animation, secondaryAnimation, child);
    },
  );
}