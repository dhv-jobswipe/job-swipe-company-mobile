// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/helpers/string_helper.dart';
import '/app_common_data/app_text_sytle.dart';

class CustomHighlightMatchedText extends StatelessWidget {
  final String? sourceText;
  final String? matchText;
  final TextStyle? sourceStyle;
  final TextStyle? highlightStyle;
  final int? maxLines;
  final TextSpan? suffixText;

  const CustomHighlightMatchedText({
    super.key,
    required this.sourceText,
    required this.matchText,
    this.sourceStyle,
    this.highlightStyle,
    this.maxLines,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    RegExp nameExp = RegExp('${matchText?.toLowerCase()}');
    String nameWithNoSign =
        StringHelper.removeSignVietnameseString(sourceText!);
    List<RegExpMatch> regMatch =
        nameExp.allMatches(nameWithNoSign.toLowerCase()).toList();
    return RichText(
        textScaleFactor: MediaQuery.textScaleFactorOf(context),
        maxLines: maxLines ?? 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          ...(regMatch
              .asMap()
              .entries
              .map((regMatchEntry) => TextSpan(children: [
                    TextSpan(
                      text: regMatchEntry.key == 0
                          ? '${sourceText?.substring(0, regMatchEntry.value.start)}'
                          : '${sourceText?.substring(regMatch[regMatchEntry.key - 1].end, regMatchEntry.value.start)}',
                    ),
                    TextSpan(
                        text:
                            '${sourceText?.substring(regMatchEntry.value.start, regMatchEntry.value.end)}',
                        style: highlightStyle ??
                            AppTextStyle.defaultStyle.copyWith(
                                color: theme.primary_color,
                                fontWeight: FontWeight.w500))
                  ]))
              .toList()),
          TextSpan(
              text: sourceText?.substring(
                  regMatch.isNotEmpty ? regMatch[regMatch.length - 1].end : 0,
                  sourceText?.length)),
          ...(suffixText != null ? [suffixText!] : [])
        ], style: sourceStyle ?? AppTextStyle.defaultStyle));
  }
}
