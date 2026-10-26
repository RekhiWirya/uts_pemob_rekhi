import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class QuizProgressBar extends StatelessWidget {
  const QuizProgressBar({
    super.key,
    required this.current,
    required this.total,
  });

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final value = total > 0 ? (current / total) : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              'Soal $current dari $total',
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: context.scale(16),
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            const Spacer(),
            Text(
              '${(value * 100).round()}%',
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: context.scale(14),
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: context.scale(8)),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999), // Fully rounded pill
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: value),
            duration: const Duration(milliseconds: 300),
            builder: (context, animated, _) => LinearProgressIndicator(
              value: animated,
              minHeight: context.scale(8),
              color: AppColors.primary,
              backgroundColor: AppColors.surfaceSoft,
            ),
          ),
        ),
      ],
    );
  }
}