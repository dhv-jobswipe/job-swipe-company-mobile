import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/generated/assets.gen.dart';
import '/generated/translations.g.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/shared_customization/helpers/dialogs/content_widgets/base_dialog_content.dart';

class FeaturePendingDialogContent extends BaseDialogContent {
  FeaturePendingDialogContent({super.key})
      : super(builder: (context) {
          AppThemeData theme = context.appTheme.appThemeData;
          return Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.update_rounded,
                    size: 50,
                    color: theme.icon_primary,
                  ),
                  CustomText(
                    tr(LocaleKeys.CommonData_FeaturePending),
                    color: theme.text_title,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    size: 22,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  CustomContainer(
                    color: theme.transparent,
                    child: SizedBox(
                        height: 0.5, width: MediaQuery.of(context).size.width),
                  )
                ],
              ),
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
