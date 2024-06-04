// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/generated/translations.g.dart';
import '/shared_customization/helpers/dialogs/dialog_helper.dart';

class ImagePickerHelper {
  ImagePickerHelper._();

  static Future<List<File>> showImagePicker({
    required BuildContext context,
    bool withCameraOption = true,
    bool multiSelection = true,
    bool withVideoOption = false,
  }) async {
    // AppThemeData theme = context.appTheme.appThemeData;
    // dynamic data = await showModalBottomSheet(
    //     backgroundColor: theme.white,
    //     barrierColor: theme.white,
    //     context: context,
    //     isScrollControlled: true,
    //     useSafeArea: true,
    //     builder: (_) => CustomGalleryWidget(
    //           multiSelection: multiSelection,
    //           withCameraOption: withCameraOption,
    //           withVideoOption: withVideoOption,
    //         ));
    // List<File> selectedFiles = (data == null)
    //     ? []
    //     : (data as List<File?>)
    //         .where((element) => element != null)
    //         .map((e) => e!)
    //         .toList();
    PermissionStatus status = await Permission.storage.request();
    if ([PermissionStatus.denied, PermissionStatus.permanentlyDenied]
        .contains(status)) {
      showConfirmDialog(context,
          title: tr(LocaleKeys.Permission_CanNotAccessGalleryPermission),
          content: tr(LocaleKeys.Permission_PleaseAccessGalleryPermission),
          onAccept: openAppSettings);
      return [];
    }
    List<File> selectedFiles = [];
    if (multiSelection) {
      List<XFile> xFiles = await ImagePicker().pickMultiImage();
      selectedFiles = xFiles.map((e) => File(e.path)).toList();
    } else {
      XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      selectedFiles = [if (xFile != null) File(xFile.path)];
    }
    return selectedFiles;
  }

  static Future<File?> takePhotoFromCamera(
      {required BuildContext context}) async {
    PermissionStatus status = await Permission.camera.request();
    if ([PermissionStatus.denied, PermissionStatus.permanentlyDenied]
        .contains(status)) {
      showConfirmDialog(context,
          title: tr(LocaleKeys.Permission_CameraPermissionPurpose),
          content: tr(LocaleKeys.Permission_PleaseAcceptCameraPermission),
          onAccept: openAppSettings);
      return null;
    }
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    return xFile == null ? null : File(xFile.path);
  }

  static Future<File?> cropImageFile(
    File imageFile,
    double aspectRatio, {
    bool flipHorizontal = false,
  }) async {
    try {
      img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
      double actualDimension = image.width / image.height;
      img.Image croppedImage;
      if (actualDimension > aspectRatio) {
        croppedImage = img.copyCrop(
          image,
          x: ((image.width - (image.height * aspectRatio)) / 2).round(),
          y: 0,
          width: (image.height * aspectRatio).round(),
          height: image.height,
        );
      } else {
        croppedImage = img.copyCrop(
          image,
          x: 0,
          y: ((image.height - (image.width / aspectRatio)) / 2).round(),
          width: image.width,
          height: (image.width / aspectRatio).round(),
        );
      }
      if (flipHorizontal == true) {
        croppedImage = img.flipHorizontal(croppedImage);
      }
      List<int> croppedBytes = img.encodeJpg(croppedImage);
      Directory tempDir = await getTemporaryDirectory();
      File tempFile = File(
          '${tempDir.path}/ptv_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await tempFile.writeAsBytes(croppedBytes);
      return tempFile;
    } catch (err) {
      debugPrint('Error is $err'.debug);
      return null;
    }
  }
}
