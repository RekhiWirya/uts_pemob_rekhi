import 'package:flutter/material.dart';

import '../utils/responsive.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isOutlined = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isOutlined;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final text = Text(label);
    final iconWidget =
    icon == null ? null : Icon(icon, size: context.scale(20));

    final Widget button = isOutlined
        ? (iconWidget == null
        ? OutlinedButton(onPressed: onPressed, child: text)
        : OutlinedButton.icon(
        onPressed: onPressed, icon: iconWidget, label: text))
        : (iconWidget == null
        ? FilledButton(onPressed: onPressed, child: text)
        : FilledButton.icon(
        onPressed: onPressed, icon: iconWidget, label: text));

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}