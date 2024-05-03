// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/extensions/list_ext.dart';
import '/shared_customization/widgets/custom_check_box.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/shared_customization/data/basic_types.dart';
import '/app_common_data/app_text_sytle.dart';

class RadioButtonModel<T> {
  final String label;
  final T value;
  final UpdateStyleCallBack? onUpdateStyle;

  RadioButtonModel({
    required this.label,
    required this.value,
    this.onUpdateStyle,
  });
}

class CustomRadioButton<T> extends StatefulWidget {
  final ValueChanged<T>? onChanged;
  final IdentifyCallBack<T> identify;
  final List<RadioButtonModel<T>> items;
  final double space;
  final double runSpace;
  final EdgeInsetsGeometry? contentPadding;

  const CustomRadioButton({
    super.key,
    required this.onChanged,
    required this.identify,
    required this.items,
    this.space = 8,
    this.runSpace = 0,
    this.contentPadding,
  });

  @override
  State<CustomRadioButton<T>> createState() => _CustomRadioButtonState<T>();
}

class _CustomRadioButtonState<T> extends State<CustomRadioButton<T>> {
  T? selectedItem;

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    if (widget.items.isEmptyOrNull) return const SizedBox.shrink();
    return Wrap(
      runSpacing: widget.runSpace,
      children: widget.items
          .map(
            (e) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedItem = e.value;
                  widget.onChanged?.call(e.value);
                });
              },
              child: CustomContainer(
                color: theme.transparent,
                padding: widget.contentPadding ??
                    const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomCheckBox(
                        value: widget.identify(selectedItem) ==
                            widget.identify(e.value),
                        padding: EdgeInsets.only(right: widget.space),
                        onChanged: (_) {
                          setState(() {
                            selectedItem = e.value;
                            widget.onChanged?.call(e.value);
                          });
                        }),
                    Expanded(
                        child: CustomText(
                      e.label,
                      style: e.onUpdateStyle?.call(AppTextStyle.defaultStyle) ??
                          AppTextStyle.defaultStyle,
                    ))
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
