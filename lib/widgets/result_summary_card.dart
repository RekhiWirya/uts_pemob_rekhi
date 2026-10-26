
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class ResultSummaryCard extends StatelessWidget {
  const ResultSummaryCard({
    super.key,
    required this.userName,
    required this.score,
    required this.totalQuestions,
    required this.scorePercent,
    required this.title,
    required this.message,
  });

  final String userName;
  final int score;
  final int totalQuestions;
  final double scorePercent;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final gap = context.scale(16);
    final wrongCount = totalQuestions - score;

    final IconData badgeIcon;
    if (scorePercent >= 80) {
      badgeIcon = Icons.emoji_events_rounded;
    } else if (scorePercent >= 50) {
      badgeIcon = Icons.stars_rounded;
    } else {
      badgeIcon = Icons.videogame_asset_rounded;
    }

    final isGold = scorePercent == 100;

    final badgeDecoration = isGold
        ? const BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [
          AppColors.psPlusGoldStart,
          AppColors.psPlusGoldMid,
          AppColors.psPlusGoldEnd,
        ],
      ),
    )
        : const BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.primary,
    );

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(context.scale(8)),
        border: Border.all(color: scheme.outline),
      ),
      padding: EdgeInsets.all(context.scale(24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.scale(80),
            height: context.scale(80),
            alignment: Alignment.center,
            decoration: badgeDecoration,
            child: Icon(
              badgeIcon,
              size: context.scale(42),
              color: AppColors.canvasLight,
            ),
          ),
          SizedBox(height: gap),
          Text(
            userName.isNotEmpty ? 'Hasil Kuis, $userName!' : 'Hasil Kuis!',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: context.scale(16),
              fontWeight: FontWeight.w400,
              color: scheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: gap * 0.25),
          Text(
            title,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: context.scale(35),
              fontWeight: FontWeight.w300,
              height: 1.25,
              color: scheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: gap * 0.5),
          Text(
            message,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: context.scale(16),
              fontWeight: FontWeight.w400,
              color: scheme.onSurfaceVariant,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: gap * 1.25),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(24),
              vertical: context.scale(16),
            ),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(context.scale(8)),
              border: Border.all(color: scheme.outline),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${scorePercent.round()}%',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: context.scale(35),
                    fontWeight: FontWeight.w300,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: gap),
                Container(
                  width: 1,
                  height: context.scale(36),
                  color: scheme.outline,
                ),
                SizedBox(width: gap),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Skor Akhir',
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: context.scale(14),
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '$score / $totalQuestions Soal',
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: context.scale(16),
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: gap * 1.25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatBadge(
                icon: Icons.check_circle_rounded,
                label: '$score Benar',
                bgColor: AppColors.primary,
                textColor: AppColors.canvasLight,
              ),
              SizedBox(width: gap * 0.75),
              _StatBadge(
                icon: Icons.cancel_rounded,
                label: '$wrongCount Salah',
                bgColor: AppColors.warning,
                textColor: AppColors.canvasLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  const _StatBadge({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  final IconData icon;
  final String label;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(14),
        vertical: context.scale(6),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: context.scale(16),
            color: textColor,
          ),
          SizedBox(width: context.scale(6)),
          Text(
            label,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: context.scale(12),
              fontWeight: FontWeight.w700,
              color: textColor,
              letterSpacing: 0.32,
            ),
          ),
        ],
      ),
    );
  }
}
