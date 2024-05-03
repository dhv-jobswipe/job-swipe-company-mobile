// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/app_common_data/app_text_sytle.dart';

class CustomRequiredText extends StatelessWidget {
  final String label;
  final Color? textColor;
  final bool isRequired;
  final EdgeInsetsGeometry padding;
  const CustomRequiredText(
    this.label, {
    Key? key,
    required this.isRequired,
    this.padding = EdgeInsets.zero,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return Padding(
      padding: padding,
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
          text: label,
          style: AppTextStyle.fieldLabel
              .copyWith(color: textColor ?? theme.text_field_label),
        ),
        if (isRequired)
          TextSpan(
              text: " *",
              style: AppTextStyle.fieldLabel.copyWith(
                color: theme.text_required_icon,
                fontWeight: FontWeight.w500,
              ))
      ])),
    );
  }
}
