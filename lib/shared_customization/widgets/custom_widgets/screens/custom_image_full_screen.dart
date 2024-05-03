// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:uuid/uuid.dart';
import '/models/file_content/file_content.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/widgets/custom_widgets/custom_image.dart';
import '/shared_customization/widgets/custom_widgets/screens/custom_video_view_screen.dart';
import '/shared_customization/animations/custom_loading_animation.dart';
import '/shared_customization/widgets/custom_layout.dart';
import '/shared_customization/widgets/custom_widgets/custom_dismiss_keyboard.dart';

class CustomImageFullScreenParams {
  final List<FileContent> files;
  final int initIndex;
  CustomImageFullScreenParams({required this.files, required this.initIndex});
}

class CustomImageFullScreen extends StatefulWidget {
  final CustomImageFullScreenParams params;
  const CustomImageFullScreen({super.key, required this.params});

  @override
  State<CustomImageFullScreen> createState() => _CustomImageFullScreenState();
}

class _CustomImageFullScreenState extends State<CustomImageFullScreen> {
  late int currentIndex;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.params.initIndex);
    currentIndex = widget.params.initIndex;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onChangePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return CustomDismissKeyboard(
      canPop: true,
      child: CustomLayout(
          title: '${currentIndex + 1}/${widget.params.files.length.toString()}',
          onWillPop: () => Future.value(true),
          appBarColor: theme.bg_primary,
          backgroundColor: theme.bg_primary,
          body: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            enableRotation: false,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions.customChild(
                  heroAttributes: PhotoViewHeroAttributes(
                      tag: widget.params.files[index].url ?? const Uuid().v4()),
                  basePosition: Alignment.center,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 2,
                  initialScale: PhotoViewComputedScale.contained,
                  child: _imageItem(widget.params.files[index]));
            },
            itemCount: widget.params.files.length,
            loadingBuilder: (context, event) => const CustomLoadingAnimation(),
            backgroundDecoration: BoxDecoration(color: theme.bg_primary),
            pageController: _pageController,
            onPageChanged: _onChangePage,
            scrollDirection: Axis.horizontal,
          )),
    );
  }

  Widget _imageItem(FileContent item) {
    return (item.name ?? "").isVideo
        ? GestureDetector(
            onTap: () {
              if ((item.name ?? "").isVideo) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomVideoViewScreen(file: item)),
                );
              }
            },
            child: const CustomImage(
              assetUrl: 'assets/images/video_thumbnail.png',
              fit: BoxFit.contain,
            ),
          )
        : CustomImage(
            url: item.url,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(0),
          );
  }
}
