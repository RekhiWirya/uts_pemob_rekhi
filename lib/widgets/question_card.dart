import 'package:flutter/material.dart';

import '../utils/responsive.dart';


class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.scale(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(12),
                vertical: context.scale(4),
              ),
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(context.scale(20)),
              ),
              child: Text(
                'Pertanyaan $number',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: scheme.onPrimaryContainer,
                ),
              ),
            ),
            SizedBox(height: context.scale(16)),
            Text(text, style: theme.textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}