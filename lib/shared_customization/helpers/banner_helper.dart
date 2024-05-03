import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '/app_common_data/common_data/global_key_variable.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/texts/custom_text.dart';

enum BannerType { success, error, warning, info }

enum BannerPosition { top, bottom }

extension BannerExt on BannerType {
  Color get backgroundColor {
    AppThemeData theme =
        GlobalKeyVariable.navigatorState.currentContext!.appTheme.appThemeData;
    return {
      BannerType.success: theme.banner_success_bg,
      BannerType.error: theme.banner_error_bg,
      BannerType.warning: theme.banner_warning_bg,
      BannerType.info: theme.banner_info_bg,
    }[this]!;
  }

  IconData get icon => {
        BannerType.success: Icons.check_circle,
        BannerType.error: Icons.cancel,
        BannerType.info: Icons.info_rounded,
        BannerType.warning: Icons.error_rounded,
      }[this]!;

  Color get iconColor {
    AppThemeData theme =
        GlobalKeyVariable.navigatorState.currentContext!.appTheme.appThemeData;
    return {
      BannerType.success: theme.banner_success_icon,
      BannerType.error: theme.banner_error_icon,
      BannerType.info: theme.banner_info_icon,
      BannerType.warning: theme.banner_warning_icon,
    }[this]!;
  }

  Color get textColor {
    return {
      BannerType.success: Colors.black87,
      BannerType.error: Colors.black87,
      BannerType.warning: Colors.black87,
      BannerType.info: Colors.black87,
    }[this]!;
  }
}

extension BannerPositionExt on BannerPosition {
  Alignment get align => {
        BannerPosition.bottom: Alignment.bottomCenter,
        BannerPosition.top: Alignment.topCenter,
      }[this]!;
}

void showErrorBanner({
  required String content,
  int delayDurationInMilliseconds = 0,
}) async {
  if (delayDurationInMilliseconds > 0) {
    await Future.delayed(Duration(milliseconds: delayDurationInMilliseconds));
  }
  BotToast.showCustomNotification(
    toastBuilder: (cancelFunc) {
      return CustomBanner(
        content: content,
        bannerType: BannerType.error,
      );
    },
    align: BannerPosition.top.align,
    backButtonBehavior: BackButtonBehavior.ignore,
    animationDuration: const Duration(milliseconds: 300),
    animationReverseDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 2000),
  );
}

void showSuccessBanner({
  required String content,
  int delayDurationInMilliseconds = 0,
}) async {
  if (delayDurationInMilliseconds > 0) {
    await Future.delayed(Duration(milliseconds: delayDurationInMilliseconds));
  }
  BotToast.showCustomNotification(
    toastBuilder: (cancelFunc) {
      return CustomBanner(
        content: content,
        bannerType: BannerType.success,
      );
    },
    align: BannerPosition.top.align,
    backButtonBehavior: BackButtonBehavior.ignore,
    animationDuration: const Duration(milliseconds: 300),
    animationReverseDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 2000),
  );
}

void showWarningBanner({
  required String content,
  int delayDurationInMilliseconds = 0,
}) async {
  if (delayDurationInMilliseconds > 0) {
    await Future.delayed(Duration(milliseconds: delayDurationInMilliseconds));
  }
  BotToast.showCustomNotification(
    toastBuilder: (cancelFunc) {
      return CustomBanner(
        content: content,
        bannerType: BannerType.warning,
      );
    },
    align: BannerPosition.top.align,
    backButtonBehavior: BackButtonBehavior.ignore,
    animationDuration: const Duration(milliseconds: 300),
    animationReverseDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 2000),
  );
}

void showInfoBanner({
  required String content,
  int delayDurationInMilliseconds = 0,
}) async {
  if (delayDurationInMilliseconds > 0) {
    await Future.delayed(Duration(milliseconds: delayDurationInMilliseconds));
  }
  BotToast.showCustomNotification(
    toastBuilder: (cancelFunc) {
      return CustomBanner(
        content: content,
        bannerType: BannerType.info,
      );
    },
    align: BannerPosition.top.align,
    backButtonBehavior: BackButtonBehavior.ignore,
    animationDuration: const Duration(milliseconds: 300),
    animationReverseDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 2000),
  );
}

void showBottomBanner({
  required String content,
  BannerType bannerType = BannerType.info,
  BannerPosition bannerPosition = BannerPosition.bottom,
  int delayDurationInMilliseconds = 0,
}) async {
  if (delayDurationInMilliseconds > 0) {
    await Future.delayed(Duration(milliseconds: delayDurationInMilliseconds));
  }
  BotToast.showCustomNotification(
    toastBuilder: (cancelFunc) {
      return CustomBanner(
        content: content,
        bannerType: bannerType,
      );
    },
    align: bannerPosition.align,
    backButtonBehavior: BackButtonBehavior.ignore,
    animationDuration: const Duration(milliseconds: 300),
    animationReverseDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 2000),
  );
}

void showCustomBanner({
  required Widget widget,
  BannerPosition bannerPosition = BannerPosition.top,
  int delayDurationInMilliseconds = 0,
  int durationInMilliseconds = 2000,
  VoidCallback? onTap,
}) async {
  if (delayDurationInMilliseconds > 0) {
    await Future.delayed(Duration(milliseconds: delayDurationInMilliseconds));
  }
  BotToast.showCustomNotification(
    toastBuilder: (cancelFunc) => Material(
        color: Colors.transparent,
        elevation: 0,
        child: InkWell(
            onTap: () {
              cancelFunc();
              onTap?.call();
            },
            child: CustomBanner(child: widget))),
    align: bannerPosition.align,
    backButtonBehavior: BackButtonBehavior.ignore,
    animationDuration: const Duration(milliseconds: 300),
    animationReverseDuration: const Duration(milliseconds: 300),
    duration: Duration(milliseconds: durationInMilliseconds),
  );
}

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    super.key,
    this.content,
    this.bannerType,
    this.child,
  });
  final String? content;
  final BannerType? bannerType;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: bannerType?.backgroundColor ?? Colors.pinkAccent,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      child: child ??
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (bannerType != null)
                Icon(
                  bannerType!.icon,
                  size: 22,
                  color: bannerType!.iconColor,
                ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomText(
                  content,
                  size: 15,
                  color: bannerType?.textColor ?? Colors.white,
                ),
              )
            ],
          ),
    );
  }
}
