import 'package:flutter/material.dart';
import '/app_common_data/enums/app_language.dart';

extension LocaleExt on Locale {
  AppLanguage get toAppLanguage => AppLanguage.values.firstWhere(
      (element) => element.languageCode == languageCode,
      orElse: () => AppLanguage.vi);
}
