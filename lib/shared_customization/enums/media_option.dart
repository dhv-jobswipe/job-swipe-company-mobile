// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/app_common_data/common_data/global_key_variable.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/generated/translations.g.dart';

enum MediaOption { file, photo, video, location }

extension MediaOptionExt on MediaOption? {
  String get label => {
        MediaOption.file: tr(LocaleKeys.CommonData_File),
        MediaOption.photo: tr(LocaleKeys.CommonData_Photo),
        MediaOption.video: tr(LocaleKeys.CommonData_Video),
        MediaOption.location: tr(LocaleKeys.CommonData_Location),
      }[this]!;
  IconData get icon {
    return {
      MediaOption.file: Icons.file_present_rounded,
      MediaOption.photo: Icons.image,
      MediaOption.video: Icons.video_camera_back_rounded,
      MediaOption.location: Icons.location_on_outlined,
    }[this]!;
  }

  Color get color {
    AppThemeData theme =
        GlobalKeyVariable.navigatorState.currentContext!.appTheme.appThemeData;
    return {
      MediaOption.file: theme.icon_primary,
      MediaOption.photo: theme.icon_primary,
      MediaOption.video: theme.icon_primary,
      MediaOption.location: theme.icon_primary,
    }[this]!;
  }
}
