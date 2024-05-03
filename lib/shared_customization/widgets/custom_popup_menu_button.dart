// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/data/basic_types.dart';
import '/app_common_data/common_data/global_variable.dart';
import '/app_common_data/app_text_sytle.dart';
import '/shared_customization/enums/divider_direction.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/widgets/custom_divider.dart';
import '/shared_customization/widgets/texts/custom_text.dart';

class PopupMenuItemModel<T> {
  T value;
  String label;
  Widget? icon;
  final UpdateStyleCallBack? onUpdateStyle;
  PopupMenuItemModel({
    required this.value,
    required this.label,
    this.onUpdateStyle,
    this.icon,
  });
}

class CustomPopUpMenuButton<T> extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Widget? child;
  final List<PopupMenuItemModel<T>> items;
  final OnItemTap<T> onItemSelected;
  final VoidCallback? disableTapping;
  final bool showDivider;

  const CustomPopUpMenuButton({
    super.key,
    this.icon = Icons.expand_more,
    this.iconColor,
    this.child,
    required this.items,
    required this.onItemSelected,
    this.showDivider = true,
    this.disableTapping,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    AppThemeData theme = context.appTheme.appThemeData;
    return GestureDetector(
      onTap: disableTapping,
      child: PopupMenuButton<T>(
          position: PopupMenuPosition.under,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BORDER_RADIUS_VALUE)),
          splashRadius: 20,
          onSelected: onItemSelected,
          enabled: disableTapping == null,
          onOpened: disableTapping,
          itemBuilder: (context) => items.asMap().entries.toList().fold(
              [],
              (previousValue, entry) => [
                    ...previousValue,
                    if (showDivider && entry.key > 0)
                      PopupMenuItem<T>(
                        enabled: false,
                        padding: EdgeInsets.zero,
                        height: 1,
                        child: const CustomDivider(
                            direction: DividerDirection.horizontal),
                      ),
                    PopupMenuItem<T>(
                      value: entry.value.value,
                      child: PopUpMenuItemWidget(
                        label: entry.value.label,
                        icon: entry.value.icon,
                        onUpdateStyle: entry.value.onUpdateStyle,
                      ),
                    ),
                  ]),
          child: child ??
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
                child: Icon(
                  Icons.expand_more,
                  color: iconColor ?? theme.icon_primary,
                  size: 24,
                ),
              )),
    );
  }
}

class PopUpMenuItemWidget extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final UpdateStyleCallBack? onUpdateStyle;

  const PopUpMenuItemWidget({
    required this.label,
    this.icon,
    this.onUpdateStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) icon!,
        if (icon != null) const SizedBox(width: 10),
        if (label.isNotEmptyOrNull)
          CustomText(
            label,
            style: onUpdateStyle?.call(AppTextStyle.defaultStyle) ??
                AppTextStyle.defaultStyle,
          ),
      ],
    );
  }
}
