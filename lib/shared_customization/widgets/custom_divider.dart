// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/enums/divider_direction.dart';

class CustomDivider extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final DividerDirection direction;
  final Color? color;
  final double thinkness;
  final double? indent;
  final double? endIndent;

  const CustomDivider({
    super.key,
    required this.direction,
    this.padding = EdgeInsets.zero,
    this.color,
    this.thinkness = 0.5,
    this.indent,
    this.endIndent,
  });

  const CustomDivider.vertical({
    super.key,
    this.color,
    this.padding = EdgeInsets.zero,
    this.thinkness = 0.5,
    this.indent,
    this.endIndent,
  }) : direction = DividerDirection.vertical;

  const CustomDivider.horizontal({
    super.key,
    this.color,
    this.padding = EdgeInsets.zero,
    this.thinkness = 0.5,
    this.indent,
    this.endIndent,
  }) : direction = DividerDirection.horizontal;

  @override
  Widget build(BuildContext context) {
    Widget widget = const SizedBox.shrink();
    AppThemeData theme = context.appTheme.appThemeData;
    switch (direction) {
      case DividerDirection.horizontal:
        widget = Divider(
          color: color ?? theme.divider_primary,
          thickness: thinkness,
          height: thinkness,
          indent: indent,
          endIndent: endIndent,
        );
        break;
      case DividerDirection.vertical:
        widget = VerticalDivider(
          color: color ?? theme.divider_primary,
          indent: indent,
          endIndent: endIndent,
          thickness: thinkness,
          width: thinkness,
        );
        break;
    }
    return Padding(padding: padding, child: widget);
  }
}
