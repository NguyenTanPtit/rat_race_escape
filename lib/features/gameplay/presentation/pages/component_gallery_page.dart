import 'package:flutter/material.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/bottom_nav.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/end_turn_button.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_button.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_card.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/money_display.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/sketchy_game_card.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/stat_bar.dart';

class ComponentGalleryPage extends StatelessWidget {
  const ComponentGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Gallery'),
        backgroundColor: AppColors.cardFill,
        foregroundColor: AppColors.ink,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: AppColors.ink, height: 2),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.l),
        children: [
          _buildSection('1. Game Cards (v1) - Spacing Demo', [
            const Text('Demonstrating padding/margins on parent to avoid shadow clipping.'),
            const SizedBox(height: AppSpacing.m),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    // Padding specifically added to the right and bottom to accommodate shadow
                    padding: const EdgeInsets.only(right: AppSpacing.s, bottom: AppSpacing.s),
                    child: GameCard(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.m),
                        child: Text('Card 1', style: AppTextStyles.bodyMedium),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.s),
                    child: GameCard(
                      shadowColor: AppColors.shadowVariantDark,
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.m),
                        child: Text('Card 2 (Black shadow)', style: AppTextStyles.bodyMedium),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
          const SizedBox(height: AppSpacing.xl),
          
          _buildSection('2. Game Cards (v2) - Sketchy Borders', [
            ...[123, 999, 42, 7, 2026, 888, 100, 50].map((seed) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s, right: AppSpacing.s),
              child: SketchyGameCard(
                seed: seed,
                shadowColor: seed % 2 == 0 ? AppColors.shadowVariantDark : AppColors.shadowVariantInk,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.m),
                  child: Text('Sketchy Card Seed $seed', style: AppTextStyles.bodyMedium),
                ),
              ),
            )),
            const SizedBox(height: AppSpacing.m),
          ]),
          const SizedBox(height: AppSpacing.xl),

          _buildSection('3. Game Buttons', [
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s, right: AppSpacing.s),
              child: GameButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.m, horizontal: AppSpacing.l),
                  child: Center(
                    child: Text('Normal Action', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.cardFill)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s, right: AppSpacing.s),
              child: GameButton(
                onPressed: null, // Disabled
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.m, horizontal: AppSpacing.l),
                  child: Center(
                    child: Text('Disabled Action', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.disabledInk)),
                  ),
                ),
              ),
            ),
          ]),
          const SizedBox(height: AppSpacing.xl),

          _buildSection('4. StatBars', [
            const StatBar(label: 'Stress (Biên 0)', emoji: '🤯', value: 0, type: StatType.stress),
            const SizedBox(height: AppSpacing.m),
            const StatBar(label: 'Stress (Biên 1)', emoji: '🤯', value: 1, type: StatType.stress),
            const SizedBox(height: AppSpacing.m),
            const StatBar(label: 'Stress (Thấp)', emoji: '🤯', value: 20, type: StatType.stress),
            const SizedBox(height: AppSpacing.m),
            const StatBar(label: 'Stress (Trung bình)', emoji: '🤯', value: 50, type: StatType.stress),
            const SizedBox(height: AppSpacing.m),
            const StatBar(label: 'Stress (Cao)', emoji: '🤯', value: 90, type: StatType.stress),
            const SizedBox(height: AppSpacing.m),
            const StatBar(label: 'Stress (Biên 100)', emoji: '🤯', value: 100, type: StatType.stress),
            const SizedBox(height: AppSpacing.l),
            const StatBar(label: 'Quan hệ', emoji: '🤝', value: 40, type: StatType.network),
          ]),
          const SizedBox(height: AppSpacing.xl),

          _buildSection('5. Money Displays', [
            const MoneyDisplay(label: 'Tiền mặt', amount: 15000000, cashflow: 500000),
            const SizedBox(height: AppSpacing.l),
            const MoneyDisplay(label: 'Nợ xấu', amount: -20000000, cashflow: -1000000),
            const SizedBox(height: AppSpacing.l),
            const MoneyDisplay(label: 'Tài sản', amount: 1250000000, cashflow: 0),
          ]),
          _buildSection('6. EndTurnButton (80x80)', [
            Container(
              color: const Color(0xFFF3FCEF), // Nav background
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('Normal', style: TextStyle(color: AppColors.ink)),
                      const SizedBox(height: AppSpacing.s),
                      EndTurnButton(onPressed: () {}),
                    ],
                  ),
                  const Column(
                    children: [
                      Text('Disabled', style: TextStyle(color: AppColors.ink)),
                      SizedBox(height: AppSpacing.s),
                      EndTurnButton(onPressed: null),
                    ],
                  ),
                ],
              ),
            ),
          ]),
          const SizedBox(height: AppSpacing.xl),

          _buildSection('7. BottomNav + EndTurnButton (Docked)', [
            SizedBox(
              height: 120,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const BottomNav(),
                  Positioned(
                    bottom: 24, // Docked vertically overlapping
                    child: EndTurnButton(onPressed: () {}),
                  ),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: AppTextStyles.h2),
        const SizedBox(height: AppSpacing.m),
        ...children,
      ],
    );
  }
}
