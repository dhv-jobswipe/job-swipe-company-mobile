// ignore_for_file: deprecated_member_use_from_same_package

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/generated/assets.gen.dart';
import '/shared_customization/helpers/dialogs/content_widgets/base_dialog_content.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/generated/translations.g.dart';

class ErrorDialogContent extends BaseDialogContent {
  final String? title;
  final String? content;
  ErrorDialogContent({
    super.key,
    this.title,
    this.content,
  }) : super(builder: (context) {
          AppThemeData theme = context.appTheme.appThemeData;
          return Stack(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.icons.icErrorDialog.svg(color: theme.text_error),
                    CustomText(
                      title ?? tr(LocaleKeys.CommonData_Error),
                      color: theme.text_error,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      size: 22,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    CustomText(
                      content ?? tr(LocaleKeys.CommonData_HasErrorOccurr),
                      color: theme.text_normal,
                      textAlign: TextAlign.center,
                      size: 14,
                    ),
                    CustomContainer(
                      color: theme.transparent,
                      child: SizedBox(
                          height: 0.5,
                          width: MediaQuery.of(context).size.width),
                    )
                  ]),
              Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Assets.icons.icX.svg(),
                  ))
            ],
          );
        });
}
