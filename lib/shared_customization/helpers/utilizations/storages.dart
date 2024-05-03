import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/app_common_data/common_data/common_data.dart';
import '/app_common_data/themes/app_theme_data_version.dart';
import '/shared_customization/extensions/string_ext.dart';

class CustomSharedPreferences {
  late final SharedPreferences prefs;

  String? get accessToken => prefs.getString(AppStrings.ACCESS_TOKEN);
  String? get refreshToken => prefs.getString(AppStrings.REFRESH_TOKEN);
  bool get loggedBefore => prefs.getBool(AppStrings.LOGGED_BEFORE) ?? false;
  set loggedBefore(bool value) =>
      prefs.setBool(AppStrings.LOGGED_BEFORE, value);
  bool get keepLogin => prefs.getBool(AppStrings.KEEP_LOGIN) ?? false;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  AppThemeDataVersion loadThemeVersion() {
    String? themeVersion = prefs.getString(AppStrings.THEME);
    debugPrint("THEME VERSION: $themeVersion".debug);
    if (themeVersion.isNotEmptyOrNull) {
      return AppThemeDataVersion.values.firstWhere(
          (element) => element.label == themeVersion,
          orElse: () => AppThemeDataVersion.v1);
    }
    return AppThemeDataVersion.v1;
  }

  Future<void> setToken(String accessToken, String refreshToken) async {
    await prefs.setString(AppStrings.ACCESS_TOKEN, accessToken);
    await prefs.setString(AppStrings.REFRESH_TOKEN, refreshToken);
    debugPrint("STORAGE: $accessToken -------- $refreshToken".debug);
  }

  bool isEmtpty() {
    return (prefs.getString(AppStrings.ACCESS_TOKEN).isEmptyOrNull ||
        prefs.getString(AppStrings.REFRESH_TOKEN).isEmptyOrNull);
  }

  Future clear() async {
    await prefs.remove(AppStrings.ACCESS_TOKEN);
    await prefs.remove(AppStrings.REFRESH_TOKEN);
  }
}
