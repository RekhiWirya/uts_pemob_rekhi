
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
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

  final int index; // 0 = A, 1 = B, dan seterusnya.
  final String text;
  final OptionState state;
  final VoidCallback? onTap; // null = tidak bisa ditekan.

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final radius = BorderRadius.circular(context.scale(8));

    final Color background;
    final Color borderColor;
    final Color badgeBg;
    final Color badgeText;
    final Color textColor;

    switch (state) {
      case OptionState.correct:
        background = AppColors.primary.withValues(alpha: 0.08);
        borderColor = AppColors.primary;
        badgeBg = AppColors.primary;
        badgeText = AppColors.canvasLight;
        textColor = scheme.onSurface;
        break;

      case OptionState.wrong:
        background = AppColors.warning.withValues(alpha: 0.08);
        borderColor = AppColors.warning;
        badgeBg = AppColors.warning;
        badgeText = AppColors.canvasLight;
        textColor = scheme.onSurface;
        break;

      case OptionState.dimmed:
        background =
            scheme.surfaceContainerHighest.withValues(alpha: 0.4);
        borderColor = scheme.outline.withValues(alpha: 0.3);
        badgeBg = scheme.outline.withValues(alpha: 0.3);
        badgeText = scheme.onSurfaceVariant;
        textColor = scheme.onSurfaceVariant;
        break;

      case OptionState.idle:
        background = scheme.surfaceContainerLow;
        borderColor = scheme.outline;
        badgeBg = AppColors.primary;
        badgeText = AppColors.canvasLight;
        textColor = scheme.onSurface;
        break;
    }

    final isResult =
        state == OptionState.correct || state == OptionState.wrong;

    final badge = Container(
      width: context.scale(36),
      height: context.scale(36),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: badgeBg,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: isResult
          ? Icon(
        state == OptionState.correct
            ? Icons.check_rounded
            : Icons.close_rounded,
        color: badgeText,
        size: context.scale(20),
      )
          : Text(
        String.fromCharCode(65 + index),
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: context.scale(16),
          fontWeight: FontWeight.w700,
          color: badgeText,
        ),
      ),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: background,
        borderRadius: radius,
        border: Border.all(
          color: borderColor,
          width: context.scale(1.5),
        ),
      ),
      // Material transparan agar efek ripple InkWell tetap terlihat.
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(16),
              vertical: context.scale(14),
            ),
            child: Row(
              children: [
                badge,
                SizedBox(width: context.scale(14)),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: context.scale(16),
                      fontWeight: isResult
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: textColor,
                      height: 1.5,
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
