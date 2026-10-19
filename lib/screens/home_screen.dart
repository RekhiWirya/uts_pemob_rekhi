import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/app_hero.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/responsive_container.dart';
import '../widgets/theme_toggle_button.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _wideMaxWidth = 960;

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    _nameController =
        TextEditingController(text: context.read<QuizProvider>().userName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Nama tidak boleh kosong';
    if (name.length < 2) return 'Nama minimal 2 karakter';
    return null;
  }

  void _startQuiz() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final quiz = context.read<QuizProvider>();
    quiz.setUserName(_nameController.text);
    quiz.restart();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gap = context.scale(16);

    final isWide = context.isLandscape || context.isDesktop;

    const hero = AppHero(
      title: 'Kuis Musik',
      subtitle: 'Seberapa jauh kamu kenal lagu-lagu favoritmu?',
    );
    final form = _buildForm(context, gap);

    return Scaffold(
      appBar: AppBar(actions: const [ThemeToggleButton()]),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ResponsiveContainer(
              maxWidth: isWide ? _wideMaxWidth : Responsive.maxContentWidth,
              child: isWide
                  ? Row(
                children: [
                  const Expanded(child: hero),
                  SizedBox(width: gap * 2),
                  Expanded(child: form),
                ],
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  hero,
                  SizedBox(height: gap * 2),
                  form,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, double gap) {
    final theme = Theme.of(context);
    final totalQuestions =
    context.select<QuizProvider, int>((q) => q.totalQuestions);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Siapa namamu?', style: theme.textTheme.titleLarge),
          SizedBox(height: gap / 2),
          Text(
            'Nama akan ditampilkan di hasil akhir kuis.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: gap * 1.25),
          CustomTextField(
            controller: _nameController,
            label: 'Nama',
            hint: 'Contoh: Rekhi',
            icon: Icons.person_outline,
            maxLength: 20,
            textInputAction: TextInputAction.done,
            validator: _validateName,
            onSubmitted: (_) => _startQuiz(),
          ),
          SizedBox(height: gap * 1.25),
          CustomButton(
            label: 'Mulai Kuis',
            icon: Icons.play_arrow_rounded,
            onPressed: _startQuiz,
          ),
          SizedBox(height: gap),
          Text(
            '$totalQuestions soal pilihan ganda',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}