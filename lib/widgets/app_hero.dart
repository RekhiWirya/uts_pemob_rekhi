import 'package:flutter/material.dart';

import '../utils/responsive.dart';


class AppHero extends StatelessWidget {
  const AppHero({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final badge = context.scale(96);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: badge,
          height: badge,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [scheme.primary, scheme.secondary],
            ),
          ),
          child: Icon(
            Icons.music_note_rounded,
            size: badge * 0.55,
            color: Colors.white,
          ),
        ),
        SizedBox(height: context.scale(24)),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.displaySmall,
        ),
        if (subtitle != null) ...[
          SizedBox(height: context.scale(8)),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}