// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';

import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/app_common_data/common_data/global_variable.dart';
import '/shared_customization/widgets/custom_container.dart';

class CustomCard extends StatelessWidget {
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;
  final Widget child;
  final Border? border;
  final double elevation;
  final Color? shadowColor;

  const CustomCard({
    super.key,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius =
        const BorderRadius.all(Radius.circular(BORDER_RADIUS_VALUE)),
    this.onTap,
    this.border,
    required this.child,
    this.elevation = 6,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    final AppThemeData theme = context.appTheme.appThemeData;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: elevation,
        shadowColor: shadowColor ?? theme.shadow,
        child: CustomContainer(
          border: border,
          color: backgroundColor ?? theme.bg_primary,
          padding: padding,
          margin: margin,
          borderRadius: borderRadius,
          child: child,
        ),
      ),
    );
  }
}
