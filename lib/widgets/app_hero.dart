import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class AppHero extends StatelessWidget {
  const AppHero({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final badge = context.scale(80);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: badge,
          height: badge,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary, // PlayStation Blue
          ),
          child: Icon(
            Icons.videogame_asset_rounded,
            size: badge * 0.52,
            color: AppColors.canvasLight,
          ),
        ),
        SizedBox(height: context.scale(20)),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: context.scale(35),
            fontWeight: FontWeight.w300, // Light 300 PlayStation signature
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