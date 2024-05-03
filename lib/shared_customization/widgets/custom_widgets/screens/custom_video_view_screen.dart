// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:chewie/chewie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:core';
import '/app_common_data/themes/app_theme_data.dart';
import '/app_common_data/common_data/global_key_variable.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/generated/translations.g.dart';
import '/shared_customization/animations/custom_loading_animation.dart';
import '/shared_customization/helpers/banner_helper.dart';
import '/shared_customization/helpers/dialogs/dialog_helper.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/helpers/common_helper.dart';
import '/shared_customization/widgets/custom_layout.dart';
import '/shared_customization/widgets/custom_widgets/custom_dismiss_keyboard.dart';
import '/models/file_content/file_content.dart';

class CustomVideoViewScreen extends StatefulWidget {
  final FileContent file;
  const CustomVideoViewScreen({Key? key, required this.file}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomVideoViewScreenState();
  }
}

class _CustomVideoViewScreenState extends State<CustomVideoViewScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late AppThemeData theme;

  @override
  void initState() {
    super.initState();
    theme =
        GlobalKeyVariable.navigatorState.currentContext!.appTheme.appThemeData;
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget
            .file.url.isNotEmptyOrNull
        ? widget.file.url!
        : "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4"));

    await Future.wait([_videoPlayerController.initialize()]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      allowFullScreen: true,
      allowMuting: true,
      materialProgressColors: ChewieProgressColors(
          backgroundColor: theme.bg_primary,
          playedColor: theme.primary_color,
          handleColor: theme.bg_primary,
          bufferedColor: theme.white),
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),
    );
  }

  Future<void> toggleVideo() async {
    await _videoPlayerController.pause();
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    theme = context.appTheme.appThemeData;
    return CustomDismissKeyboard(
      canPop: true,
      child: Builder(builder: (context) {
        return CustomLayout(
          onWillPop: () => Future.value(true),
          appBarColor: theme.bg_primary,
          backgroundColor: theme.bg_primary,
          actions: [
            GestureDetector(
              onTap: () async {
                showConfirmDialog(
                  context,
                  title: tr(LocaleKeys.CommonAction_Download),
                  content: tr(LocaleKeys.CommonNotiAction_DownloadFile),
                  onAccept: () {
                    CommonHelper.downloadFile(
                            widget.file.url!, widget.file.name!)
                        .then((value) {
                      showSuccessBanner(
                          content: tr(
                              LocaleKeys
                                  .CommonNotiAction_DownloadFileSuccessfully,
                              namedArgs: {"filename": widget.file.name!}));
                    });
                  },
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Icon(
                  Icons.file_download_rounded,
                  size: 24,
                  color: theme.icon_primary,
                ),
              ),
            ),
          ],
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: theme.black,
                  child: Center(
                    child: _chewieController != null &&
                            _chewieController!
                                .videoPlayerController.value.isInitialized
                        ? Chewie(controller: _chewieController!)
                        : const CustomLoadingAnimation(),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
