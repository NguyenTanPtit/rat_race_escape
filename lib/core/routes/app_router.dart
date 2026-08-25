import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/component_gallery_page.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/new_game_screen.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/bank_screen.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/invest_screen.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/asset_screen.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/upgrade_screen.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/main_game_screen.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/game_over_screen.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/win_screen.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const NewGameScreen(),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) => const MainGameScreen(),
      ),
      GoRoute(
        path: '/invest',
        builder: (context, state) => const InvestScreen(),
      ),
      GoRoute(
        path: '/bank',
        builder: (context, state) => const BankScreen(),
      ),
      GoRoute(
        path: '/upgrade',
        builder: (context, state) => const UpgradeScreen(),
      ),
      GoRoute(
        path: '/assets',
        builder: (context, state) => const AssetScreen(),
      ),
      GoRoute(
        path: '/gameOver',
        builder: (context, state) {
          final engineState = context.read<GameEngineCubit>().state;
          if (engineState is GameEngineGameOver) {
            return GameOverScreen(
              reason: engineState.reason,
              finalState: engineState.finalState,
              newCards: engineState.newlyUnlockedInsightCardIds,
            );
          }
          return const Scaffold(body: Center(child: Text('Invalid State')));
        },
      ),
      GoRoute(
        path: '/win',
        builder: (context, state) {
          final engineState = context.read<GameEngineCubit>().state;
          if (engineState is GameEngineWon) {
            return WinScreen(
              finalState: engineState.finalState,
              newCards: engineState.newlyUnlockedInsightCardIds,
            );
          }
          return const Scaffold(body: Center(child: Text('Invalid State')));
        },
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
