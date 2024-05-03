// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'dart:io';

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/extensions/list_ext.dart';
import '/shared_customization/helpers/image_helper.dart';
import '/app_common_data/common_data/global_variable.dart';
import '/shared_customization/widgets/buttons/custom_icon_button.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/custom_widgets/custom_image.dart';

class CustomUploadImage extends StatefulWidget {
  final void Function(File file)? onSelectFile;
  final String? imagePlaceholderAssetUrl;
  final String? initialUrl;
  final File? initialFile;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  const CustomUploadImage({
    super.key,
    required this.onSelectFile,
    this.imagePlaceholderAssetUrl,
    this.initialUrl,
    this.initialFile,
    this.width,
    this.height,
    this.borderRadius =
        const BorderRadius.all(Radius.circular(BORDER_RADIUS_VALUE)),
    this.fit = BoxFit.cover,
  });

  const CustomUploadImage.avatar({
    super.key,
    required this.onSelectFile,
    this.imagePlaceholderAssetUrl,
    this.initialUrl,
    this.initialFile,
    this.borderRadius =
        const BorderRadius.all(Radius.circular(BORDER_RADIUS_VALUE)),
    this.fit = BoxFit.cover,
    required double size,
  })  : width = size,
        height = size;

  @override
  State<CustomUploadImage> createState() => _CustomUploadImageState();
}

class _CustomUploadImageState extends State<CustomUploadImage> {
  File? currentSelectedFile;

  @override
  void initState() {
    currentSelectedFile = widget.initialFile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return Stack(
      children: [
        CustomImage(
          assetUrl: widget.imagePlaceholderAssetUrl ??
              'assets/images/image_loading.png',
          imagePadding: (widget.initialUrl ?? currentSelectedFile) == null
              ? const EdgeInsets.all(16)
              : EdgeInsets.zero,
          backgroundColor: theme.bg_image,
          url: widget.initialUrl,
          file: currentSelectedFile,
          width: widget.width,
          height: widget.height,
          borderRadius: widget.borderRadius,
          fit: (widget.initialUrl ?? currentSelectedFile) == null
              ? BoxFit.contain
              : widget.fit,
        ),
        Positioned.fill(
            child: CustomContainer(
          color: theme.black.withOpacity(0.15),
          borderRadius: widget.borderRadius,
        )),
        Positioned.fill(
            child: Center(
          child: CustomIconButton(
            icon: Icons.upload_rounded,
            backgroundColor: theme.white.withOpacity(0.35),
            color: theme.white,
            padding: const EdgeInsets.all(4),
            onPressed: () async {
              List<File>? files = await ImagePickerHelper.showImagePicker(
                  context: context, multiSelection: false);
              if (files.isNotEmptyOrNull) {
                setState(() {
                  currentSelectedFile = files.first;
                  widget.onSelectFile?.call(files.first);
                });
              }
            },
          ),
        ))
      ],
    );
  }
}
