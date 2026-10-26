
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/feedback_banner.dart';
import '../widgets/option_tile.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_progress_bar.dart';
import '../widgets/responsive_container.dart';
import '../widgets/theme_toggle_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  static const double _wideMaxWidth = 1000;

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final question = quiz.currentQuestion;
    final gap = context.scale(16);

    // Dua kolom pada layar landscape, tablet, dan desktop.
    final isWide = context.isLandscape || context.isDesktop;

    // Bagian atas: progres dan kartu soal.
    final header = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        QuizProgressBar(
          current: quiz.currentIndex + 1,
          total: quiz.totalQuestions,
        ),
        SizedBox(height: gap * 1.25),
        QuestionCard(
          number: quiz.currentIndex + 1,
          text: question.text,
        ),
      ],
    );

    // Bagian pilihan jawaban dan tombol navigasi.
    final answers = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < question.options.length; i++) ...[
          OptionTile(
            index: i,
            text: question.options[i],
            state: _stateFor(
              i,
              question.correctIndex,
              quiz.selectedAnswer,
            ),
            onTap: quiz.isCurrentAnswered
                ? null
                : () => context.read<QuizProvider>().selectAnswer(i),
          ),
          SizedBox(height: gap * 0.75),
        ],
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          alignment: Alignment.topCenter,
          child: quiz.isCurrentAnswered
              ? Padding(
            padding: EdgeInsets.only(bottom: gap),
            child: FeedbackBanner(
              isCorrect: quiz.isCurrentCorrect,
              explanation: question.explanation,
            ),
          )
              : const SizedBox(width: double.infinity),
        ),
        CustomButton(
          label: quiz.isLastQuestion ? 'Lihat Hasil' : 'Soal Berikutnya',
          icon: quiz.isLastQuestion
              ? Icons.flag_rounded
              : Icons.arrow_forward_rounded,
          onPressed: !quiz.isCurrentAnswered
              ? null
              : quiz.isLastQuestion
              ? () => _finish(context)
              : quiz.nextQuestion,
        ),
      ],
    );

    return PopScope(
      canPop: quiz.answeredCount == 0,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final leave = await _confirmExit(context);

        if (leave == true && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kuis Musik'),
          actions: const [
            ThemeToggleButton(),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            key: ValueKey(quiz.currentIndex),
            child: ResponsiveContainer(
              maxWidth: isWide
                  ? _wideMaxWidth
                  : Responsive.maxContentWidth,
              child: isWide
                  ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: header),
                  SizedBox(width: gap * 2),
                  Expanded(child: answers),
                ],
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  header,
                  SizedBox(height: gap * 1.25),
                  answers,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static OptionState _stateFor(
      int index,
      int correctIndex,
      int? selected,
      ) {
    if (selected == null) return OptionState.idle;
    if (index == correctIndex) return OptionState.correct;
    if (index == selected) return OptionState.wrong;
    return OptionState.dimmed;
  }

  static Future<bool?> _confirmExit(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text('Progres kuismu akan hilang.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Lanjut'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  static void _finish(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const ResultScreen(),
      ),
    );
  }
}
