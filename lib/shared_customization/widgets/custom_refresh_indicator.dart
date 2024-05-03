// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';

class CustomRefreshIndicator extends StatelessWidget {
  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.backgroundColor,
    this.color,
  });
  final Future<void> Function() onRefresh;
  final Widget child;
  final Color? backgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return RefreshIndicator(
      backgroundColor: backgroundColor ?? theme.white,
      color: color ?? theme.icon_primary,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
