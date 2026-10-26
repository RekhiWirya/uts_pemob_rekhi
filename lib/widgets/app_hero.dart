
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class AppHero extends StatelessWidget {
  const AppHero({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final logoSize = context.scale(100);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: logoSize,
          height: logoSize,
          padding: EdgeInsets.all(context.scale(3)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/app_logo.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.music_note_rounded,
                  size: logoSize * 0.52,
                  color: scheme.onPrimary,
                );
              },
            ),
          ),
        ),
        SizedBox(height: context.scale(20)),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: context.scale(35),
            fontWeight: FontWeight.w300,
            height: 1.25,
            color: scheme.onSurface,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: context.scale(8)),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: context.scale(16),
              fontWeight: FontWeight.w400,
              color: scheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}
