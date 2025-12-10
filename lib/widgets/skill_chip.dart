import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool elevated;

  const SkillChip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.margin = const EdgeInsets.only(right: 8, bottom: 8),
    this.icon,
    this.onTap,
    this.elevated = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = backgroundColor ?? Theme.of(context).primaryColor.withOpacity(0.15);
    final Color fgColor = textColor ?? Theme.of(context).primaryColor;

    Widget chipContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: fontSize + 4, color: fgColor),
          const SizedBox(width: 4),
        ],
        Text(
          label,
          style: TextStyle(
            color: fgColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    if (onTap != null) {
      chipContent = InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: chipContent,
        ),
      );
    } else {
      chipContent = Padding(
        padding: padding,
        child: chipContent,
      );
    }

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: elevated
            ? [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ]
            : null,
      ),
      child: chipContent,
    );
  }
}
