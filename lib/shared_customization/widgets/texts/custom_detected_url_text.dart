// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '/shared_customization/data/regular_expressions.dart';
import '/shared_customization/data/string_domain_extension.dart';
import '/shared_customization/extensions/list_ext.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/shared_customization/data/basic_types.dart';
import '/app_common_data/app_text_sytle.dart';

class CustomDetectedUrlText extends StatelessWidget {
  final String? text;
  final int? maxLines;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Color? detectedUrlColor;
  final UpdateStyleCallBack? onStyleUpdate;
  final UpdateStyleCallBack? onDetectedUrlStyleUpdate;

  const CustomDetectedUrlText(
    this.text, {
    super.key,
    this.maxLines = 999,
    this.textAlign = TextAlign.left,
    this.textDirection = TextDirection.ltr,
    this.detectedUrlColor,
    this.onStyleUpdate,
    this.onDetectedUrlStyleUpdate,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    TextStyle textStyle = (onStyleUpdate?.call(AppTextStyle.defaultStyle)) ??
        AppTextStyle.defaultStyle;
    if (text.isEmptyOrNull || !LINK_REG_EXP.hasMatch(text!)) {
      return CustomText(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        textDirection: textDirection,
        overflow:
            maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
        style: textStyle,
      );
    }
    List<RegExpMatch> listLinkRegExpMatched =
        LINK_REG_EXP.allMatches(text!).where((matchedRegexItem) {
      String matchedText =
          text!.substring(matchedRegexItem.start, matchedRegexItem.end);
      return IP_REG_EXP.hasMatch(matchedText.toLowerCase()) ||
          LIST_DOMAIN_EXTENSIONS.any((domainExtension) {
            return matchedText.toUpperCase().endsWith(domainExtension) ||
                matchedText.toUpperCase().contains('$domainExtension/');
          });
    }).toList();

    List<TextSpan> listTextSpan = [
      TextSpan(
        text: text!.substring(
            0,
            listLinkRegExpMatched.elementAtIndexOrElseNull(0)?.start ??
                text!.length),
        style: textStyle,
      ),
      ...listLinkRegExpMatched.asMap().entries.fold(
          [],
          (previousValue, entry) => [
                ...previousValue,

                /// link
                TextSpan(
                  text: text!.substring(entry.value.start, entry.value.end),
                  style: (onDetectedUrlStyleUpdate?.call(textStyle)) ??
                      textStyle.copyWith(
                          color: detectedUrlColor ?? theme.primary_color,
                          decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrlString(
                        text!.substring(entry.value.start, entry.value.end)),
                ),

                /// normal text
                TextSpan(
                  text: text!.substring(
                      entry.value.end,
                      listLinkRegExpMatched
                              .elementAtIndexOrElseNull(entry.key + 1)
                              ?.start ??
                          text!.length),
                  style: textStyle,
                )
              ])
    ];
    return RichText(
        textAlign: textAlign,
        maxLines: maxLines,
        textDirection: textDirection,
        overflow:
            maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
        text: TextSpan(children: listTextSpan, style: textStyle));
  }
}
