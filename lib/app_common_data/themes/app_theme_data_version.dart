import '/app_common_data/themes/app_theme_data.dart';
import '/app_common_data/themes/versions/app_theme_data_v1.dart';
import '/app_common_data/themes/versions/app_theme_data_v2.dart';

enum AppThemeDataVersion {
  v1,
  v2,
}

extension AppThemeDataVersionExt on AppThemeDataVersion {
  String get label => {
        AppThemeDataVersion.v1: AppThemeDataV1().version_label,
        AppThemeDataVersion.v2: AppThemeDataV2().version_label,
      }[this]!;

  AppThemeData get appThemeData => {
        AppThemeDataVersion.v1: AppThemeDataV1(),
        AppThemeDataVersion.v2: AppThemeDataV2(),
      }[this]!;
}
