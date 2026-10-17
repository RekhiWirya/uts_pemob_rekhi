import 'package:flutter/material.dart';

import '../utils/responsive.dart';


class ThemePreviewScreen extends StatelessWidget {
  const ThemePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.sizeOf(context);
    final gap = context.scale(16);

    return Scaffold(
      appBar: AppBar(title: const Text('Theme Preview')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
            child: ListView(
              padding: EdgeInsets.all(context.scale(20)),
              children: [
                Text('Aplikasi Kuis', style: textTheme.displaySmall),
                SizedBox(height: gap / 2),
                Text(
                  'The quick brown fox jumps over the lazy dog.',
                  style: textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: gap * 1.5),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(gap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tipografi', style: textTheme.titleMedium),
                        SizedBox(height: gap / 2),
                        for (final w in [
                          FontWeight.w400,
                          FontWeight.w500,
                          FontWeight.w600,
                          FontWeight.w700,
                        ])
                          Text(
                            'Poppins ${w.value}',
                            style: TextStyle(fontWeight: w),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: gap),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(gap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Info layar', style: textTheme.titleMedium),
                        SizedBox(height: gap / 2),
                        Text('Perangkat: ${context.deviceType.name}'),
                        Text('Ukuran: ${size.width.round()} × ${size.height.round()}'),
                        Text('Skala UI: ${Responsive.scaleOf(context).toStringAsFixed(2)}×'),
                        Text('Tema: ${theme.brightness.name}'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: gap * 1.5),
                FilledButton(onPressed: () {}, child: const Text('Mulai Kuis')),
                SizedBox(height: gap / 2),
                OutlinedButton(onPressed: () {}, child: const Text('Lihat Skor')),
                SizedBox(height: gap),
                const TextField(
                  decoration: InputDecoration(hintText: 'Masukkan nama'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}