import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/foundation.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/game_state_repository.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  bool _hasSavedGame = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkSavedGame();
  }

  Future<void> _checkSavedGame() async {
    try {
      final repo = GetIt.I<GameStateRepository>();
      final hasSave = await repo.hasSavedGame();
      if (mounted) {
        setState(() {
          _hasSavedGame = hasSave;
          _isLoading = false;
        });
      }
    } catch (e, st) {
      debugPrint('Error in _checkSavedGame: $e\n$st');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _startNewGame() async {
    setState(() => _isLoading = true);
    await context.read<GameEngineCubit>().startNewGame(Country.vietnam, 'vn_provincial');
    if (mounted) {
      setState(() => _isLoading = false);
      context.go('/main');
    }
  }

  Future<void> _continueGame() async {
    await context.read<GameEngineCubit>().loadGame();
    if (mounted) {
      context.go('/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.appTitle,
                    style: AppTextStyles.h1.copyWith(color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  
                  Text(AppLocalizations.of(context)!.selectCountry),
                  const DropdownMenu<Country>(
                    initialSelection: Country.vietnam,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: Country.vietnam, label: 'Việt Nam'),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.l),

                  Text(AppLocalizations.of(context)!.selectContext),
                  const DropdownMenu<String>(
                    initialSelection: 'default',
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 'default', label: 'Thành phố'),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  if (_hasSavedGame) ...[
                    ElevatedButton(
                      onPressed: _continueGame,
                      child: Text(AppLocalizations.of(context)!.btnContinueGame),
                    ),
                    const SizedBox(height: AppSpacing.l),
                  ],
                  
                  ElevatedButton(
                    onPressed: _startNewGame,
                    child: Text(AppLocalizations.of(context)!.btnNewGame),
                  ),
                ],
              ),
            ),
            if (kDebugMode)
              Positioned(
                top: AppSpacing.m,
                right: AppSpacing.m,
                child: TextButton.icon(
                  onPressed: () => context.push('/gallery'),
                  icon: const Text('🎨'),
                  label: const Text('Gallery'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.ink,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
