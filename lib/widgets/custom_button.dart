import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isOutlined = false,
    this.isCommerce = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isOutlined;
  final bool isCommerce;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final text = Text(
      label,
      style: TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontSize: context.scale(18),
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: 0.45,
      ),
    );
    final iconWidget =
        icon == null ? null : Icon(icon, size: context.scale(20));

    final Color primaryBg =
        isCommerce ? AppColors.commerce : AppColors.primary;

    final buttonStyle = isOutlined
        ? OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: scheme.onSurface,
            side: BorderSide(color: scheme.outline, width: 1),
            minimumSize: Size(64, context.scale(48)),
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(28),
              vertical: context.scale(12),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9999),
            ),
          )
        : FilledButton.styleFrom(
            backgroundColor: primaryBg,
            foregroundColor: AppColors.canvasLight,
            disabledBackgroundColor: AppColors.surfaceSoft,
            disabledForegroundColor: AppColors.ashLight,
            minimumSize: Size(64, context.scale(48)),
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(28),
              vertical: context.scale(12),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9999),
            ),
          );

    final Widget button = isOutlined
        ? (iconWidget == null
            ? OutlinedButton(
                style: buttonStyle,
                onPressed: onPressed,
                child: text,
              )
            : OutlinedButton.icon(
                style: buttonStyle,
                onPressed: onPressed,
                icon: iconWidget,
                label: text,
              ))
        : (iconWidget == null
            ? FilledButton(
                style: buttonStyle,
                onPressed: onPressed,
                child: text,
              )
            : FilledButton.icon(
                style: buttonStyle,
                onPressed: onPressed,
                icon: iconWidget,
                label: text,
              ));

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}