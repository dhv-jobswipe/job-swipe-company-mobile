// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, invalid_use_of_protected_member, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/app_common_data/common_data/global_key_variable.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/enums/keyboard_type.dart';
import '/shared_customization/extensions/date_time_ext.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/helpers/utilizations/validators.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/custom_widgets/custom_field.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/app_common_data/app_text_sytle.dart';
import '/app_common_data/common_data/global_variable.dart';
import '/generated/translations.g.dart';
import '/generated/assets.gen.dart';

class CustomTextField extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final String? label;
  final TextEditingController? controller;
  final String? errorLabel;
  final String? placeholder;
  final ValueChanged<String> onChanged;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmit;
  final String? initValue;
  final KeyboardType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final bool autoTrim;
  final int? minLines;
  final int? maxLines;
  final bool isRequiredField;
  final Color? activeBorderColor;
  final Color? defaultBorderColor;
  final EdgeInsetsGeometry contentPadding;
  final FocusNode? focusNode;
  final BorderRadius borderRadius;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final bool autofocus;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final DateTime Function()? onGetFirstDate;
  final DateTime Function()? onGetLastDate;

  const CustomTextField({
    super.key,
    //
    this.padding = EdgeInsets.zero,
    this.label,
    this.controller,
    this.errorLabel,
    this.placeholder,
    required this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.onSubmit,
    this.initValue,
    this.keyboardType = KeyboardType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.autoTrim = true,
    this.minLines,
    this.maxLines,
    this.isRequiredField = true,
    this.activeBorderColor,
    this.defaultBorderColor,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
    this.focusNode,
    this.borderRadius =
        const BorderRadius.all(Radius.circular(BORDER_RADIUS_VALUE)),
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.backgroundColor,
    this.autofocus = false,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.onGetFirstDate,
    this.onGetLastDate,
    //
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController controller;
  late bool obscureText = widget.obscureText;
  Widget? suffixIconByKeyboardType;
  OutlineInputBorder? border;
  bool isDefaultSuffixIcon = false;
  bool isShowClearButton = false;
  late AppThemeData theme;

  @override
  void initState() {
    // Init app theme
    theme =
        GlobalKeyVariable.navigatorState.currentContext!.appTheme.appThemeData;

    // Init controller
    controller = widget.controller ?? TextEditingController();
    if (widget.initValue.isNotEmptyOrNull) {
      controller.value = TextEditingValue(text: widget.initValue!);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onChanged(widget.initValue!);
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme = context.appTheme.appThemeData;
    // Init border
    border = OutlineInputBorder(
        borderSide: BorderSide(
            width: 1, color: widget.defaultBorderColor ?? theme.border_primary),
        borderRadius: widget.borderRadius);

    // Init suffixIconByKeyboardType
    suffixIconByKeyboardType = _buildSuffixIconByKeyboardType();
    if (isDefaultSuffixIcon && !controller.hasListeners) {
      controller.addListener(() {
        if (isShowClearButton != controller.text.isNotEmptyOrNull) {
          setState(() {
            isShowClearButton = controller.text.isNotEmptyOrNull;
          });
        }
      });
    }
    return Padding(
      padding: widget.padding,
      child: CustomField(
        errorLabel: widget.errorLabel,
        label: widget.label,
        isRequired: widget.isRequiredField,
        child: CustomContainer(
          color: widget.enabled
              ? (widget.backgroundColor ?? theme.white)
              : theme.transparent,
          borderRadius: widget.borderRadius,
          child: TextField(
            autofocus: widget.autofocus,
            showCursor: !widget.readOnly,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            cursorColor: widget.activeBorderColor,
            controller: controller,
            style: widget.textStyle ?? AppTextStyle.defaultStyle,
            decoration: InputDecoration(
              errorText: widget.errorLabel.isNotEmptyOrNull ? '' : null,
              errorMaxLines: 1,
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              isDense: true,
              hintStyle: (widget.textStyle ?? AppTextStyle.defaultStyle)
                  .copyWith(color: theme.text_placeholder),
              hintText: widget.placeholder ??
                  tr(LocaleKeys.Placeholder_InputFieldPlaceholder, namedArgs: {
                    "fieldName": widget.label?.toLowerCase() ?? ''
                  }),
              contentPadding: widget.contentPadding,
              border: border!.copyWith(
                  borderRadius: widget.borderRadius,
                  borderSide: border!.borderSide.copyWith(
                      color: widget.errorLabel.isNotEmptyOrNull
                          ? theme.border_error
                          : border!.borderSide.color)),
              enabledBorder:
                  border!.copyWith(borderRadius: widget.borderRadius),
              errorBorder: border!.copyWith(
                  borderRadius: widget.borderRadius,
                  borderSide:
                      border!.borderSide.copyWith(color: theme.border_error)),
              focusedErrorBorder: border!.copyWith(
                  borderRadius: widget.borderRadius,
                  borderSide:
                      border!.borderSide.copyWith(color: theme.border_error)),
              focusedBorder: border!.copyWith(
                  borderRadius: widget.borderRadius,
                  borderSide: widget.readOnly
                      ? border!.borderSide
                      : border!.borderSide.copyWith(
                          color:
                              widget.activeBorderColor ?? theme.border_focus)),
              prefixIcon: widget.prefixIcon != null
                  ? Align(alignment: Alignment.center, child: widget.prefixIcon)
                  : null,
              suffixIcon: Builder(builder: (context) {
                if (widget.suffixIcon != null) {
                  return Align(
                      alignment: Alignment.center, child: widget.suffixIcon);
                }
                if (suffixIconByKeyboardType != null && !isDefaultSuffixIcon) {
                  return suffixIconByKeyboardType!;
                }
                if (widget.obscureText) {
                  return InkWell(
                    onTap: () => setState(() => obscureText = !obscureText),
                    child: Align(
                        alignment: Alignment.center,
                        child: obscureText
                            ? Assets.icons.icEye.svg(
                                color: theme.icon_primary,
                                width: 22,
                                height: 22)
                            : Assets.icons.icEyeSlash.svg(
                                color: theme.icon_primary,
                                width: 22,
                                height: 22)),
                  );
                }
                return isShowClearButton
                    ? suffixIconByKeyboardType!
                    : EMPTY_WIDGET;
              }),
              prefixIconConstraints: widget.prefixIconConstraints ??
                  const BoxConstraints(maxHeight: 42, maxWidth: 56),
              suffixIconConstraints: widget.suffixIconConstraints ??
                  const BoxConstraints(maxHeight: 42, maxWidth: 56),
            ),
            onChanged: (value) {
              widget.autoTrim
                  ? widget.onChanged.call(value.trim())
                  : widget.onChanged(value);
            },
            textInputAction: widget.textInputAction,
            onSubmitted: widget.onSubmit ??
                (widget.keyboardType == KeyboardType.visiblePassword &&
                        widget.textInputAction == TextInputAction.newline
                    ? (_) {
                        FocusScope.of(context).nextFocus();
                      }
                    : null),
            keyboardType: widget.keyboardType.inputType,
            obscureText: obscureText,
            obscuringCharacter: "•",
            minLines: widget.minLines,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            inputFormatters: [
              ///
              /// phone number
              ///
              if (widget.keyboardType == KeyboardType.phone)
                // FilteringTextInputFormatter.allow(RegExp(r'[0-9*#+() .-]+')),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9+() .-]+')),

              ///
              /// int number
              ///
              if (widget.keyboardType == KeyboardType.int)
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]+')),

              ///
              /// double number
              ///
              if (widget.keyboardType == KeyboardType.double)
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]+')),

              ///
              /// money number
              ///
              if (widget.keyboardType == KeyboardType.money)
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]+')),
            ],
            focusNode: widget.focusNode,
            enabled: widget.enabled,
          ),
        ),
      ),
    );
  }

  Widget _buildSuffixIcon({VoidCallback? onTap, required Widget child}) =>
      GestureDetector(
          onTap: onTap,
          child: Align(alignment: Alignment.center, child: child));

  Widget? _buildSuffixIconByKeyboardType() {
    switch (widget.keyboardType) {
      case KeyboardType.datetime:
        return _buildSuffixIcon(
            onTap: () async {
              final currentLocale = Localizations.localeOf(context);
              DateTime? initialDate;
              DateTime lastDate =
                  widget.onGetLastDate?.call() ?? DateTime.now();
              DateTime firstDate =
                  widget.onGetFirstDate?.call() ?? DateTime(1900);
              try {
                if (Validators.validateDateTimeFormat(controller.text)
                    .isEmptyOrNull) {
                  // initialDate =
                  //     controller.text.toDateTime(locale: currentLocale) ??
                  //         DateTime.now();
                } else {
                  initialDate = DateTime.now();
                }
              } catch (err) {
                initialDate = DateTime.now();
              }
              DateTime? dateTime = await showDatePicker(
                  locale: currentLocale,
                  context: context,
                  initialDate: initialDate,
                  firstDate:
                      firstDate.isBefore(lastDate) ? firstDate : lastDate,
                  lastDate: firstDate.isBefore(lastDate) ? lastDate : firstDate,
                  helpText: '',
                  builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                        primary: theme.primary_color,
                        onPrimary: theme.white,
                        onSurface: theme.black,
                      )),
                      child: Container(child: child)),
                  cancelText: tr(LocaleKeys.CommonAction_Cancel),
                  confirmText: tr(LocaleKeys.CommonAction_Confirm),
                  errorFormatText:
                      tr(LocaleKeys.CommonValidation_DateTimeFormatIsInvalid),
                  errorInvalidText:
                      tr(LocaleKeys.CommonValidation_DateTimeFormatIsInvalid));
              if (dateTime != null) {
                widget
                    .onChanged(dateTime.toDayMonthYear(locale: currentLocale));
                controller.text =
                    dateTime.toDayMonthYear(locale: currentLocale);
              }
            },
            child: Icon(Icons.calendar_month_rounded,
                size: 24, color: theme.icon_primary));
      case KeyboardType.datetimeHour:
        return _buildSuffixIcon(
            onTap: () async {
              final currentLocale = Localizations.localeOf(context);
              DateTime? initialDate;
              DateTime lastDate =
                  widget.onGetLastDate?.call() ?? DateTime.now();
              DateTime firstDate =
                  widget.onGetFirstDate?.call() ?? DateTime(1900);
              try {
                if (Validators.validateDateTimeFormat(controller.text)
                    .isEmptyOrNull) {
                  // initialDate =
                  //     controller.text.toDateTime(locale: currentLocale) ??
                  //         DateTime.now();
                } else {
                  initialDate = DateTime.now();
                }
              } catch (err) {
                initialDate = DateTime.now();
              }
              DateTime? dateTime = await showDatePicker(
                  locale: currentLocale,
                  context: context,
                  initialDate: initialDate,
                  firstDate:
                      firstDate.isBefore(lastDate) ? firstDate : lastDate,
                  lastDate: firstDate.isBefore(lastDate) ? lastDate : firstDate,
                  helpText: '',
                  builder: (context, child) => Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                          primary: theme.primary_color,
                          onPrimary: theme.white,
                          onSurface: theme.black,
                        )),
                        child: Container(
                          child: child,
                        ),
                      ),
                  cancelText: tr(LocaleKeys.CommonAction_Cancel),
                  confirmText: tr(LocaleKeys.CommonAction_Confirm),
                  errorFormatText:
                      tr(LocaleKeys.CommonValidation_DateTimeFormatIsInvalid),
                  errorInvalidText:
                      tr(LocaleKeys.CommonValidation_DateTimeFormatIsInvalid));
              if (dateTime != null) {
                widget
                    .onChanged(dateTime.toDayMonthYear(locale: currentLocale));
                controller.text =
                    dateTime.toDayMonthYear(locale: currentLocale);
                TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialEntryMode: TimePickerEntryMode.inputOnly,
                    initialTime: const TimeOfDay(hour: 7, minute: 0));
                if (timeOfDay != null) {}
              }
            },
            child: Icon(Icons.calendar_month_rounded,
                size: 24, color: theme.icon_primary));
      case KeyboardType.phone:
        return _buildSuffixIcon(
            child: Icon(Icons.phone_enabled_rounded,
                size: 22, color: theme.icon_primary));
      case KeyboardType.money:
        return _buildSuffixIcon(
            child: CustomText(CURRENCY,
                color: theme.icon_primary, fontWeight: FontWeight.w600));
      default:
        if (!obscureText && !widget.readOnly) {
          isDefaultSuffixIcon = true;
          return _buildSuffixIcon(
              onTap: () {
                controller.clear();
                widget.onChanged('');
              },
              child: Icon(Icons.close, size: 22, color: theme.icon_primary));
        }
    }
    return null;
  }
}
