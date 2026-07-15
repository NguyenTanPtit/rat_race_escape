import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';import 'package:go_router/go_router.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/component_gallery_page.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: kDebugMode ? '/gallery' : '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Main game screen placeholder'))), // TODO: Main game screen
      ),
      GoRoute(
        path: '/gallery',
        builder: (context, state) => const ComponentGalleryPage(),
        redirect: (context, state) {
          if (!kDebugMode) return '/'; // Guard
          return null;
        },
      ),
    ],
  );
}
