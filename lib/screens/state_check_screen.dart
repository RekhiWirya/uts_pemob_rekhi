import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';


class StateCheckScreen extends StatelessWidget {
  const StateCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final theme = Theme.of(context);
    final question = quiz.currentQuestion;
    final gap = context.scale(16);

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Check'),
        actions: [
          IconButton(
            tooltip: 'Ganti tema',
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () =>
                context.read<ThemeProvider>().toggle(theme.brightness),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints:
            const BoxConstraints(maxWidth: Responsive.maxContentWidth),
            child: ListView(
              padding: EdgeInsets.all(context.scale(20)),
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: 'Masukkan nama'),
                  onChanged: (value) =>
                      context.read<QuizProvider>().setUserName(value),
                ),
                SizedBox(height: gap / 2),
                Text(
                  'Halo, ${quiz.userName.isEmpty ? '-' : quiz.userName}',
                  style: theme.textTheme.bodyLarge,
                ),
                SizedBox(height: gap * 1.5),
                Text(
                  'Soal ${quiz.currentIndex + 1} dari ${quiz.totalQuestions}',
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: gap / 2),
                Text(question.text, style: theme.textTheme.headlineSmall),
                SizedBox(height: gap),
                for (var i = 0; i < question.options.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: gap / 2),
                    child: OutlinedButton(
                      onPressed:
                      quiz.isCurrentAnswered ? null : () => quiz.selectAnswer(i),
                      child: Text(question.options[i]),
                    ),
                  ),
                if (quiz.isCurrentAnswered)
                  Text(
                    quiz.isCurrentCorrect
                        ? 'Benar ✔'
                        : 'Salah ✘ (jawaban benar: ${question.options[question.correctIndex]})',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: quiz.isCurrentCorrect
                          ? AppColors.success
                          : AppColors.error,
                    ),
                  ),
                SizedBox(height: gap),
                Text(
                  'Skor: ${quiz.score} / ${quiz.totalQuestions}  •  Terjawab: ${quiz.answeredCount}',
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: gap),
                FilledButton(
                  onPressed: quiz.isCurrentAnswered && !quiz.isLastQuestion
                      ? quiz.nextQuestion
                      : null,
                  child: const Text('Soal berikutnya'),
                ),
                SizedBox(height: gap / 2),
                OutlinedButton(
                  onPressed: quiz.restart,
                  child: const Text('Ulangi kuis'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}