import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pbl5/app_common_data/app_text_sytle.dart';
import 'package:pbl5/app_common_data/common_data/global_variable.dart';
import 'package:pbl5/app_common_data/extensions/message_ext.dart';
import 'package:pbl5/models/message/message.dart';
import 'package:pbl5/screens/chat/widgets/chat_file_component.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/date_time_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/banner_helper.dart';
import 'package:pbl5/shared_customization/helpers/common_helper.dart';
import 'package:pbl5/shared_customization/helpers/modal_popup/common_option_bottom_sheet.dart';
import 'package:pbl5/shared_customization/helpers/modal_popup/model_popup_helper.dart';
import 'package:pbl5/shared_customization/widgets/custom_container.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';

class ChatItemWidget extends StatefulWidget {
  const ChatItemWidget({
    super.key,
    required this.message,
    required this.nextMessage,
    required this.prevMessage,
    this.bgColor = Colors.white38,
  });
  final Message message;
  final Message? nextMessage;
  final Message? prevMessage;
  final Color bgColor;

  @override
  State<ChatItemWidget> createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  late Message? nextMessage = widget.nextMessage;
  late Message? prevMessage = widget.prevMessage;
  late Message message = widget.message;
  bool isShowMessageTime = false;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: message.alignment,
        child: Builder(builder: (context) {
          return Column(
            crossAxisAlignment: message.crossAxisAlignmentColumn,
            children: [
              ///
              /// Separate date time
              ///
              if (message.isDifferentDatetimeWithNextMessage(nextMessage,
                  compareWithDuration: const Duration(minutes: 10)))
                CustomContainer(
                  margin: const EdgeInsets.symmetric(vertical: 14),
                  width: context.screenSize.width,
                  child: CustomText(
                    message.createdAt.toDateTime?.toCustomFormat(
                        message.isDifferentDatetimeWithNextMessage(nextMessage,
                                differentIfNotSameDay: true)
                            ? "dd/MM/yyyy, EEE"
                            : "HH:mm, EEE"),
                    textAlign: TextAlign.center,
                  ),
                )
              else if (message.isShowSpacer(nextMessage))
                const SizedBox(height: 10)
              else if ((message.urlFile.isNotEmptyOrNull &&
                      message.content.isEmptyOrNull) ||
                  (nextMessage != null &&
                      nextMessage!.urlFile.isNotEmptyOrNull &&
                      nextMessage!.content.isEmptyOrNull))
                const SizedBox(height: 8),

              ///
              /// Current message
              ///
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: context.screenSize.width * 0.85),
                child: Row(
                  mainAxisAlignment: message.mainAxisAlignmentRow,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Message's body
                    Flexible(
                      child: Column(
                        crossAxisAlignment: message.crossAxisAlignmentColumn,
                        children: [
                          // Message time
                          AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) =>
                                  FadeTransition(
                                      opacity: animation, child: child),
                              child: isShowMessageTime
                                  ? CustomText(
                                      message
                                          .createdAt.toDateTime.toHourAndMinute,
                                      size: 13,
                                      padding: const EdgeInsets.only(bottom: 4))
                                  : EMPTY_WIDGET),

                          // Body content
                          GestureDetector(
                            onTap: () {
                              setState(
                                  () => isShowMessageTime = !isShowMessageTime);
                            },
                            onLongPress: () {
                              showCommonOptionBottomSheet([
                                if (message.content.isNotEmptyOrNull)
                                  CommonOptionBottomSheet(
                                      icon: FontAwesomeIcons.solidCopy,
                                      title: "Copy message content",
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                                text: message.content!))
                                            .then((_) {
                                          showSuccessBanner(
                                              content: "Copied to clipboard");
                                        });
                                      }),
                                if (message.urlFile.isNotEmptyOrNull)
                                  CommonOptionBottomSheet(
                                      icon: FontAwesomeIcons.fileArrowDown,
                                      title: "Download file",
                                      onTap: () {
                                        CommonHelper.downloadFile(
                                                message.urlFile!,
                                                message.urlFile!
                                                    .split("/")
                                                    .last)
                                            .then((_) {
                                          showSuccessBanner(
                                              content:
                                                  "Downloaded ${message.urlFile!.split("/").last} file successfully");
                                        });
                                      }),
                              ]);
                            },
                            child: Column(
                              crossAxisAlignment:
                                  message.crossAxisAlignmentColumn,
                              children: [
                                // Message's content
                                if (message.content.isNotEmptyOrNull)
                                  CustomContainer(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    borderRadius: message.borderRadius(
                                        prevMessage, nextMessage),
                                    color: message.backgroundColor,
                                    child: CustomText(
                                      message.content,
                                      style: AppTextStyle.bodyText,
                                      color: message.textColor,
                                      size: 15,
                                    ),
                                  ),
                                if (message.content.isNotEmptyOrNull &&
                                    message.urlFile.isNotEmptyOrNull)
                                  const SizedBox(height: 4),
                                // Files
                                if (message.urlFile.isNotEmptyOrNull)
                                  ChatFileComponent(
                                    fileUrl: message.urlFile,
                                    bgColor: message.backgroundColor,
                                    textColor: message.textColor,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
