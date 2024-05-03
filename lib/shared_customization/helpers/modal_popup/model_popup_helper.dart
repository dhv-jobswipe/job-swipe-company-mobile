// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/widgets/custom_container.dart';
import 'package:pbl5/shared_customization/widgets/custom_list_tile.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/helpers/modal_popup/common_option_bottom_sheet.dart';
import '/app_common_data/app_text_sytle.dart';
import '/app_common_data/common_data/global_key_variable.dart';

Future<BuildContext> _getContext() async {
  await Future.doWhile(
      () => GlobalKeyVariable.navigatorState.currentContext == null);
  return GlobalKeyVariable.navigatorState.currentContext!;
}

Future<T?> showCommonOptionBottomSheet<T>(List<CommonOptionBottomSheet> options,
    {bool withCancelOption = false}) async {
  var context = await _getContext();
  return showModalBottomSheet<T>(
    context: context,
    useSafeArea: false,
    barrierColor: const Color.fromRGBO(32, 41, 57, 0.50),
    builder: (_) {
      return Material(
        color: Colors.transparent,
        child: CustomContainer(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          color: Colors.white,
          child: Wrap(
            runSpacing: 8,
            children: [
              ...[
                ...options,
                if (withCancelOption)
                  CommonOptionBottomSheet(
                      title: "Cancel", onTap: () {}, icon: Icons.cancel)
              ]
                  .map((e) => CustomListTile(
                        leadingHorizontalSpace: 8,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        onTap: () {
                          e.onTap();
                          _.pop();
                        },
                        icon: e.icon,
                        leading: e.svgIcon.isNotEmptyOrNull
                            ? SvgPicture.asset(e.svgIcon!,
                                width: 24, height: 24)
                            : null,
                        iconColor: e.iconColor ?? Colors.pink,
                        iconSize: e.iconSize ?? 24,
                        titleWidget: CustomText(
                          e.title,
                          style:
                              e.updateTitleStyle?.call(AppTextStyle.bodyText) ??
                                  AppTextStyle.bodyText,
                          size: 16,
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
      );
    },
  );
}
