// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    super.key,
    this.padding = EdgeInsets.zero,
    this.value,
    required this.onChanged,
    this.activeColor,
    this.splashRadius,
    this.autofocus = false,
    this.focusNode,
  });
  final EdgeInsetsGeometry padding;
  final bool? value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final double? splashRadius;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool value = widget.value ?? false;

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return Padding(
      padding: widget.padding,
      child: Switch(
        value: value,
        trackOutlineWidth: const MaterialStatePropertyAll(0.5),
        onChanged: (value) {
          setState(() {
            this.value = value;
            widget.onChanged(value);
          });
        },
        activeColor: widget.activeColor ?? theme.icon_primary,
        focusNode: widget.focusNode,
        splashRadius: widget.splashRadius,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        autofocus: widget.autofocus,
      ),
    );
  }
}
