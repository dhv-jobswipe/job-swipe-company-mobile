import 'package:flutter/material.dart';
import 'package:pbl5/models/file_content/file_content.dart';
import 'package:pbl5/screens/change_password/change_password_screen.dart';
import 'package:pbl5/screens/chat/chat_screen.dart';
import 'package:pbl5/screens/forgot_password/forgot_password_screen.dart';
import 'package:pbl5/screens/login/integrated_auth_screen.dart';
import 'package:pbl5/screens/main/main_screen.dart';
import 'package:pbl5/screens/reset_password/reset_password_screen.dart';
import 'package:pbl5/screens/splash/splash_screen.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/screens/custom_image_full_screen.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/screens/custom_video_view_screen.dart';

import 'screens/user_detail/user_detail_screen.dart';

class Routes {
  Routes._();
  static const String splash = '/splash';
  static const String integratedAuth = '/integratedAuth';
  static const String main = '/main';
  static const String chat = '/chat';
  static const String imageFullScreen = '/imageFullScreen';
  static const String videoScreen = '/videoScreen';
  static const String forgotPassword = '/forgotPassword';
  static const String resetPassword = '/resetPassword';
  static const String userDetail = '/userDetail';
  static const String changePassword = '/changePassword';

  static final Map<String, WidgetBuilder> routes = {
    splash: (BuildContext context) => const SplashScreen(),
    integratedAuth: (BuildContext context) => const IntegratedAuthScreen(),
    main: (BuildContext context) => const MainScreen(),
    chat: (BuildContext context) =>
        ChatScreen(conversationId: context.getArguments<String>()!),
    imageFullScreen: (BuildContext context) => CustomImageFullScreen(
        params: context.getArguments<CustomImageFullScreenParams>()!),
    videoScreen: (BuildContext context) =>
        CustomVideoViewScreen(file: context.getArguments<FileContent>()!),
    forgotPassword: (BuildContext context) => const ForgotPasswordScreen(),
    resetPassword: (BuildContext context) => ResetPasswordScreen(
        args: context.getArguments<ResetPasswordScreenArgs>()!),
    userDetail: (BuildContext context) =>
        UserDetailScreen(userId: context.getArguments<String>()!),
    changePassword: (BuildContext context) => const ChangePasswordScreen(),
  };
}
