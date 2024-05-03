// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/widgets/custom_container.dart';

class CustomIconButton extends StatelessWidget {
  final Color? color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final IconData icon;
  final double size;
  final Color? backgroundColor;

  const CustomIconButton({
    super.key,
    this.color,
    this.padding = const EdgeInsets.all(4),
    this.margin = EdgeInsets.zero,
    required this.onPressed,
    this.onLongPress,
    required this.icon,
    this.size = 28,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: CustomContainer(
          padding: padding,
          margin: margin,
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor,
          child: Icon(icon, size: size, color: color ?? theme.icon_primary)),
    );
  }
}
