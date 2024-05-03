// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/custom_divider.dart';
import '/shared_customization/widgets/custom_list_tile.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/shared_customization/data/basic_types.dart';
import '/app_common_data/app_text_sytle.dart';
import '/generated/translations.g.dart';

class DrawerModel {
  final String label;
  final IconData? icon;
  final String? svgUrl;
  final VoidCallback? onPressed;
  final bool showBottomDivider;
  final UpdateStyleCallBack? onStyleUpdate;

  DrawerModel({
    required this.label,
    this.onPressed,
    this.icon,
    this.svgUrl,
    this.showBottomDivider = false,
    this.onStyleUpdate,
  });
}

class CustomDrawer extends StatelessWidget {
  final double? drawerWidth;
  final Widget? drawerHeader;
  final Widget? drawerFooter;
  final List<DrawerModel> items;
  final Color? backgroundColor;
  final String? title;
  final IconData? closeIcon;
  final ScrollPhysics? scrollPhysics;
  final VoidCallback? onSignOut;
  final TextStyle? textStyle;

  const CustomDrawer({
    super.key,
    this.drawerWidth,
    this.drawerHeader,
    this.drawerFooter,
    required this.items,
    this.backgroundColor,
    this.title,
    this.closeIcon,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
    this.onSignOut,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(),
        width: drawerWidth,
        backgroundColor: backgroundColor ?? theme.drawer_bg,
        child: Column(
          children: [
            drawerHeader ??
                CustomContainer(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(title ?? tr(LocaleKeys.CommonData_Menu),
                            size: 18,
                            fontWeight: FontWeight.w600,
                            color: theme.drawer_header_text),
                        GestureDetector(
                          onTap: Navigator.of(context).pop,
                          child: Icon(
                            closeIcon ?? Icons.close,
                            size: 24,
                            color: theme.drawer_header_icon,
                          ),
                        ),
                      ],
                    )),
            Expanded(
                child: ListView(
              physics: scrollPhysics,
              children: [
                CustomContainer(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: theme.drawer_body_bg,
                  child: Wrap(
                    runSpacing: 8,
                    children: items
                        .map((e) => Column(
                              children: [
                                CustomListTile(
                                  iconWidget: e.svgUrl.isNotEmptyOrNull
                                      ? SvgPicture.asset(e.svgUrl!)
                                      : null,
                                  icon: e.icon,
                                  leadingHorizontalSpace: 10,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  titleWidget: CustomText(
                                    e.label,
                                    style: (e.onStyleUpdate?.call(
                                            AppTextStyle.defaultStyle)) ??
                                        ((textStyle ??
                                                AppTextStyle.defaultStyle)
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                  ),
                                  onTap: () {
                                    context.pop();
                                    e.onPressed?.call();
                                  },
                                ),
                                if (e.showBottomDivider)
                                  const CustomDivider.horizontal(thinkness: 1),
                              ],
                            ))
                        .toList(),
                  ),
                )
              ],
            )),
            drawerFooter ??
                CustomContainer(
                  color: theme.drawer_footer_bg,
                  padding: const EdgeInsets.all(50),
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                      onSignOut?.call();
                    },
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.power_settings_new,
                                  color: theme.drawer_footer_icon,
                                ),
                                const SizedBox(width: 12),
                                CustomText(tr(LocaleKeys.CommonAction_Logout),
                                    size: 16,
                                    fontWeight: FontWeight.w600,
                                    color: theme.drawer_footer_text),
                              ]),
                        ],
                      ),
                    ),
                  ),
                )
          ],
        ),
      ),
    );
  }
}
