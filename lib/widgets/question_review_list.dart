import 'package:flutter/material.dart';

import '../models/question.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';

class QuestionReviewList extends StatelessWidget {
  const QuestionReviewList({
    super.key,
    required this.questions,
    required this.answers,
  });

  final List<Question> questions;
  final List<int?> answers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gap = context.scale(12);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.scale(8)),
          child: Text(
            'Rincian Jawaban',
            style: theme.textTheme.titleLarge,
          ),
        ),
        SizedBox(height: gap * 0.5),
        for (var i = 0; i < questions.length; i++) ...[
          _QuestionReviewTile(
            number: i + 1,
            question: questions[i],
            selectedAnswer: answers.length > i ? answers[i] : null,
          ),
          SizedBox(height: gap),
        ],
      ],
    );
  }
}

class _QuestionReviewTile extends StatelessWidget {
  const _QuestionReviewTile({
    required this.number,
    required this.question,
    required this.selectedAnswer,
  });

  final int number;
  final Question question;
  final int? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final gap = context.scale(12);

    final isCorrect = selectedAnswer == question.correctIndex;
    final statusColor = isCorrect ? AppColors.success : AppColors.error;
    final statusIcon = isCorrect ? Icons.check_circle : Icons.cancel;
    final statusText = isCorrect ? 'Benar' : 'Salah';

    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.scale(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.scale(10),
                    vertical: context.scale(4),
                  ),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(context.scale(12)),
                  ),
                  child: Text(
                    'Soal $number',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.scale(10),
                    vertical: context.scale(4),
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(context.scale(12)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        size: context.scale(16),
                        color: statusColor,
                      ),
                      SizedBox(width: context.scale(4)),
                      Text(
                        statusText,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: gap),
            Text(
              question.text,
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: gap),

            // User's answer display
            _AnswerBox(
              label: 'Jawaban Kamu',
              text: selectedAnswer != null
                  ? question.options[selectedAnswer!]
                  : 'Tidak dijawab',
              color: statusColor,
              icon: statusIcon,
            ),

            // Correct answer display if user was wrong
            if (!isCorrect) ...[
              SizedBox(height: gap * 0.5),
              _AnswerBox(
                label: 'Jawaban Benar',
                text: question.options[question.correctIndex],
                color: AppColors.success,
                icon: Icons.check_circle_outline,
              ),
            ],

            // Explanation section if available
            if (question.explanation != null &&
                question.explanation!.isNotEmpty) ...[
              SizedBox(height: gap * 0.75),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(context.scale(12)),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(context.scale(12)),
                  border: Border.all(
                    color: scheme.outline.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      size: context.scale(18),
                      color: scheme.primary,
                    ),
                    SizedBox(width: context.scale(8)),
                    Expanded(
                      child: Text(
                        question.explanation!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AnswerBox extends StatelessWidget {
  const _AnswerBox({
    required this.label,
    required this.text,
    required this.color,
    required this.icon,
  });

  final String label;
  final String text;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(12),
        vertical: context.scale(8),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(context.scale(10)),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(icon, size: context.scale(18), color: color),
          SizedBox(width: context.scale(8)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  TextSpan(
                    text: text,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}