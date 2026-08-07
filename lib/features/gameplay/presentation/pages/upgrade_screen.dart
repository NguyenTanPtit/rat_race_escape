import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:rat_race_escape/core/format/money_format.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/course_config.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_button.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_card.dart';

/// Upgrade screen: courses that permanently raise the salary — the weapon
/// against prices growing faster than pay.
class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameEngineCubit, GameEngineState>(
      builder: (context, state) {
        if (state is! GameEnginePlaying) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final gameState = state.gameState;
        final enabled = !state.isAutoAdvancing;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.l),
                  child: Row(
                    children: [
                      GameButton(
                        onPressed: () => context.pop(),
                        fill: AppColors.cardFill,
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.arrow_back, color: AppColors.ink),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.m),
                      Text('NÂNG CẤP', style: AppTextStyles.h2),
                      const SizedBox(width: AppSpacing.s),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            MoneyFormat.format(gameState.cash),
                            style: AppTextStyles.h3.copyWith(color: AppColors.primaryDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                        AppSpacing.l, 0, AppSpacing.l, AppSpacing.xl),
                    children: [
                      _SalaryCard(gameState: gameState),
                      const SizedBox(height: AppSpacing.l),
                      for (final course in gameState.courses) ...[
                        _CourseCard(
                            gameState: gameState, course: course, enabled: enabled),
                        const SizedBox(height: AppSpacing.l),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SalaryCard extends StatelessWidget {
  final GameState gameState;

  const _SalaryCard({required this.gameState});

  @override
  Widget build(BuildContext context) {
    final salaryPercent = (gameState.salaryGrowthAnnualRate * 100).toStringAsFixed(1);
    final pricePercent = (gameState.inflationAnnualRate * 100).toStringAsFixed(1);
    final hasGap = gameState.inflationAnnualRate > gameState.salaryGrowthAnnualRate;

    return GameCard(
      fill: AppColors.cardFill,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('💼 Lương của bạn', style: AppTextStyles.h3),
            const SizedBox(height: AppSpacing.s),
            Text(
              '${MoneyFormat.format(gameState.baseSalary)}/tháng',
              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            if (gameState.inflationAnnualRate > 0) ...[
              const SizedBox(height: 2),
              Text(
                'Lương tăng $salaryPercent%/năm • vật giá tăng $pricePercent%/năm',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.disabledInk),
              ),
              if (hasGap) ...[
                const SizedBox(height: 2),
                Text(
                  'Đứng yên là tụt lại — khóa học là cách kéo lương vượt vật giá.',
                  style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.disabledInk, fontStyle: FontStyle.italic),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final GameState gameState;
  final CourseConfig course;
  final bool enabled;

  const _CourseCard(
      {required this.gameState, required this.course, required this.enabled});

  @override
  Widget build(BuildContext context) {
    final cost = gameState.courseCost(course);
    final boostPercent = (course.salaryBoostRate * 100).toStringAsFixed(0);
    final isCompleted = gameState.completedCourseIds.contains(course.id);
    final isStudyingThis = gameState.studyingCourseId == course.id;
    final isStudyingOther =
        gameState.studyingCourseId != null && !isStudyingThis;
    final canAfford = gameState.cash >= cost;

    return GameCard(
      fill: AppColors.cardFill,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text('📚 ${course.name}', style: AppTextStyles.h3)),
                if (isCompleted)
                  Text('🎓 Đã tốt nghiệp',
                      style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: AppSpacing.s),
            Text(
              'Lương +$boostPercent% vĩnh viễn sau khi tốt nghiệp',
              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              'Học ${course.durationMonths} tháng • +${course.stressPerMonth} stress mỗi tháng học',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.disabledInk),
            ),
            if (!isCompleted) ...[
              const SizedBox(height: 2),
              Text(
                'Học phí: ${MoneyFormat.format(cost)}'
                '${gameState.inflationIndex > 1.0 ? ' (đã tăng theo vật giá — học sớm rẻ hơn)' : ''}',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.disabledInk),
              ),
            ],
            const SizedBox(height: AppSpacing.m),
            if (isStudyingThis)
              Text(
                '✏️ Đang học — còn ${gameState.studyingMonthsLeft} tháng',
                style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryDark, fontWeight: FontWeight.bold),
              )
            else if (!isCompleted) ...[
              if (isStudyingOther)
                Text(
                  'Đang bận khóa khác — mỗi lúc chỉ học được một khóa.',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.disabledInk),
                )
              else if (!canAfford)
                Text(
                  'Chưa đủ tiền mặt.',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.stressHigh),
                ),
              if (isStudyingOther || !canAfford) const SizedBox(height: AppSpacing.s),
              GameButton(
                onPressed: (enabled && !isStudyingOther && canAfford)
                    ? () => _confirmStartCourse(context, gameState, course)
                    : null,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text('Đăng ký học',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

void _confirmStartCourse(
    BuildContext context, GameState gameState, CourseConfig course) {
  final cubit = context.read<GameEngineCubit>();
  final cost = gameState.courseCost(course);
  final boostPercent = (course.salaryBoostRate * 100).toStringAsFixed(0);

  showDialog(
    context: context,
    builder: (dialogContext) => Dialog(
      backgroundColor: Colors.transparent,
      child: GameCard(
        fill: AppColors.cardFill,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('📚 ${course.name}', style: AppTextStyles.h3),
              const SizedBox(height: AppSpacing.m),
              Text(
                'Đóng ${MoneyFormat.format(cost)} một lần, học ${course.durationMonths} tháng '
                '(+${course.stressPerMonth} stress/tháng). Tốt nghiệp: lương +$boostPercent% vĩnh viễn.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.l),
              Row(
                children: [
                  Expanded(
                    child: GameButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      fill: AppColors.navFill,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text('Để sau',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: AppColors.ink)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(
                    child: GameButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        cubit.startCourse(course.id);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text('Học ngay',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
