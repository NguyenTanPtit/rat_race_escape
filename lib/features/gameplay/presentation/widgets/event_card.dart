import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_event.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/game_card.dart';

class EventCard extends StatelessWidget {
  final GameEvent event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return GameCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              event.title,
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              event.description,
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.l),
            ...event.options.map((option) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s),
              child: ElevatedButton(
                onPressed: () {
                  context.read<GameEngineCubit>().chooseEventOption(event.id, option.id);
                },
                child: Text(option.label),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
