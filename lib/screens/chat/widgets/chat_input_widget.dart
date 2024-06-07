// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbl5/app_common_data/common_data/global_variable.dart';
import 'package:pbl5/app_common_data/extensions/app_image_ext.dart';
import 'package:pbl5/generated/assets.gen.dart';
import 'package:pbl5/shared_customization/enums/keyboard_type.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/file_ext.dart';
import 'package:pbl5/shared_customization/extensions/list_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/file_helper.dart';
import 'package:pbl5/shared_customization/helpers/image_helper.dart';
import 'package:pbl5/shared_customization/widgets/custom_container.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_image.dart';
import 'package:pbl5/shared_customization/widgets/form_fields/custom_form_field.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text_field.dart';

class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({
    super.key,
    required this.onSend,
    required this.isActive,
  });
  final void Function(MessageInputModel inputModel) onSend;
  final bool isActive;

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  MessageInputModel currentMessage = MessageInputModel();
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool isTextFieldExpanded = false;
  FormFieldState<MessageInputModel>? _validator;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.isEmptyOrNull && isTextFieldExpanded) {
        setState(() => isTextFieldExpanded = false);
      } else if (_controller.text.isNotEmptyOrNull && !isTextFieldExpanded) {
        setState(() => isTextFieldExpanded = true);
      }
    });
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus &&
          _controller.text.isEmptyOrNull &&
          isTextFieldExpanded) {
        setState(() => isTextFieldExpanded = false);
      }
    });
  }

  void changeState(MessageInputModel message) {
    setState(() {
      currentMessage = message;
      _validator?.didChange(currentMessage);
    });
  }

  @override
  void dispose() {
    try {
      _controller.dispose();
    } catch (e) {
      debugPrint(e.toString());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: widget.isActive ? Colors.white : Colors.grey.shade200,
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: !widget.isActive
          ? Align(
              child: CustomText(
                "This conversation is closed",
                textAlign: TextAlign.center,
                color: Colors.black54,
                size: 16,
                fontWeight: FontWeight.w500,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            )
          : CustomFormField<MessageInputModel>(
              showLabelAndError: false,
              validations: [
                (data) => (data?.content.isEmptyOrNull ?? true) &&
                        (data?.files.isEmptyOrNull ?? true)
                    ? "error but not show"
                    : null,
              ],
              widgetBuilder: (validator) {
                _validator ??= validator;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ///
                    /// List local files
                    ///
                    if ((currentMessage.files).isNotEmptyOrNull) ...[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 4,
                          children: currentMessage.files
                              .asMap()
                              .entries
                              .map((entry) => CustomImage.avatar(
                                    size: 65,
                                    file: entry.value,
                                    fileBuilder: (file) {
                                      if (!file.name.isImage &&
                                          !file.name.isVideo) {
                                        return Assets.icons.icFileMessage.svg();
                                      }
                                      if (file.name.isVideo) {
                                        return CustomContainer(
                                          border: Border.all(),
                                          child: Assets.images.videoThumbnail
                                              .image(fit: BoxFit.cover),
                                        );
                                      }
                                      return null;
                                    },
                                  ).onRemove(
                                    onRemoveTap: () {
                                      changeState(currentMessage =
                                          currentMessage.copyWith(
                                              files: currentMessage.files
                                                  .deleteAt(entry.key)));
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],

                    ///
                    /// Input Text Field
                    ///
                    Row(
                      children: [
                        ///
                        /// Input message options
                        ///
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          child: (!isTextFieldExpanded)
                              ? Wrap(
                                  spacing: 12,
                                  alignment: WrapAlignment.end,
                                  crossAxisAlignment: WrapCrossAlignment.end,
                                  runAlignment: WrapAlignment.end,
                                  children: InputMessageOptions.values
                                      .map((e) => GestureDetector(
                                            onTap: () async {
                                              var files = <File>[];
                                              switch (e) {
                                                case InputMessageOptions.camera:
                                                  var file =
                                                      await ImagePickerHelper
                                                          .takePhotoFromCamera(
                                                              context: context);
                                                  if (file != null) {
                                                    files.add(file);
                                                  }
                                                  break;
                                                case InputMessageOptions
                                                      .gallery:
                                                  List<XFile> xfiles =
                                                      await ImagePicker()
                                                          .pickMultiImage();
                                                  files = xfiles
                                                      .map((e) => File(e.path))
                                                      .toList();
                                                  break;
                                                case InputMessageOptions.file:
                                                  files =
                                                      await FileHelper.getFile(
                                                              context: context,
                                                              allowMultiple:
                                                                  true) ??
                                                          [];
                                                  break;
                                              }
                                              // Update files in message
                                              if (files.isNotEmptyOrNull) {
                                                changeState(currentMessage =
                                                    currentMessage.copyWith(
                                                        files: files));
                                              }
                                            },
                                            child: e.icon,
                                            // color: e.color ??
                                            //     AppColors.primaryBodyText,
                                          ))
                                      .toList())
                              : GestureDetector(
                                  onTap: () => setState(
                                      () => isTextFieldExpanded = false),
                                  child: Assets.icons.icArrowRightInChat
                                      .svg(color: Colors.pink)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomTextField(
                            // errorLabel:
                            //     !validator.hasError ? null : validator.errorText,
                            placeholder: "Type a message...",
                            keyboardType: KeyboardType.multiline,
                            minLines: 1,
                            maxLines: 3,
                            activeBorderColor: Colors.pink,
                            focusNode: _focusNode,
                            controller: _controller,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 300))
                                  .then((_) {
                                setState(() => isTextFieldExpanded = true);
                              });
                            },
                            suffixIcon: EMPTY_WIDGET,
                            suffixIconConstraints: const BoxConstraints(
                                maxHeight: 0, maxWidth: 12),
                            onChanged: (value) {
                              changeState(currentMessage =
                                  currentMessage.copyWith(content: value));
                            },
                          ),
                        ),

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          child: (isTextFieldExpanded && validator.isValid)
                              ? GestureDetector(
                                  onTap: () {
                                    widget.onSend(currentMessage);
                                    changeState(currentMessage = currentMessage
                                        .copyWith(content: null, files: []));
                                    _controller.clear();
                                    Future.delayed(
                                        const Duration(milliseconds: 700), () {
                                      context.unfocus();
                                    });
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 8, 0, 8),
                                    child: Assets.icons.icSendMessage
                                        .svg(width: 24, color: Colors.pink),
                                  ))
                              : EMPTY_WIDGET,
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class MessageInputModel {
  final String? content;
  final List<File> files;

  MessageInputModel({this.content, this.files = const []});

  MessageInputModel copyWith({String? content, List<File>? files}) {
    return MessageInputModel(
      content: content ?? this.content,
      files: files ?? this.files,
    );
  }
}

///
/// Input message options
///
enum InputMessageOptions {
  camera,
  gallery,
  file,
}

extension InputMessageOptionsExt on InputMessageOptions {
  Widget get icon => {
        InputMessageOptions.file:
            Assets.icons.icAttachFileInChat.svg(color: Colors.pink),
        InputMessageOptions.gallery:
            Assets.icons.icGalleryInChat.svg(color: Colors.pink),
        InputMessageOptions.camera:
            Assets.icons.icCameraInChat.svg(color: Colors.pink)
      }[this]!;

  Color? get color => {
        // InputMessageOptions.clear: AppColors.primaryHintText,
      }[this];
}
