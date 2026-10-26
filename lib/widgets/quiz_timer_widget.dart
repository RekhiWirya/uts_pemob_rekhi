import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class QuizTimerWidget extends StatelessWidget {
  const QuizTimerWidget({
    super.key,
    required this.remainingSeconds,
    required this.progress,
    required this.isAnswered,
  });

  final int remainingSeconds;
  final double progress;
  final bool isAnswered;

  @override
  Widget build(BuildContext context) {
    final isWarning = remainingSeconds <= 3 && !isAnswered;
    final color = isAnswered
        ? AppColors.muteLight
        : (isWarning ? AppColors.warning : AppColors.primary);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scale(10),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(9999), // Fully rounded pill
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.timer_rounded,
                size: context.scale(20),
                color: color,
              ),
              SizedBox(width: context.scale(8)),
              Text(
                'Sisa Waktu:',
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: context.scale(14),
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              Text(
                '$remainingSeconds dtk',
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: context.scale(16),
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: context.scale(6)),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: context.scale(6),
              color: color,
              backgroundColor: AppColors.surfaceSoft,
            ),
          ),
        ],
      ),
    );
  }
}