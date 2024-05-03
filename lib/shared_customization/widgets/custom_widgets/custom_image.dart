// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/generated/assets.gen.dart';
import '/app_common_data/common_data/global_variable.dart';
import '/shared_customization/enums/image_type.dart';
import '/shared_customization/extensions/string_ext.dart';

class CustomImage extends StatelessWidget {
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
  final Widget? Function(File file)? fileBuilder;
  final Widget? Function(String url)? urlBuilder;

  const CustomImage({
    super.key,
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
    this.fileBuilder,
    this.urlBuilder,
  });

  const CustomImage.avatar({
    super.key,
    this.url,
    this.assetUrl,
    this.file,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.imagePadding = EdgeInsets.zero,
    required double size,
    this.fileBuilder,
    this.urlBuilder,
  })  : imageType = ImageType.avatar,
        width = size,
        height = size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(BORDER_RADIUS_VALUE),
      child: Container(
          width: width,
          height: height,
          decoration:
              BoxDecoration(color: backgroundColor ?? Colors.transparent),
          padding: imagePadding,
          child: Builder(builder: (context) {
            if (file != null) {
              return fileBuilder?.call(file!) ??
                  Image.file(
                    file!,
                    fit: fit,
                  );
            } else if (url.isNotEmptyOrNull) {
              return urlBuilder?.call(url!) ??
                  CachedNetworkImage(
                    imageUrl: url!,
                    fit: fit,
                    maxHeightDiskCache: 1260,
                    maxWidthDiskCache: 1260,
                    placeholder: (context, url) => imageType == ImageType.avatar
                        ? avatarLoading
                        : imageLoading,
                    errorWidget: (context, url, error) => imageLoading,
                  );
            } else if (assetUrl.isNotEmptyOrNull) {
              return Image.asset(
                assetUrl!,
                fit: fit,
              );
            }
            return imagePlaceHolder;
          })),
    );
  }

  Widget get imagePlaceHolder => LayoutBuilder(builder: (context, constraint) {
        return CustomContainer(
          color: Colors.grey.shade50,
          padding: EdgeInsets.all(
              min(12.0, min(constraint.maxHeight, constraint.maxWidth) / 4)),
          child: Center(
            child: imageType.imagePlaceHolder,
          ),
        );
      });

  Widget get imageLoading => LayoutBuilder(builder: (context, constraint) {
        return CustomContainer(
          color: Colors.grey.shade50,
          padding: EdgeInsets.all(
              min(12.0, min(constraint.maxHeight, constraint.maxWidth) / 4)),
          child: Center(
            child: Assets.images.imageLoading.image(),
          ),
        );
      });

  Widget get avatarLoading => LayoutBuilder(builder: (context, constraint) {
        return CustomContainer(
          color: Colors.grey.shade200,
          padding: EdgeInsets.all(
              min(12.0, min(constraint.maxHeight, constraint.maxWidth) / 4)),
          child: Center(
            child: Assets.icons.icAvatar.svg(),
          ),
        );
      });
}
