import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/responsive.dart';


class FeedbackBanner extends StatelessWidget {
  const FeedbackBanner({super.key, required this.isCorrect, this.explanation});

  final bool isCorrect;
  final String? explanation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = isCorrect ? AppColors.success : AppColors.error;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.scale(14)),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(context.scale(16)),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: accent,
            size: context.scale(24),
          ),
          SizedBox(width: context.scale(12)),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect ? 'Jawabanmu benar!' : 'Belum tepat',
                  style: theme.textTheme.titleMedium,
                ),
                if (explanation != null) ...[
                  SizedBox(height: context.scale(4)),
                  Text(explanation!, style: theme.textTheme.bodyMedium),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}