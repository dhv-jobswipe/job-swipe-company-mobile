// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/app_common_data/enums/app_language.dart';
import '/app_common_data/common_data/global_key_variable.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/app_common_data/app_text_sytle.dart';
import '/shared_customization/extensions/string_ext.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String? text;
  TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool trim;
  final EdgeInsetsGeometry padding;

  CustomText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.overflow,
    this.maxLines,
    this.trim = true,
    this.padding = EdgeInsets.zero,
    double? size,
    Color? color,
    FontWeight? fontWeight,
  }) {
    style ??= AppTextStyle.defaultStyle;
    if (size != null) style = style!.copyWith(fontSize: size);
    if (color != null) style = style!.copyWith(color: color);
    if (fontWeight != null) style = style!.copyWith(fontWeight: fontWeight);
  }

  CustomText.timeAgo({
    super.key,
    required DateTime dateTime,
    bool isShort = false,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.overflow,
    this.maxLines,
    this.trim = true,
    this.padding = EdgeInsets.zero,
    double? size,
    Color? color,
    FontWeight? fontWeight,
  }) {
    // TimeAgo
    for (AppLanguage element in AppLanguage.values) {
      timeago.setLocaleMessages(
          element.languageCode, element.lookupMessages(isShort: isShort));
    }
    text = timeago.format(dateTime,
        locale: locale?.languageCode ??
            GlobalKeyVariable
                .navigatorState.currentContext!.currentLanguageCode);
    // TextStyle
    style ??= AppTextStyle.defaultStyle;
    if (size != null) style = style!.copyWith(fontSize: size);
    if (color != null) style = style!.copyWith(color: color);
    if (fontWeight != null) style = style!.copyWith(fontWeight: fontWeight);
  }

  CustomText.error(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.overflow,
    this.maxLines,
    this.trim = true,
    this.padding = EdgeInsets.zero,
  }) {
    style ??= AppTextStyle.error;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        trim && text.isNotEmptyOrNull ? text!.trim() : text ?? '',
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        style: style?.copyWith(decoration: TextDecoration.none),
        overflow:
            maxLines != null ? (overflow ?? TextOverflow.ellipsis) : overflow,
        maxLines: maxLines,
      ),
    );
  }
}
