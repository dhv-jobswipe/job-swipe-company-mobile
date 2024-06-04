// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/shared_customization/widgets/buttons/custom_icon_button.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/custom_widgets/custom_field.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/shared_customization/data/basic_types.dart';

class DropdownItemModel<T> {
  final T? value;
  final bool enable;
  final String label;

  DropdownItemModel({
    required this.value,
    required this.label,
    this.enable = true,
  });
}

class CustomDropdownButton<T> extends StatelessWidget {
  final ValueChanged<T?>? onChanged;
  final T? value;
  final List<DropdownItemModel<T>> items;
  final bool Function(T? item) selectedCondition;
  final ItemRenderCallBack<T?>? itemDisplayBuilder;
  final ItemRenderCallBack<T?>? itemDropdownBuilder;
  final ItemRenderCallBack<T?>? selectedItemBuilder;
  final String? label;
  final String? errorLabel;
  final String? placeholder;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? icon;
  final bool? isExpanded;
  final double radius;
  final bool isRequired;
  final Color? borderColor;
  final double? placeholderSize;
  final Color? backgroundColor;
  final VoidCallback? onDeleteTap;
  final bool isShowDeleteIcon;
  final bool isShowDivider;
  final Color? textColor;

  const CustomDropdownButton({
    super.key,
    required this.onChanged,
    required this.value,
    required this.items,
    required this.selectedCondition,
    this.selectedItemBuilder,
    this.itemDropdownBuilder,
    this.itemDisplayBuilder,
    this.label,
    this.errorLabel,
    this.placeholder,
    this.padding,
    this.margin,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
    this.icon,
    this.isExpanded = true,
    this.radius = 6,
    this.isRequired = true,
    this.borderColor,
    this.placeholderSize = 14,
    this.backgroundColor,
    this.onDeleteTap,
    this.isShowDeleteIcon = false,
    this.isShowDivider = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return Column(
      children: [
        Container(
          margin: margin,
          padding: padding,
          color: theme.transparent,
          child: CustomField(
            isShowError: false,
            errorLabel: errorLabel,
            label: label,
            isRequired: isRequired,
            child: CustomContainer(
              padding: contentPadding ?? EdgeInsets.zero,
              color: backgroundColor ?? theme.bg_field,
              border: Border.all(
                  color: errorLabel != null
                      ? theme.border_error
                      : borderColor ?? theme.border_primary,
                  width: 1),
              borderRadius: BorderRadius.circular(radius),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  icon: isShowDeleteIcon
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            icon ??
                                Icon(Icons.keyboard_arrow_down_rounded,
                                    size: 28,
                                    color: textColor ?? Colors.black87),
                            CustomIconButton(
                              onPressed: onDeleteTap,
                              icon: Icons.delete_forever_sharp,
                              color: Colors.red,
                              size: 25,
                            ),
                          ],
                        )
                      : icon ??
                          Icon(Icons.keyboard_arrow_down_rounded,
                              size: 28, color: textColor ?? Colors.black87),
                  padding: EdgeInsets.zero,
                  value: value,
                  onChanged: onChanged,
                  hint: CustomText(placeholder,
                      color: orangePink, size: placeholderSize!),
                  items: [
                    DropdownMenuItem<T>(
                      enabled: false,
                      value: null,
                      child: CustomText(placeholder,
                          color: theme.text_placeholder),
                    ),
                    ...items.map((item) {
                      if (item.value != null && selectedCondition(item.value)) {
                        return DropdownMenuItem<T>(
                          enabled: item.enable,
                          value: item.value,
                          child: selectedItemBuilder?.call(item.value) ??
                              CustomText(
                                item.label,
                                color: orangePink,
                                fontWeight: FontWeight.w600,
                              ),
                        );
                      }
                      return DropdownMenuItem<T>(
                        enabled: item.enable,
                        value: item.value,
                        child: itemDropdownBuilder?.call(item.value) ??
                            CustomText(
                              item.label,
                              color: theme.text_title,
                            ),
                      );
                    }).toList()
                  ],
                  selectedItemBuilder: (context) => [
                    const SizedBox.shrink(),
                    ...items.map((item) {
                      if (!item.enable) return const SizedBox.shrink();
                      return itemDisplayBuilder?.call(item.value) ??
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item.label,
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ));
                    }).toList()
                  ],
                  elevation: 2,
                  isExpanded: isExpanded!,
                  dropdownColor: theme.bg_dropdown,
                ),
              ),
            ),
          ),
        ),
        if (isShowDivider)
          Divider(
            color: Colors.black54,
            height: 1,
          ),
      ],
    );
  }
}
