import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/enums/system_constant_prefix.dart';

enum NotificationType {
  TEST._("00000"),
  // Match
  MATCHING._("00001"),
  REQUEST_MATCHING._("00002"),
  REJECT_MATCHING._("00003"),
  // Chat
  NEW_CONVERSATION._("00004"),
  NEW_MESSAGE._("00005"),
  READ_MESSAGE._("00006"),
  // Account
  ADMIN_DEACTIVATE_ACCOUNT._("00007"),
  ADMIN_ACTIVATE_ACCOUNT._("00008");

  final String value;
  const NotificationType._(this.value);

  static NotificationType fromValue(String notificationType) {
    String value = notificationType
        .substring(SystemConstantPrefix.NOTIFICATION_TYPE.prefix.length);
    for (var type in NotificationType.values) {
      if (type.value == value) return type;
    }
    throw Exception("Invalid notification type");
  }

  static Color colorFromValue(String value) {
    try {
      var type = fromValue(value);
      return type.color;
    } catch (e) {
      return Colors.transparent;
    }
  }
}

extension NotificationTypeExt on NotificationType {
  Color get color =>
      {
        NotificationType.MATCHING: Colors.pink,
        NotificationType.REQUEST_MATCHING: Colors.green,
        NotificationType.REJECT_MATCHING: Colors.black,
        NotificationType.ADMIN_ACTIVATE_ACCOUNT: Colors.blue,
        NotificationType.ADMIN_DEACTIVATE_ACCOUNT: Colors.blue,
      }[this] ??
      Colors.transparent;

  bool get isAdminNotification =>
      this == NotificationType.ADMIN_DEACTIVATE_ACCOUNT ||
      this == NotificationType.ADMIN_ACTIVATE_ACCOUNT;
}
