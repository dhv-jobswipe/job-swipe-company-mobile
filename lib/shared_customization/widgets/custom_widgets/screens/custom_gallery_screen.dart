// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/shared_customization/extensions/string_ext.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:rxdart/rxdart.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/helpers/image_helper.dart';
import '/shared_customization/helpers/dialogs/dialog_helper.dart';
import '/shared_customization/widgets/buttons/custom_icon_button.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/generated/translations.g.dart';
import '/shared_customization/extensions/list_ext.dart';
import '/shared_customization/extensions/scroll_controller_ext.dart';
import '/shared_customization/widgets/custom_layout.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import 'package:device_info_plus/device_info_plus.dart';

class CustomGalleryWidget extends StatefulWidget {
  final bool multiSelection;
  final bool withCameraOption;
  final bool withVideoOption;
  const CustomGalleryWidget({
    super.key,
    required this.withCameraOption,
    required this.multiSelection,
    required this.withVideoOption,
  });

  @override
  State<CustomGalleryWidget> createState() => _CustomGalleryWidgetState();
}

class _CustomGalleryWidgetState extends State<CustomGalleryWidget> {
  late BehaviorSubject<List<AssetEntity>?> assetSubject;
  late BehaviorSubject<List<String>> selectedItems;
  late final ScrollController _scrollController;
  Map<String, Widget> assetWidgetMap = {};
  bool isLoadingMore = false;
  int paging = 30;
  int nextPage = 0;
  AssetPathEntity? path;
  int? totalAssetCount;
  double? screenWidth;
  BuildContext? _context;

  @override
  void initState() {
    super.initState();
    assetSubject = BehaviorSubject<List<AssetEntity>?>();
    selectedItems = BehaviorSubject<List<String>>.seeded([]);
    _scrollController = ScrollController();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    assetSubject.close();
    selectedItems.close();
  }

