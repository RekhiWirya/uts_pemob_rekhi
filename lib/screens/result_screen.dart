import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/question_review_list.dart';
import '../widgets/responsive_container.dart';
import '../widgets/result_summary_card.dart';
import '../widgets/theme_toggle_button.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  static const double _wideMaxWidth = 1000;

  void _restartQuiz(BuildContext context) {
    final quiz = context.read<QuizProvider>();
    quiz.restart();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  void _goHome(BuildContext context) {
    final quiz = context.read<QuizProvider>();
    quiz.restart();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final gap = context.scale(16);
    final isWide = context.isLandscape || context.isDesktop;

    final summaryCard = ResultSummaryCard(
      userName: quiz.userName,
      score: quiz.score,
      totalQuestions: quiz.totalQuestions,
      scorePercent: quiz.scorePercent,
      title: quiz.resultTitle,
      message: quiz.resultMessage,
    );

    final actionButtons = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomButton(
          label: 'Coba Lagi',
          icon: Icons.replay_rounded,
          onPressed: () => _restartQuiz(context),
        ),
        SizedBox(height: gap * 0.75),
        OutlinedButton.icon(
          onPressed: () => _goHome(context),
          icon: const Icon(Icons.home_rounded),
          label: const Text('Kembali ke Beranda'),
        ),
      ],
    );

    final reviewList = QuestionReviewList(
      questions: quiz.questions,
      answers: quiz.answers,
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _goHome(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hasil Kuis'),
          automaticallyImplyLeading: false,
          actions: const [ThemeToggleButton()],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: ResponsiveContainer(
              maxWidth: isWide ? _wideMaxWidth : Responsive.maxContentWidth,
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              summaryCard,
                              SizedBox(height: gap * 1.5),
                              actionButtons,
                            ],
                          ),
                        ),
                        SizedBox(width: gap * 2),
                        Expanded(
                          flex: 5,
                          child: reviewList,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        summaryCard,
                        SizedBox(height: gap * 1.25),
                        actionButtons,
                        SizedBox(height: gap * 1.5),
                        reviewList,
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}