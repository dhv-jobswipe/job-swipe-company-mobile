// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/texts/custom_required_text.dart';
import '/app_common_data/app_text_sytle.dart';
import '/generated/assets.gen.dart';

class CustomField extends StatelessWidget {
  final String? errorLabel;
  final String? label;
  final bool isRequired;
  final Widget child;

  const CustomField({
    super.key,
    required this.errorLabel,
    required this.label,
    required this.isRequired,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (label != null && label.isNotEmptyOrNull)
            ? CustomRequiredText(label!,
                isRequired: isRequired,
                padding: const EdgeInsets.only(bottom: 6))
            : const SizedBox.shrink(),
        child,
        if (errorLabel.isNotEmptyOrNull)
          ...([
            const SizedBox(height: 4),
            RichText(
                text: TextSpan(children: [
              WidgetSpan(
                  child: CustomContainer(
                      margin: const EdgeInsets.only(right: 4),
                      child: Assets.icons.icErrorTextField.svg())),
              TextSpan(
                  text: errorLabel ?? '',
                  style: AppTextStyle.defaultStyle
                      .copyWith(color: theme.text_error, fontSize: 12))
            ])),
            const SizedBox(height: 2),
          ])
      ],
    );
  }
}
