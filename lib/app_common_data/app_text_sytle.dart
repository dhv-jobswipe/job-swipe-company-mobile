import 'package:flutter/material.dart';
import '/app_common_data/common_data/global_key_variable.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/generated/fonts.gen.dart';

class AppTextStyle {
  AppTextStyle._();
  static final AppThemeData _theme =
      GlobalKeyVariable.navigatorState.currentContext!.appTheme.appThemeData;

  static TextStyle defaultStyle = TextStyle(
      fontSize: 14,
      color: _theme.text_normal,
      fontFamily: FontFamily.notoSans,
      fontWeight: FontWeight.w400);

  static TextStyle error = TextStyle(
      fontSize: 15,
      color: _theme.text_error,
      fontFamily: FontFamily.notoSans,
      fontWeight: FontWeight.w400);

  static TextStyle buttonText = TextStyle(
      fontSize: 14,
      color: _theme.white,
      fontFamily: FontFamily.notoSans,
      fontWeight: FontWeight.w600);

  static TextStyle bigTitleText = TextStyle(
      fontSize: 22,
      color: _theme.text_title,
      fontFamily: FontFamily.notoSans,
      fontWeight: FontWeight.w700);

  static TextStyle labelText = TextStyle(
      fontSize: 20,
      color: _theme.primary_color,
      fontFamily: FontFamily.notoSans,
      fontWeight: FontWeight.w700);

  static TextStyle titleText = TextStyle(
      fontSize: 17,
      color: _theme.text_title,
      fontFamily: FontFamily.notoSans,
      fontWeight: FontWeight.w700);

  static TextStyle bodyText = TextStyle(
      fontSize: 15,
      color: _theme.text_body,
      fontFamily: FontFamily.notoSans,
      fontWeight: FontWeight.w500);

  static TextStyle fieldLabel = TextStyle(
      fontSize: 14,
      color: _theme.text_field_label,
      fontFamily: FontFamily.notoSans,
      fontWeight: FontWeight.w600);

  static TextStyle description = TextStyle(
      fontSize: 12,
      color: _theme.text_normal,
      fontFamily: FontFamily.notoSans,
      fontWeight: FontWeight.w400);

  static TextStyle header = TextStyle(
      fontFamily: FontFamily.notoSans,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: _theme.text_title);
}
