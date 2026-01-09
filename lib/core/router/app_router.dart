import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfsign/presentation/screens/welcome/welcome_screen.dart';

/// Application router configuration using go_router
class AppRouter {
  AppRouter._();

  /// Route paths
  static const String welcomePath = '/';

  /// Router instance
  static final GoRouter router = GoRouter(
    initialLocation: welcomePath,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: welcomePath,
        name: 'welcome',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const WelcomeScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.matchedLocation}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(welcomePath),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
