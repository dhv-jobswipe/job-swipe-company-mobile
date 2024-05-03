// ignore_for_file: non_constant_identifier_names

import '/app_common_data/themes/versions/app_theme_data_v1.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/app_common_data/themes/app_theme_data_version.dart';

class AppThemeDataFactory {
  AppThemeDataFactory._();

  static final AppThemeData DEFAULT_THEME = AppThemeDataV1();

  static AppThemeData getAppThemeDataByVersionName(String versionName) {
    for (AppThemeDataVersion version in AppThemeDataVersion.values) {
      if (version.label == versionName) return version.appThemeData;
    }
    return DEFAULT_THEME;
  }

  static AppThemeData getAppThemeData(AppThemeDataVersion version) =>
      version.appThemeData;
}