  _getData() async {
    bool canAccess = false;
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final androidInfo = await deviceInfoPlugin.androidInfo;
      if (androidInfo.version.sdkInt > 32) {
        final PermissionStatus ps = await Permission.photos.request();
        canAccess = ps.isGranted || ps.isLimited;
      } else {
        final PermissionState ps = await PhotoManager.requestPermissionExtend();
        canAccess = ps.hasAccess || ps.isAuth;
      }
    } else {
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      canAccess = ps.hasAccess || ps.isAuth;
    }
    if (canAccess) {
      await _getPath();
      await _getListAssetEntity();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (_context != null) {
          showConfirmDialog(
            context,
            title: tr(LocaleKeys.Permission_GalleryPermissionPurpose),
            content: tr(LocaleKeys.Permission_PleaseAccessGalleryPermission),
            onAccept: () {
              Navigator.pop(_context!);
              openAppSettings();
            },
            onReject: Navigator.of(_context!).pop,
          );
        }
      });
    }
  }

  Future<void> _getPath() async {
    try {
      final listPath = await PhotoManager.getAssetPathList(
        hasAll: true,
        onlyAll: true,
        type: widget.withVideoOption ? RequestType.common : RequestType.image,
      );
      if (listPath.isNotEmptyOrNull) {
        path = listPath.first;
        totalAssetCount = await path!.assetCountAsync;
        debugPrint('Asset total count: $totalAssetCount'.debug);
      } else {
        assetSubject.addError(tr(LocaleKeys.CommonData_CantLoadData));
      }
    } catch (err) {
      assetSubject.addError(tr(LocaleKeys.CommonData_CantLoadData));
    }
  }

  Future<void> _getListAssetEntity() async {
    if (path == null) return;
    try {
      isLoadingMore = true;
      debugPrint('===> Get asset page $nextPage'.debug);
      List<AssetEntity> list =
          await path!.getAssetListPaged(page: nextPage, size: paging);
      List<Widget> widgets = await Future.wait(list.map((e) async {
        return Image.memory(
          (await e.thumbnailDataWithSize(ThumbnailSize(
              (screenWidth! / 2).round(), (screenWidth! / 2).round())))!,
          fit: BoxFit.cover,
        );
      }).toList());
      for (var element in list) {
        assetWidgetMap[element.id] = widgets[list.indexOf(element)];
      }
      assetSubject.value = [...(assetSubject.valueOrNull ?? []), ...list];
      isLoadingMore = false;
      if (list.isEmpty || list.length < paging) {
        nextPage = 0;
      } else {
        nextPage++;
      }
    } catch (err) {
      assetSubject.addError(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    screenWidth ??= MediaQuery.of(context).size.width;
    _context = context;
    return StreamBuilder<List<AssetEntity>?>(
        stream: assetSubject.stream,
        builder: (context, assetSnapshot) {
          return CustomLayout(
            title: tr(LocaleKeys.CommonData_Gallery),
            appBarColor: theme.white,
            backgroundColor: theme.bg_primary,
            leading: CustomIconButton(
                onPressed: Navigator.of(context).pop, icon: Icons.close),
            actions: [
              if (widget.multiSelection)
                StreamBuilder<List<String>>(
                    stream: selectedItems.stream,
                    builder: ((context, snapshot) => snapshot
                            .data.isNotEmptyOrNull
                        ? IconButton(
                            onPressed: () async {
                              List<AssetEntity> selectedAssets = snapshot.data!
                                  .map((e) => assetSnapshot.data!
                                      .firstWhere((element) => element.id == e))
                                  .toList();
                              List<File?> selectedFiles = await Future.wait(
                                  selectedAssets.map((e) => e.originFile));
                              Navigator.of(context).pop(selectedFiles);
                            },
                            icon: Icon(
                              Icons.check,
                              color: theme.icon_primary,
                            ))
                        : const SizedBox.shrink()))
            ],
            body: StreamBuilder<List<String>>(
                stream: selectedItems.stream,
                builder: (context, selectedSnapshot) {
                  List<String> selectedImageIds = selectedSnapshot.data ?? [];
                  if (assetSnapshot.hasError) {
                    return Center(
                      child: CustomText(assetSnapshot.error.toString()),
                    );
                  } else if (assetSnapshot.data == null) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: theme.primary_color),
                    );
                  }
                  if (assetSnapshot.hasData &&
                      assetSnapshot.data!.isEmpty &&
                      widget.withCameraOption == false) {
                    return const Center(
                      child: Icon(
                        Icons.dns_rounded,
                        size: 32,
                      ),
                    );
                  }
                  return NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification &&
                          _scrollController.loadMorePointPassed &&
                          isLoadingMore == false &&
                          (totalAssetCount ?? 0) > 0 &&
                          (assetSnapshot.data ?? []).length <
                              totalAssetCount! &&
                          nextPage > 0) {
                        _getListAssetEntity();
                      }
                      return true;
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Wrap(spacing: 2, runSpacing: 2, children: [
                        if (widget.withCameraOption)
                          GestureDetector(
                            onTap: () async {
                              File? file =
                                  await ImagePickerHelper.takePhotoFromCamera(
                                      context: _context!);
                              if (file != null) {
                                Navigator.of(_context!).pop(<File>[file]);
                              }
                            },
                            child: Container(
                              width: (screenWidth! - 4) / 3,
                              height: (screenWidth! - 4) / 3,
                              color: theme.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: theme.text_normal.withOpacity(0.6),
                                    size: 26,
                                  ),
                                  const SizedBox(height: 4),
                                  CustomText(
                                    tr(LocaleKeys.CommonData_TakeAPhoto),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ...(assetSnapshot.data ?? [])
                            .map((e) => SizedBox(
                                  width: (screenWidth! - 4) / 3,
                                  height: (screenWidth! - 4) / 3,
                                  child: GestureDetector(
                                      onTap: () async {
                                        selectedItems.value = selectedImageIds
                                            .toggle(e.id, (p0) => p0);
                                        if (!widget.multiSelection) {
                                          AssetEntity selectedAsset =
                                              assetSnapshot.data!.firstWhere(
                                                  (element) =>
                                                      element.id == e.id);
                                          Navigator.of(context).pop(
                                              await Future.wait(
                                                  [selectedAsset.originFile]));
                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: assetWidgetMap[e.id] ??
                                                const SizedBox.shrink(),
                                          ),
                                          if (selectedImageIds.contains(e.id))
                                            Positioned(
                                                top: 8,
                                                right: 8,
                                                child: CustomContainer(
                                                    width: 20,
                                                    height: 20,
                                                    alignment: Alignment.center,
                                                    color: theme.primary_color,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    border: Border.all(
                                                        color: theme.white,
                                                        width: 1),
                                                    child: CustomText(
                                                      '${selectedImageIds.indexOf(e.id) + 1}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      color: theme.white,
                                                    ))),
                                          if (e.videoDuration.inSeconds > 0)
                                            Positioned(
                                                bottom: 8,
                                                left: 8,
                                                child: CustomText(
                                                  '${'${(e.duration / 60).floor()}'.padLeft(2, '0')}:${'${(e.duration % 60)}'.padLeft(2, '0')}',
                                                  size: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: theme.white,
                                                ))
                                        ],
                                      )),
                                ))
                            .toList(),
                        if (isLoadingMore)
                          SizedBox(
                            width: screenWidth,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: CustomText(
                                tr(LocaleKeys.CommonData_LoadingMore),
                                textAlign: TextAlign.center,
                                size: 12,
                                color: theme.text_normal.withOpacity(0.6),
                              ),
                            ),
                          )
                      ]),
                    ),
                  );
                }),
          );
        });
  }
}
