
import 'package:flutter/material.dart';

import '../models/question.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
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
    final gap = context.scale(12);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.scale(8)),
          child: Text(
            'Rincian Jawaban',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: context.scale(22),
              fontWeight: FontWeight.w300,
              color: Theme.of(context).colorScheme.onSurface,
            ),
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
    final scheme = Theme.of(context).colorScheme;
    final gap = context.scale(12);
    final isCorrect = selectedAnswer == question.correctIndex;
    final statusColor = isCorrect ? AppColors.primary : AppColors.warning;
    final statusIcon =
    isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded;
    final statusLabel = isCorrect ? 'Benar' : 'Salah';

    final safeSelectedAnswer = selectedAnswer != null &&
        selectedAnswer! >= 0 &&
        selectedAnswer! < question.options.length
        ? question.options[selectedAnswer!]
        : 'Tidak dijawab';

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(context.scale(8)),
        border: Border.all(color: scheme.outline),
      ),
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
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'Soal $number',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: context.scale(12),
                    fontWeight: FontWeight.w600,
                    color: AppColors.canvasLight,
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
                  color: statusColor,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      size: context.scale(14),
                      color: AppColors.canvasLight,
                    ),
                    SizedBox(width: context.scale(4)),
                    Text(
                      statusLabel,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: context.scale(12),
                        fontWeight: FontWeight.w700,
                        color: AppColors.canvasLight,
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
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: context.scale(18),
              fontWeight: FontWeight.w300,
              color: scheme.onSurface,
            ),
          ),
          SizedBox(height: gap),
          _AnswerBox(
            label: 'Jawaban Kamu',
            text: safeSelectedAnswer,
            bgColor: statusColor.withValues(alpha: 0.10),
            textColor: statusColor,
            icon: statusIcon,
          ),
          if (!isCorrect) ...[
            SizedBox(height: gap * 0.5),
            _AnswerBox(
              label: 'Jawaban Benar',
              text: question.options[question.correctIndex],
              bgColor: AppColors.primary.withValues(alpha: 0.10),
              textColor: AppColors.primary,
              icon: Icons.check_circle_outline_rounded,
            ),
          ],
          if (question.explanation != null &&
              question.explanation!.isNotEmpty) ...[
            SizedBox(height: gap * 0.75),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.scale(12)),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(context.scale(8)),
                border: Border.all(color: scheme.outline),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    size: context.scale(18),
                    color: AppColors.primary,
                  ),
                  SizedBox(width: context.scale(8)),
                  Expanded(
                    child: Text(
                      question.explanation!,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: context.scale(14),
                        fontWeight: FontWeight.w400,
                        color: scheme.onSurface,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AnswerBox extends StatelessWidget {
  const _AnswerBox({
    required this.label,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.icon,
  });

  final String label;
  final String text;
  final Color bgColor;
  final Color textColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(12),
        vertical: context.scale(8),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(context.scale(8)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: context.scale(18),
            color: textColor,
          ),
          SizedBox(width: context.scale(8)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: context.scale(14),
                ),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: text,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
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
