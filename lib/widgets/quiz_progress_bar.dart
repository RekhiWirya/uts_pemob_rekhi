import 'package:flutter/material.dart';

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
    final value = current / total;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text('Soal $current dari $total', style: theme.textTheme.titleMedium),
            const Spacer(),
            Text(
              '${(value * 100).round()}%',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        SizedBox(height: context.scale(8)),
        ClipRRect(
          borderRadius: BorderRadius.circular(context.scale(8)),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: value),
            duration: const Duration(milliseconds: 300),
            builder: (context, animated, _) => LinearProgressIndicator(
              value: animated,
              minHeight: context.scale(8),
              color: scheme.primary,
              backgroundColor: scheme.surfaceContainerHighest,
            ),
          ),
        ),
      ],
    );
  }
}