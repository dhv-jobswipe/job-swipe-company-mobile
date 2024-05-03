// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';

import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/app_common_data/common_data/global_variable.dart';

class CustomTextButton extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color? backgroundColor;
  final CustomText text;

  const CustomTextButton({
    super.key,
    this.padding = const EdgeInsets.all(8),
    this.margin = EdgeInsets.zero,
    required this.onPressed,
    this.onLongPress,
    this.backgroundColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: CustomContainer(
          padding: padding,
          margin: margin,
          borderRadius: BorderRadius.circular(BORDER_RADIUS_VALUE),
          color: backgroundColor,
          child: text),
    );
  }
}
