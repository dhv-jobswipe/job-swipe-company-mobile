import 'package:flutter/material.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/app_data.dart';
import '/models/message/message.dart';
import '/shared_customization/extensions/string_ext.dart';

extension MessageExt on Message? {
  bool get isSentByMe {
    return (this == null || this!.senderId.isEmptyOrNull)
        ? false
        : this!.senderId! == (getIt.get<AppData>().company?.id);
  }

  MessagePosition getPosition(Message? previousMessage, Message? nextMessage) {
    ///
    /// Different when has one of the case below:
    /// 1. Previous or next message is null
    /// 2. SenderId of previous or next message is different with current message
    /// 3. Different in datetime
    /// 4. Previous or next message has file
    ///
    bool isDifferentWithPrevMessage = previousMessage == null ||
        previousMessage.senderId != this?.senderId ||
        previousMessage.isDifferentDatetimeWithNextMessage(this,
            compareWithDuration: const Duration(minutes: 10)) ||
        previousMessage.urlFile.isNotEmptyOrNull;

    bool isDifferentWithNextMessage = nextMessage == null ||
        nextMessage.senderId != this?.senderId ||
        isDifferentDatetimeWithNextMessage(nextMessage,
            compareWithDuration: const Duration(minutes: 10)) ||
        nextMessage.urlFile.isNotEmptyOrNull;

    if (isDifferentWithPrevMessage && isDifferentWithNextMessage) {
      return MessagePosition.single;
    }
    if (isDifferentWithPrevMessage) return MessagePosition.bottom;
    if (isDifferentWithNextMessage) return MessagePosition.top;
    return MessagePosition.middle;
  }

  ///
  /// For message item component
  ///
  Color get backgroundColor =>
      isSentByMe ? Colors.grey.shade100 : Colors.pink.shade100;

  Color get textColor => isSentByMe ? Colors.black87 : Colors.white;

  bool isShowSpacer(Message? nextMessage) =>
      (this?.senderId != nextMessage?.senderId);

  BorderRadius borderRadius(Message? previousMessage, Message? nextMessage) {
    var position = getPosition(previousMessage, nextMessage);
    switch (position) {
      case MessagePosition.top:
        return isSentByMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              );
      case MessagePosition.middle:
        return isSentByMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              );
      case MessagePosition.bottom:
        return isSentByMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              )
            : const BorderRadius.only(
                bottomRight: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              );
      case MessagePosition.single:
        return BorderRadius.circular(8);
    }
  }

  Alignment get alignment =>
      isSentByMe ? Alignment.centerRight : Alignment.centerLeft;

  CrossAxisAlignment get crossAxisAlignmentColumn =>
      isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

  MainAxisAlignment get mainAxisAlignmentRow =>
      isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start;

  WrapAlignment get wrapAlignment =>
      isSentByMe ? WrapAlignment.end : WrapAlignment.start;

  bool isDifferentDatetimeWithNextMessage(
    Message? nextMessage, {
    Duration? compareWithDuration,
    bool? differentIfNotSameDay,
  }) {
    if (nextMessage == null) return true;
    if (this == null ||
        this!.createdAt == null ||
        nextMessage.createdAt == null) return false;
    var currentMessageDateTime = this!.createdAt.toDateTime!;
    var nextMessageDateTime = nextMessage.createdAt.toDateTime!;
    var duration = nextMessageDateTime.difference(currentMessageDateTime);

    if (compareWithDuration != null) {
      return duration.abs() >= compareWithDuration;
    }

    if (differentIfNotSameDay ?? false) {
      return !(currentMessageDateTime.year == nextMessageDateTime.year &&
          currentMessageDateTime.month == nextMessageDateTime.month &&
          currentMessageDateTime.day == nextMessageDateTime.day);
    }

    return true;
  }

  String get conversationPreviewContent {
    if (this == null) return "";
    if (this!.content.isNotEmptyOrNull) {
      return this!.content!;
    } else if (this!.urlFile.isNotEmptyOrNull) {
      return "Sent a file";
    }
    return "No content";
  }
}

enum MessagePosition { top, middle, bottom, single }
