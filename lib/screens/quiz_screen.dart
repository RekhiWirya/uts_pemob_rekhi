import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../widgets/responsive_container.dart';
import '../widgets/theme_toggle_button.dart';

/// KERANGKA SEMENTARA. Akan diganti dengan halaman kuis asli di Hari 4.
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuis'),
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: Center(
          child: ResponsiveContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Halo, ${quiz.userName}!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  'Halaman kuis dibuat di Hari 4.',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}