// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'dart:io';

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/enums/image_type.dart';
import '/shared_customization/widgets/custom_widgets/custom_image.dart';

class CustomImageButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final String? url;
  final String? assetUrl;
  final File? file;
  final BorderRadius? borderRadius;
  final BoxFit fit;
  final EdgeInsets imagePadding;
  final Color? backgroundColor;
  final ImageType imageType;

  const CustomImageButton({
    super.key,
    required this.onPressed,
    this.url,
    this.assetUrl,
    this.file,
    this.borderRadius,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.imagePadding = EdgeInsets.zero,
    this.imageType = ImageType.image,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return GestureDetector(
      onTap: onPressed,
      child: CustomImage(
        url: url,
        assetUrl: assetUrl,
        file: file,
        borderRadius: borderRadius,
        width: width,
        height: height,
        fit: fit,
        backgroundColor: backgroundColor ?? theme.transparent,
        imagePadding: imagePadding,
        imageType: imageType,
      ),
    );
  }
}
