// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/enums/button_type.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/generated/translations.g.dart';
import '/app_common_data/app_text_sytle.dart';
import '/app_common_data/common_data/global_variable.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  ButtonType type;
  final Color? color;
  final Color? labelColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String? label;
  final Widget? child;
  final BorderSide? borderSide;
  final BorderRadius? radius;
  final FocusNode? focusNode;
  final bool autofocus;
  final Alignment contentAlignment;
  final Duration? duration;
  final Duration? periodicDuration;
  final String Function(int currentMilliseconds)? countDownText;

  CustomButton({
    super.key,
    this.type = ButtonType.primary,
    this.color,
    this.labelColor,
    this.width,
    this.height,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    this.margin = EdgeInsets.zero,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.child,
    this.borderSide,
    this.radius,
    this.focusNode,
    this.autofocus = false,
    this.contentAlignment = Alignment.center,
  })  : duration = null,
        periodicDuration = null,
        countDownText = null {
    if (onPressed == null) type = ButtonType.disable;
  }

  CustomButton.resend({
    super.key,
    this.type = ButtonType.primary,
    this.color,
    this.labelColor,
    this.width,
    this.height,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    this.margin = EdgeInsets.zero,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.borderSide,
    this.radius,
    this.focusNode,
    this.autofocus = false,
    this.contentAlignment = Alignment.center,
    required Duration duration,
    required Duration periodicDuration,
    required this.countDownText,
  })  : duration = duration,
        periodicDuration = periodicDuration,
        child = null {
    if (onPressed == null) type = ButtonType.disable;
  }

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  Timer? timer;
  bool isCounting = false;
  int durationInMilliseconds = 0;
  int periodicDurationInMilliseconds = 0;
  late ButtonType type = widget.type;

  @override
  void initState() {
    if (widget.duration != null && widget.periodicDuration != null) {
      durationInMilliseconds = widget.duration!.inMilliseconds;
      periodicDurationInMilliseconds = widget.periodicDuration!.inMilliseconds;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _startTimer();
      });
    }
    super.initState();
  }

  void _startTimer() {
    if (durationInMilliseconds != 0 && periodicDurationInMilliseconds != 0) {
      setState(() {
        isCounting = true;
        type = ButtonType.disable;
        timer = Timer.periodic(widget.periodicDuration!, (timer) {
          setState(() {
            durationInMilliseconds -= periodicDurationInMilliseconds;
            if (durationInMilliseconds == 0) _stopTimer();
          });
        });
      });
    }
  }

  void _stopTimer() {
    if (timer != null) {
      timer!.cancel();
      setState(() {
        isCounting = false;
        timer = null;
        type = widget.type;
        durationInMilliseconds = widget.duration!.inMilliseconds;
        periodicDurationInMilliseconds =
            widget.periodicDuration!.inMilliseconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return CustomContainer(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      child: ElevatedButton(
        onPressed: () {
          if (isCounting) return;
          widget.onPressed?.call();
          if (widget.duration != null && widget.periodicDuration != null) {
            _startTimer();
          }
        },
        onLongPress: widget.onLongPress,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        style: ElevatedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 0,
            padding: widget.contentPadding,
            minimumSize: const Size(16, 40),
            alignment: widget.contentAlignment,
            shadowColor: theme.transparent,
            backgroundColor: widget.color ?? type.backgroundColor,
            foregroundColor: widget.color ?? type.backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius:
                    widget.radius ?? BorderRadius.circular(BORDER_RADIUS_VALUE),
                side: widget.borderSide ??
                    BorderSide(width: 1, color: type.borderColor))),
        child: widget.child ??
            CustomText(
              isCounting
                  ? widget.countDownText?.call(durationInMilliseconds) ??
                      tr(LocaleKeys.CommonAction_Confirm)
                  : widget.label ?? tr(LocaleKeys.CommonAction_Confirm),
              style: AppTextStyle.buttonText.copyWith(color: type.textColor),
            ),
      ),
    );
  }
}
