// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/shared_customization/data/basic_types.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/widgets/custom_widgets/custom_field.dart';

class CustomFormField<T> extends FormField<T> {
  final String? label;
  final bool showLabelAndError;
  // For FormField
  final List<TypeValidation<T>> validations;
  final Widget Function(FormFieldState<T>) widgetBuilder;

  CustomFormField({
    super.key,
    this.label,
    super.initialValue,
    super.enabled,
    this.showLabelAndError = true,
    required this.validations,
    required this.widgetBuilder,
  }) : super(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (currentData) {
              return validations
                  .map((validateFunc) => validateFunc(currentData))
                  .firstWhere((element) => element.isNotEmptyOrNull,
                      orElse: () => null);
            },
            builder: (validator) => showLabelAndError
                ? CustomField(
                    label: label,
                    errorLabel: !validator.isValid ? validator.errorText : null,
                    isRequired: validations
                        .map((validateFunc) => validateFunc(null))
                        .any((element) => element.isNotEmptyOrNull),
                    child: widgetBuilder(validator),
                  )
                : widgetBuilder(validator));
}
