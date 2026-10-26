
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

/// Kartu yang menampilkan teks pertanyaan.
class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.number,
    required this.text,
  });

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(context.scale(8)),
        border: Border.all(color: scheme.outline),
      ),
      padding: EdgeInsets.all(context.scale(24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge informasi dengan bentuk pill.
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(12),
              vertical: context.scale(4),
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              'Pertanyaan $number',
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: context.scale(12),
                fontWeight: FontWeight.w600,
                color: AppColors.canvasLight,
                letterSpacing: 0.3,
              ),
            ),
          ),
          SizedBox(height: context.scale(16)),
          Text(
            text,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: context.scale(22),
              fontWeight: FontWeight.w300,
              height: 1.25,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
