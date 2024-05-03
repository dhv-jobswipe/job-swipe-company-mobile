// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/app_common_data/common_data/global_key_variable.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';

enum ButtonType { primary, white, red, disable }

extension ButtonTypeExt on ButtonType {
  Color get backgroundColor {
    AppThemeData theme =
        GlobalKeyVariable.navigatorState.currentContext!.appTheme.appThemeData;
    return {
      ButtonType.primary: Colors.pink,
      ButtonType.white: theme.button_white_bg,
      ButtonType.disable: theme.button_disable_bg,
      ButtonType.red: theme.button_error_bg,
    }[this]!;
  }

  Color get textColor {
    AppThemeData theme =
        GlobalKeyVariable.navigatorState.currentContext!.appTheme.appThemeData;
    return {
      ButtonType.primary: theme.white,
      ButtonType.white: theme.button_primary_bg,
      ButtonType.disable: theme.white,
      ButtonType.red: theme.white,
    }[this]!;
  }

  Color get borderColor {
    AppThemeData theme =
        GlobalKeyVariable.navigatorState.currentContext!.appTheme.appThemeData;
    return {
      ButtonType.primary: theme.transparent,
      ButtonType.white: theme.button_primary_bg,
      ButtonType.disable: theme.transparent,
      ButtonType.red: theme.transparent,
    }[this]!;
  }

  List<double> get stops => {
        ButtonType.primary: [0.0, 1.0],
        ButtonType.white: [0.0, 1.0],
        ButtonType.disable: [0.0, 1.0],
        ButtonType.red: [0.0, 1.0],
      }[this]!;
}
