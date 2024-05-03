// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/widgets/texts/custom_text.dart';

class CustomListTile extends StatelessWidget {
  final Widget? iconWidget;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final Widget? leading;
  final Widget? trailing;
  final String? title;
  final Widget? subTitle;
  final Widget? titleWidget;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final double leadingHorizontalSpace;
  final double subTitleSpace;
  final bool showBottomDivider;
  final CrossAxisAlignment crossAxisAlignment;

  const CustomListTile({
    super.key,
    this.iconWidget,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.leading,
    this.trailing,
    this.title,
    this.subTitle,
    this.titleWidget,
    this.onTap,
    this.contentPadding,
    this.margin,
    this.leadingHorizontalSpace = 12,
    this.subTitleSpace = 8,
    this.showBottomDivider = false,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return InkWell(
      onTap: onTap,
      child: Container(
        color: theme.transparent,
        margin: margin,
        padding: contentPadding ?? EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            if (icon != null || iconWidget != null) ...[
              iconWidget ??
                  Icon(
                    icon,
                    size: iconSize,
                    color: iconColor ?? theme.icon_primary,
                  ),
              const SizedBox(width: 4)
            ],
            if (leading != null) leading!,
            if ((icon ?? leading) != null)
              SizedBox(
                width: leadingHorizontalSpace,
              ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    titleWidget ?? CustomText(title),
                    if (subTitle != null)
                      SizedBox(
                        height: subTitleSpace,
                      ),
                    subTitle ?? const SizedBox.shrink()
                  ]),
            ),
            trailing ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
