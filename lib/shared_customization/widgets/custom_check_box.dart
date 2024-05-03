// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';

class CustomCheckBox extends StatefulWidget {
  final String? label;
  final bool? value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final double? splashRadius;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final bool autofocus;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry padding;

  const CustomCheckBox({
    super.key,
    this.value,
    required this.onChanged,
    this.label,
    this.activeColor,
    this.checkColor,
    this.splashRadius,
    this.shape,
    this.side,
    this.autofocus = false,
    this.focusNode,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool value = widget.value ?? false;

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return Padding(
      padding: widget.padding,
      child: Checkbox(
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        value: value,
        onChanged: (value) {
          setState(() {
            this.value = value ?? false;
            widget.onChanged(value ?? false);
          });
        },
        activeColor: widget.activeColor ?? theme.icon_primary,
        checkColor: widget.checkColor,
        splashRadius: widget.splashRadius,
        shape: widget.shape ??
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2))),
        side: widget.side,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      ),
    );
  }
}
