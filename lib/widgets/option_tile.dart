import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/responsive.dart';

/// Keadaan visual sebuah pilihan jawaban.
enum OptionState { idle, correct, wrong, dimmed }

/// Satu pilihan jawaban (A, B, C, D).
class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.index,
    required this.text,
    required this.state,
    required this.onTap,
  });

  final int index; // 0 = A, 1 = B, dst.
  final String text;
  final OptionState state;
  final VoidCallback? onTap; // null = tidak bisa ditekan

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final radius = BorderRadius.circular(context.scale(16));

    final isResult =
        state == OptionState.correct || state == OptionState.wrong;
    final accent =
    state == OptionState.correct ? AppColors.success : AppColors.error;

    final background =
    isResult ? accent.withValues(alpha: 0.12) : scheme.surfaceContainerLow;
    final borderColor = isResult ? accent : scheme.outline;
    final badgeColor = isResult ? accent : scheme.surfaceContainerHighest;
    final badgeContent = switch (state) {
      OptionState.correct => AppColors.onSecondary,
      OptionState.wrong => Colors.white,
      _ => scheme.onSurface,
    };
    final textColor =
    state == OptionState.dimmed ? scheme.onSurfaceVariant : scheme.onSurface;

    final badge = Container(
      width: context.scale(36),
      height: context.scale(36),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle),
      child: isResult
          ? Icon(
        state == OptionState.correct
            ? Icons.check_rounded
            : Icons.close_rounded,
        color: badgeContent,
        size: context.scale(20),
      )
          : Text(
        String.fromCharCode(65 + index), // 65 = 'A'
        style: theme.textTheme.titleMedium?.copyWith(color: badgeContent),
      ),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: background,
        borderRadius: radius,
        border: Border.all(color: borderColor, width: context.scale(1.5)),
      ),
      // Material transparan agar efek ripple InkWell tetap terlihat di atas warna latar.
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(14),
              vertical: context.scale(12),
            ),
            child: Row(
              children: [
                badge,
                SizedBox(width: context.scale(14)),
                Expanded(
                  child: Text(
                    text,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: textColor,
                      fontWeight: isResult ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}