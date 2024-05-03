// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';

class CustomEmoji extends StatelessWidget {
  const CustomEmoji({
    super.key,
    required this.isShow,
    required this.controller,
    this.height,
    this.width,
    this.bgColor,
    this.indicatorColor,
    this.iconColor,
    this.iconColorSelected,
    this.backspaceColor,
    this.onTapOutside,
    this.onEmojiSelected,
    this.onBackspacePressed,
  });
  final bool isShow;
  final double? height;
  final double? width;
  final Color? bgColor;
  final Color? indicatorColor;
  final Color? iconColor;
  final Color? iconColorSelected;
  final Color? backspaceColor;
  final VoidCallback? onTapOutside;
  final TextEditingController controller;
  final void Function(Category? category, Emoji emoji)? onEmojiSelected;
  final void Function()? onBackspacePressed;

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return Offstage(
      offstage: !isShow,
      child: TapRegion(
        onTapOutside: (event) => onTapOutside?.call(),
        child: SizedBox(
          height: height,
          width: width,
          child: EmojiPicker(
            textEditingController: controller,
            onEmojiSelected: onEmojiSelected,
            onBackspacePressed: () {
              controller
                ..text = controller.text.characters.toString()
                ..selection = TextSelection.fromPosition(
                    TextPosition(offset: controller.text.length));
              onBackspacePressed?.call();
            },
            config: Config(
              columns: 7,
              emojiSizeMax: 30 *
                  (foundation.defaultTargetPlatform == TargetPlatform.iOS
                      ? 1.30
                      : 1.0),
              verticalSpacing: 0,
              horizontalSpacing: 0,
              gridPadding: EdgeInsets.zero,
              initCategory: Category.SMILEYS,
              bgColor: bgColor ?? theme.white,
              indicatorColor: indicatorColor ?? theme.primary_dark_color,
              iconColor: iconColor ?? theme.icon_normal,
              iconColorSelected: iconColorSelected ?? theme.icon_primary,
              backspaceColor: theme.black,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              recentTabBehavior: RecentTabBehavior.RECENT,
              recentsLimit: 28,
              replaceEmojiOnLimitExceed: false,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ),
              loadingIndicator: const SizedBox.shrink(),
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
              checkPlatformCompatibility: true,
            ),
          ),
        ),
      ),
    );
  }
}
