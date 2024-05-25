import 'package:flutter/material.dart';

class GlobalKeyVariable {
  GlobalKeyVariable._();

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
      GlobalKey<ScaffoldMessengerState>();
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();

  static BuildContext? get currentContext => navigatorState.currentContext;
  static Future<BuildContext> get futureCurrentContext async {
    await Future.doWhile(() => navigatorState.currentContext == null);
    return navigatorState.currentContext!;
  }
}
