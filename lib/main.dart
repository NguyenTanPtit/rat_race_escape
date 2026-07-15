import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:rat_race_escape/core/routes/app_router.dart';
import 'package:rat_race_escape/core/theme/app_theme.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';

import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();

  // Initialize GetIt (DI)
  await configureDependencies();
  
  runApp(const RatRaceEscapeApp());
}

class RatRaceEscapeApp extends StatelessWidget {
  const RatRaceEscapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rat Race Escape',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi'),
      ],
    );
  }
}