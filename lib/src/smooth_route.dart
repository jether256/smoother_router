import 'package:flutter/material.dart';

import '../smooth_router.dart';

class SmoothRoute {
  final String path;
  final WidgetBuilder builder;
  final RouteTransitions transition;
  final Duration duration;
  final Curve curve;

  const SmoothRoute({
    required this.path,
    required this.builder,
    this.transition = RouteTransitions.slideRight,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });
}

class SmoothRouteGenerator {
  final List<SmoothRoute> routes;
  final Widget? notFoundPage;

  const SmoothRouteGenerator({
    required this.routes,
    this.notFoundPage,
  });

  Route<dynamic> generateRoute(RouteSettings settings) {
    final route = routes.firstWhere(
          (r) => r.path == settings.name,
      orElse: () => SmoothRoute(
        path: '/not-found',
        builder: (_) => notFoundPage ?? _DefaultNotFoundPage(),
      ),
    );

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          route.builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SmoothRouterPage.createTransition(
          context: context,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
          transition: route.transition,
          duration: route.duration,
          curve: route.curve,
        );
      },
      transitionDuration: route.duration,
    );
  }
}

class _DefaultNotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: const Center(
        child: Text('The requested page was not found.'),
      ),
    );
  }
}