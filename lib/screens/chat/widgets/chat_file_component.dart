import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pbl5/app_common_data/common_data/global_variable.dart';
import 'package:pbl5/models/file_content/file_content.dart';
import 'package:pbl5/routes.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/banner_helper.dart';
import 'package:pbl5/shared_customization/helpers/common_helper.dart';
import 'package:pbl5/shared_customization/helpers/modal_popup/common_option_bottom_sheet.dart';
import 'package:pbl5/shared_customization/helpers/modal_popup/model_popup_helper.dart';
import 'package:pbl5/shared_customization/widgets/custom_container.dart';
import 'package:pbl5/shared_customization/widgets/custom_list_tile.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_image.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/screens/custom_image_full_screen.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import 'package:uuid/uuid.dart';
import '/generated/assets.gen.dart';

class ChatFileComponent extends StatelessWidget {
  const ChatFileComponent({
    super.key,
    this.fileUrl,
    this.localFile,
    this.bgColor,
    this.textColor,
    this.size = 120,
    this.index = 0,
    this.overList = false,
    this.overListCount = 0,
  });
  final int index;
  final String? fileUrl;
  final File? localFile;
  final Color? bgColor;
  final Color? textColor;
  final double size;
  final bool overList;
  final int overListCount;

  @override
  Widget build(BuildContext context) {
    if (fileUrl != null) {
      return GestureDetector(
        onTap: () {
          if (fileUrl!.isImage) {
            context.pushNamed(Routes.imageFullScreen,
                arguments: CustomImageFullScreenParams(files: [
                  FileContent(
                      id: const Uuid().v4(), url: fileUrl!, name: fileName)
                ], initIndex: 0));
            return;
          }
          if (fileUrl!.isVideo) {
            context.pushNamed(Routes.videoScreen,
                arguments: FileContent(
                  id: const Uuid().v4(),
                  url: fileUrl!,
                  name: fileName,
                ));
          }
        },
        child: _buildFileItem(fileUrl!, size),
      );
    }
    return EMPTY_WIDGET;
  }

  Widget _buildFileItem(String fileUrl, double size) {
    if (overList && overListCount > 0) {
      return CustomContainer(
        padding: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        color: Colors.black.withOpacity(0.6),
        height: size,
        width: size,
        alignment: Alignment.center,
        child: CustomText(
          '+${overListCount + 1}',
          size: 16,
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    if (fileName.isImage) {
      return CustomImage.avatar(
        size: size,
        url: fileUrl,
        borderRadius: BorderRadius.circular(8),
      );
    }
    if (fileName.isVideo) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Assets.images.videoThumbnail.image(
          height: size,
          width: size,
          fit: BoxFit.cover,
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        showCommonOptionBottomSheet([
          CommonOptionBottomSheet(
              icon: FontAwesomeIcons.fileArrowDown,
              title: "Download file",
              onTap: () {
                CommonHelper.downloadFile(fileUrl, fileName).then((_) {
                  showSuccessBanner(
                      content: "Downloaded $fileName file successfully");
                });
              }),
        ]);
      },
      child: CustomContainer(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        borderRadius: BorderRadius.circular(8),
        color: bgColor ?? Colors.transparent,
        child: CustomListTile(
          leading: CustomContainer(
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.shade100,
            child: Assets.icons.icFileMessage.svg(),
          ),
          leadingHorizontalSpace: 8,
          titleWidget: CustomText(
            fileName,
            maxLines: 2,
            color: textColor,
            fontWeight: FontWeight.w600,
            size: 15,
          ),
          // subTitle: CustomText(
          //   fileUrl.size.toByteFormat,
          //   size: 14,
          //   maxLines: 1,
          // ),
        ),
      ),
    );
  }

  String get fileName => fileUrl!.split('/').last;
}
