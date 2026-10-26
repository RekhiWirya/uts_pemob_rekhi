import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
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
    final List<Color> gradientColors;

    if (scorePercent >= 80) {
      badgeIcon = Icons.emoji_events_rounded;
      gradientColors = [scheme.primary, scheme.secondary];
    } else if (scorePercent >= 50) {
      badgeIcon = Icons.stars_rounded;
      gradientColors = [scheme.primary, AppColors.secondary];
    } else {
      badgeIcon = Icons.sentiment_satisfied_alt_rounded;
      gradientColors = [AppColors.primaryLight, scheme.primary];
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.scale(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Badge Icon
            Container(
              width: context.scale(80),
              height: context.scale(80),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors.first.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                badgeIcon,
                size: context.scale(42),
                color: Colors.white,
              ),
            ),
            SizedBox(height: gap),

            // User name & Title
            Text(
              userName.isNotEmpty ? 'Hasil Kuis, $userName!' : 'Hasil Kuis!',
              style: theme.textTheme.titleMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: gap * 0.25),
            Text(
              title,
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: gap * 0.5),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: gap * 1.25),

            // Score Display
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(24),
                vertical: context.scale(16),
              ),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(context.scale(16)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${scorePercent.round()}%',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.bold,
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
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '$score / $totalQuestions Soal',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: gap * 1.25),

            // Stat Chips Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StatChip(
                  icon: Icons.check_circle_rounded,
                  label: '$score Benar',
                  color: AppColors.success,
                ),
                SizedBox(width: gap * 0.75),
                _StatChip(
                  icon: Icons.cancel_rounded,
                  label: '$wrongCount Salah',
                  color: AppColors.error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(12),
        vertical: context.scale(6),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(context.scale(20)),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: context.scale(18), color: color),
          SizedBox(width: context.scale(6)),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}