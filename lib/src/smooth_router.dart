import 'package:flutter/material.dart';

import '../smooth_router_page.dart';

class SmoothRouter {
  static final SmoothRouter _instance = SmoothRouter._internal();
  factory SmoothRouter() => _instance;
  SmoothRouter._internal();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  static Future<T?> push<T>(
    Widget page, {
    RouteTransitions transition = RouteTransitions.slideRight,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    bool replace = false,
    bool clearStack = false,
  }) {
    final route = _createRoute<T>(
      page,
      transition: transition,
      duration: duration,
      curve: curve,
    );

    if (clearStack) {
      return navigatorKey.currentState!.pushAndRemoveUntil<T>(
        route,
        (route) => false,
      );
    } else if (replace) {
      return navigatorKey.currentState!.pushReplacement<T, T>(route);
    } else {
      return navigatorKey.currentState!.push<T>(route);
    }
  }

  static void pop<T>([T? result]) {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop<T>(result);
    }
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  static bool get canPop => navigatorKey.currentState!.canPop();

  static PageRouteBuilder<T> _createRoute<T>(
    Widget page, {
    required RouteTransitions transition,
    required Duration duration,
    required Curve curve,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SmoothRouterPage.createTransition(
          context: context,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
          transition: transition,
          duration: duration,
          curve: curve,
        );
      },
      transitionDuration: duration,
    );
  }

  // Quick navigation methods
  static Future<T?> fade<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return push<T>(page, transition: RouteTransitions.fade, duration: duration);
  }

  static Future<T?> slide<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.right,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    // Fixed the slide direction mapping
    final transition = _getSlideTransition(direction);
    return push<T>(page, transition: transition, duration: duration);
  }

  static Future<T?> scale<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return push<T>(
      page,
      transition: RouteTransitions.scale,
      duration: duration,
    );
  }

  // Helper method to get the correct slide transition
  static RouteTransitions _getSlideTransition(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.right:
        return RouteTransitions.slideRight;
      case SlideDirection.left:
        return RouteTransitions.slideLeft;
      case SlideDirection.up:
        return RouteTransitions.slideUp;
      case SlideDirection.down:
        return RouteTransitions.slideDown;
    }
  }
}

enum RouteTransitions {
  fade,
  slideRight,
  slideLeft,
  slideUp,
  slideDown,
  scale,
  custom,
}

enum SlideDirection { right, left, up, down }
