import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/generated/translations.g.dart';
import '/shared_customization/helpers/dialogs/content_widgets/base_dialog_content.dart';
import '/shared_customization/enums/button_type.dart';
import '/shared_customization/widgets/buttons/custom_button.dart';
import '/shared_customization/widgets/texts/custom_text.dart';

class ConfirmDialogContent extends BaseDialogContent {
  final String? title;
  final String? content;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  ConfirmDialogContent({
    super.key,
    this.title,
    this.content,
    this.onAccept,
    this.onReject,
  }) : super(builder: (context) {
          AppThemeData theme = context.appTheme.appThemeData;
          return Column(mainAxisSize: MainAxisSize.min, children: [
            CustomText(
              title ?? tr(LocaleKeys.CommonAction_Confirm),
              textAlign: TextAlign.center,
              color: theme.icon_primary,
              fontWeight: FontWeight.w500,
              size: 22,
            ),
            const SizedBox(height: 8),
            CustomText(
              content ?? "",
              textAlign: TextAlign.center,
              color: theme.text_normal,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomButton(
                    type: ButtonType.white,
                    label: tr(LocaleKeys.CommonAction_Cancel),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      onReject?.call();
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: CustomButton(
                    label: tr(LocaleKeys.CommonAction_Confirm),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      onAccept?.call();
                    },
                  ),
                ),
              ],
            ),
          ]);
        });
}
