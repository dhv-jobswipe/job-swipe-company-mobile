// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/enums/notification_type.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/message/message.dart';
import 'package:pbl5/models/notification_data/notification_data.dart';
import 'package:pbl5/routes.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/storages.dart';
import 'package:provider/provider.dart';

import '/app_common_data/themes/app_theme.dart';

extension BuildContextExt on BuildContext {
  ///
  /// MediaQuery
  ///
  Size get screenSize => MediaQuery.of(this).size;

  EdgeInsets get viewInset => MediaQuery.of(this).viewInsets;

  EdgeInsets get viewPadding => MediaQuery.of(this).padding;

  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  Orientation get orientation => MediaQuery.of(this).orientation;

  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  bool get alwaysUse24HourFormat => MediaQuery.of(this).alwaysUse24HourFormat;

  ///
  /// Localizations
  ///
  Locale get currentLocale => locale;

  String get currentLanguageCode => currentLocale.languageCode;

  ///
  /// ThemeData & AppTheme
  ///
  ThemeData get theme => Theme.of(this);

  AppTheme get appTheme => AppTheme.of(this)!;

  ///
  /// Focus manager
  ///
  void unfocus() => FocusScope.of(this).unfocus();

  ///
  /// Drawer
  ///
  bool get hasDrawer => Scaffold.of(this).hasDrawer;

  void openDrawer() => hasDrawer ? Scaffold.of(this).openDrawer() : null;

  void closeDrawer() => hasDrawer ? Scaffold.of(this).closeDrawer() : null;

  ///
  /// Navigator
  ///
  bool get canPop => Navigator.of(this).canPop();

  // Pop
  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);

  // Push route
  Future<T?> pushRoute<T extends Object?>(
          Widget Function(BuildContext context) builder) =>
      Navigator.of(this).push(MaterialPageRoute(builder: builder));

  // Push named
  Future<T?> pushNamed<T extends Object?>(String routeName,
          {Object? arguments}) =>
      Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);

  // Pop and push named
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      Navigator.of(this).popAndPushNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments,
      );

  // Push Named And Remove Until
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) =>
      Navigator.of(this).pushNamedAndRemoveUntil<T>(
        newRouteName,
        predicate,
        arguments: arguments,
      );

  // Push Named And Remove Until
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) =>
      Navigator.of(this).pushReplacementNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments,
      );

  ///
  /// ModalRoute
  ///
  ModalRoute<dynamic>? get modalRoute => ModalRoute.of(this);

  T? getArguments<T>() =>
      modalRoute == null ? null : modalRoute!.settings.arguments as T;

  String? get currentRouteName =>
      modalRoute == null ? null : modalRoute!.settings.name;

  ///
  /// Provider
  ///
  T of<T>({bool listen = false}) => Provider.of<T>(this, listen: listen);

  ///
  /// App data
  ///
  Future<void> clearAppData() async {
    await getIt.get<CustomSharedPreferences>().clear();
  }

  void navigateNotification(
    NotificationType type, {
    NotificationData? data,
    Message? message,
  }) {
    String routeName = '';
    dynamic arguments;
    switch (type) {
      case NotificationType.MATCHING:
      case NotificationType.REQUEST_MATCHING:
      case NotificationType.REJECT_MATCHING:
        routeName = Routes.userDetail;
        arguments = data?.sender?.accountId;
        break;
      case NotificationType.NEW_CONVERSATION:
        break;
      case NotificationType.NEW_MESSAGE:
        if (message == null) return;
        routeName = Routes.chat;
        arguments = message.conversationId;
        break;
      default:
        break;
    }
    if (routeName.isNotEmptyOrNull) {
      pushNamed(routeName, arguments: arguments);
    }
  }
}
