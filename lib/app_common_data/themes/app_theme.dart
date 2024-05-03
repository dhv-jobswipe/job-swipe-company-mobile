import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';

class AppTheme extends InheritedWidget {
  final AppThemeData appThemeData;

  const AppTheme({
    super.key,
    required super.child,
    required this.appThemeData,
  });

  @override
  bool updateShouldNotify(AppTheme oldWidget) {
    return oldWidget.appThemeData != appThemeData;
  }

  static AppTheme? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppTheme>();
}
