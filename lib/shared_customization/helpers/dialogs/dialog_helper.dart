import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pbl5/constants.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/helpers/dialogs/content_widgets/loading_dialog_content.dart';
import '/shared_customization/helpers/dialogs/content_widgets/base_dialog_content.dart';
import '/shared_customization/helpers/dialogs/content_widgets/confirm_dialog_content.dart';
import '/shared_customization/helpers/dialogs/content_widgets/feature_pending_dialog_content.dart';
import '/shared_customization/helpers/dialogs/content_widgets/success_dialog_content.dart';
import '/shared_customization/helpers/dialogs/content_widgets/error_dialog_content.dart';

void Function() showLoading({
  WrapAnimation? wrapToastAnimation,
  BackButtonBehavior? backButtonBehavior,
  VoidCallback? onClose,
  Duration? duration,
  Duration? animationDuration,
  Duration? animationReverseDuration,
}) =>
    BotToast.showCustomLoading(
      wrapAnimation: (AnimationController controller, CancelFunc cancelFunc,
              Widget child) =>
          FadeAnimation(controller: controller, child: child),
      wrapToastAnimation: wrapToastAnimation,
      align: Alignment.center,
      enableKeyboardSafeArea: true,
      backButtonBehavior: backButtonBehavior,
      toastBuilder: (_) => const CircularProgressIndicator(
        color: orangePink,
      ),
      clickClose: false,
      allowClick: false,
      crossPage: true,
      ignoreContentClick: true,
      onClose: onClose,
      duration: duration,
      animationDuration: animationDuration,
      animationReverseDuration: animationReverseDuration,
      backgroundColor: Colors.black26,
    );

Future<dynamic> showErrorDialog(BuildContext context,
        {String? title, String? content}) =>
    showDialog(
      context: context,
      builder: (context) {
        AppThemeData theme = context.appTheme.appThemeData;
        return Material(
          color: theme.transparent,
          child: Center(
            child: ErrorDialogContent(
              title: title,
              content: content,
            ),
          ),
        );
      },
    );

Future<dynamic> showSuccessDialog(BuildContext context,
        {String? title, String? content}) =>
    showDialog(
      context: context,
      builder: (context) {
        AppThemeData theme = context.appTheme.appThemeData;
        return Material(
          color: theme.transparent,
          child: Center(
              child: SuccessDialogContent(
            title: title,
            content: content,
          )),
        );
      },
    );

Future<bool?> showConfirmDialog(
  BuildContext context, {
  String? title,
  String? content,
  VoidCallback? onAccept,
  VoidCallback? onReject,
}) =>
    showDialog<bool>(
      context: context,
      builder: (context) {
        return Material(
          child: Center(
              child: ConfirmDialogContent(
            content: content,
            title: title,
            onAccept: onAccept,
            onReject: onReject,
          )),
        );
      },
    );

Future<void> showFeaturePendingDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => Material(
        color: context.appTheme.appThemeData.transparent,
        child: Center(child: FeaturePendingDialogContent()),
      ),
    );

Future<dynamic> showCustomDialog(
        {required BuildContext context, required WidgetBuilder builder}) =>
    showDialog(
      context: context,
      builder: (_) => Material(
          color: context.appTheme.appThemeData.transparent,
          child: Center(child: BaseDialogContent(builder: builder))),
    );
