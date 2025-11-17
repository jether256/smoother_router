import 'package:flutter/material.dart';
import 'package:smoother_router/smooth_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smooth Router Demo',
      navigatorKey: SmoothRouter.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smooth Router Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => SmoothRouter.slide(const NextPage()),
              child: const Text('Slide Transition'),
            ),
            ElevatedButton(
              onPressed: () => SmoothRouter.fade(const NextPage()),
              child: const Text('Fade Transition'),
            ),
            ElevatedButton(
              onPressed: () => SmoothRouter.scale(const NextPage()),
              child: const Text('Scale Transition'),
            ),
            ElevatedButton(
              onPressed: () {
                SmoothRouter.push(
                  const NextPage(),
                  transition: RouteTransitions.slideUp,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutBack,
                  replace: false, // Replace current page
                  clearStack: false, // Clear all previous page
                );
              },
              child: const Text('Custom Transition'),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => SmoothRouter.pop(),
        ),
      ),
      body: const Center(
        child: Text(
          'Smooth Transition!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}