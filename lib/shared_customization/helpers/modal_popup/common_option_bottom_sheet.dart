import 'package:flutter/material.dart';
import '/shared_customization/data/basic_types.dart';

class CommonOptionBottomSheet {
  final String title;
  final VoidCallback onTap;
  final String? svgIcon;
  final IconData? icon;
  final UpdateStyleCallBack? updateTitleStyle;
  final Color? iconColor;
  final double? iconSize;

  CommonOptionBottomSheet({
    required this.title,
    required this.onTap,
    this.svgIcon,
    this.icon,
    this.updateTitleStyle,
    this.iconColor,
    this.iconSize,
  });
}
