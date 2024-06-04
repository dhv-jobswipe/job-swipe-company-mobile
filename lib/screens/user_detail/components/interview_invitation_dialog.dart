import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/app_text_sytle.dart';
import 'package:pbl5/app_common_data/common_data/global_variable.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/generated/translations.g.dart';
import 'package:pbl5/models/application_position/application_position.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/date_time_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/validators.dart';
import 'package:pbl5/shared_customization/widgets/buttons/custom_button.dart';
import 'package:pbl5/shared_customization/widgets/custom_container.dart';
import 'package:pbl5/shared_customization/widgets/custom_drop_down_button.dart';
import 'package:pbl5/shared_customization/widgets/form_fields/custom_form.dart';
import 'package:pbl5/shared_customization/widgets/form_fields/custom_form_field.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';

class InterviewInvitationDialog extends StatefulWidget {
  InterviewInvitationDialog({
    Key? key,
    required this.onConfirm,
    required this.applicationPositions,
  }) : super(key: key);
  final List<ApplicationPosition> applicationPositions;
  final Function(String interviewDate, String interviewPositionId) onConfirm;

  @override
  State<InterviewInvitationDialog> createState() =>
      _InterviewInvitationDialogState();
}

class _InterviewInvitationDialogState extends State<InterviewInvitationDialog> {
  late ValueNotifier<String> interviewPositionId;
  late String interviewDate;

  void initState() {
    super.initState();
    interviewPositionId = ValueNotifier(
        widget.applicationPositions.first.applyPosition!.constantId!);
    interviewDate = DateTime.now().toDayMonthYear(withHour: true);
  }

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      child: (formKey) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            "Interview invitation",
            style: AppTextStyle.titleText,
            size: 18,
            padding: const EdgeInsets.only(bottom: 4),
          ),
          CustomText(
            "Please select the interview date and position in order to send the invitation.",
            style: AppTextStyle.bodyText,
            color: Colors.grey.shade600,
            size: 14,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomFormField<String>(
                  showLabelAndError: false,
                  validations: [
                    (data) => Validators.validateNotEmptyListOrString(data,
                        fieldName: "Interview date"),
                  ],
                  initialValue: interviewDate,
                  widgetBuilder: (p0) => GestureDetector(
                    onTap: () async {
                      DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: interviewDate.toDateTime,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 10000)),
                          helpText: "Select interview date",
                          cancelText: tr(LocaleKeys.CommonAction_Cancel),
                          confirmText: tr(LocaleKeys.CommonAction_Confirm),
                          errorFormatText: tr(LocaleKeys
                              .CommonValidation_DateTimeFormatIsInvalid),
                          errorInvalidText: tr(LocaleKeys
                              .CommonValidation_DateTimeFormatIsInvalid));
                      if (dateTime != null) {
                        TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialEntryMode: TimePickerEntryMode.inputOnly,
                            initialTime: const TimeOfDay(hour: 7, minute: 0));
                        if (timeOfDay != null) {
                          dateTime = dateTime.add(Duration(
                              hours: timeOfDay.hour,
                              minutes: timeOfDay.minute));
                        }
                        setState(() {
                          interviewDate =
                              dateTime.toDayMonthYear(withHour: true);
                          p0.didChange(interviewDate);
                        });
                      }
                    },
                    child: CustomContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 15),
                      borderRadius: BorderRadius.circular(8),
                      color: orangePink,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_month_rounded,
                              color: Colors.white, size: 21),
                          CustomText(
                            interviewDate,
                            style: AppTextStyle.bodyText,
                            size: 15,
                            color: Colors.white,
                            padding: const EdgeInsets.only(left: 3),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomFormField<String>(
                  showLabelAndError: false,
                  validations: [
                    (data) => Validators.validateNotEmptyListOrString(data,
                        fieldName: "Interview position"),
                  ],
                  initialValue: interviewPositionId.value,
                  widgetBuilder: (p0) {
                    return ValueListenableBuilder(
                      valueListenable: interviewPositionId,
                      builder: (context, value, child) {
                        return CustomDropdownButton<String>(
                            placeholder: "Position",
                            textColor: Colors.white,
                            icon: EMPTY_WIDGET,
                            borderColor: Colors.transparent,
                            isShowDivider: false,
                            onChanged: (value) {
                              if (value.isEmptyOrNull) return;
                              interviewPositionId.value = value!;
                              p0.didChange(value);
                            },
                            backgroundColor: orangePink,
                            value: value,
                            items: widget.applicationPositions
                                .map((e) => DropdownItemModel(
                                    value: e.applyPosition!.constantId,
                                    label: e.applyPosition!.constantName!))
                                .toList(),
                            selectedCondition: (item) =>
                                item == interviewPositionId);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomButton(
            onPressed: () {
              if (formKey.currentState?.validate() == true &&
                  interviewDate.isNotEmptyOrNull &&
                  interviewPositionId.value.isNotEmptyOrNull) {
                widget.onConfirm(interviewDate, interviewPositionId.value);
                context.pop();
              }
            },
            color: Colors.transparent,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.send_rounded, color: orangePink),
                const SizedBox(width: 8),
                CustomText(
                  "Send mail to candidate",
                  style: AppTextStyle.bodyText,
                  size: 15,
                  color: orangePink,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
