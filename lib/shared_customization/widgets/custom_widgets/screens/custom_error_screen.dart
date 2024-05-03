// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/shared_customization/widgets/buttons/custom_button.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/custom_layout.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/app_common_data/app_text_sytle.dart';
import '/generated/translations.g.dart';

class CustomErrorScreen extends StatelessWidget {
  final String errorMessage;
  const CustomErrorScreen({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      showAppBar: false,
      useSafeArea: false,
      body: LayoutBuilder(
        builder: (context, constraints) => CustomContainer(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(
              minHeight: constraints.maxHeight, minWidth: constraints.maxWidth),
          image: const DecorationImage(
            image: AssetImage("assets/images/error_background.png"),
            alignment: Alignment.center,
            fit: BoxFit.fill,
            opacity: 1,
            filterQuality: FilterQuality.high,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      "Oops!",
                      style: AppTextStyle.titleText,
                      size: 35,
                      textAlign: TextAlign.center,
                      padding: const EdgeInsets.only(bottom: 4),
                    ),
                    CustomText(
                      "Something went wrong at our end.",
                      size: 16,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      "Don't worry, it's not you -- it's us. Sorry about that.",
                      size: 16,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (kDebugMode) ...[
                      CustomText.error(
                        errorMessage,
                        style: AppTextStyle.error.copyWith(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                    ],
                    CustomButton(
                        label: tr(LocaleKeys.CommonAction_Back),
                        width: MediaQuery.of(context).size.width,
                        onPressed: Navigator.of(context).pop)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
