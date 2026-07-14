import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();

  // Initialize GetIt (DI)
  configureDependencies();
  
  runApp(const RatRaceEscapeApp());
}

class RatRaceEscapeApp extends StatelessWidget {
  const RatRaceEscapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rat Race Escape',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        // Sau này ta sẽ nhúng Google Fonts vào đây
      ),
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            'Rat Race Escape - Core Engine Init...',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}