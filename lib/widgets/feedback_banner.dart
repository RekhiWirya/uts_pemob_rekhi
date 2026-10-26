import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

/// Banner umpan balik setelah menjawab: benar/salah + penjelasan singkat.
class FeedbackBanner extends StatelessWidget {
  const FeedbackBanner({super.key, required this.isCorrect, this.explanation});

  final bool isCorrect;
  final String? explanation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final accent = isCorrect ? AppColors.primary : AppColors.warning;
    final bgColor = accent.withValues(alpha: 0.08);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(context.scale(8)), // 8px radius
        border: Border.all(color: accent),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: accent,
            size: context.scale(22),
          ),
          SizedBox(width: context.scale(12)),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect ? 'Jawabanmu benar!' : 'Belum tepat',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: context.scale(16),
                    fontWeight: FontWeight.w600,
                    color: accent,
                  ),
                ),
                if (explanation != null && explanation!.isNotEmpty) ...[
                  SizedBox(height: context.scale(4)),
                  Text(
                    explanation!,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: context.scale(14),
                      fontWeight: FontWeight.w400,
                      color: scheme.onSurface,
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}