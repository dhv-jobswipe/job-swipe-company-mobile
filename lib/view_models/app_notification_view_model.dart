import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/common_data/global_key_variable.dart';
import 'package:pbl5/app_common_data/common_data/global_variable.dart';
import 'package:pbl5/app_common_data/common_data/in_app_notification.dart';
import 'package:pbl5/app_common_data/enums/notification_type.dart';
import 'package:pbl5/app_common_data/extensions/message_ext.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/app_data.dart';
import 'package:pbl5/models/conversation/conversation.dart';
import 'package:pbl5/models/message/message.dart';
import 'package:pbl5/models/notification_data/notification_data.dart';
import 'package:pbl5/models/socket_data_body/socket_data_body.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/services/service_repositories/notification_repository.dart';
import 'package:pbl5/shared_customization/extensions/api_page_response_ext.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/helpers/banner_helper.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/storages.dart';
import 'package:pbl5/shared_customization/widgets/custom_container.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_image.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import 'package:pbl5/view_models/base_view_model.dart';
import 'package:pbl5/view_models/chat_view_model.dart';
import 'package:pbl5/view_models/conversation_view_model.dart';
import 'package:pbl5/view_models/notification_view_model.dart';

// git commit -m "PBL-594 notification"

class AppNotificationViewModel extends BaseViewModel {
  ///
  /// State
  ///
  int unreadNotificationCount = 0;
  InAppNotification? inAppNotification;
  Socket? _socket;
  StreamSubscription? _socketSubscription;
  Timer? _timer;
  static final int _reconnectSocketDelay = 5; // seconds
  static final int _timerPreiod = 5; // seconds
  static final String _DEBUG_TAG = "SOCKET TCP ===>";
  static final String _END_OF_DATA_SYMBOL = "\$";

  Future<BuildContext> get _context async {
    await Future.doWhile(
        () => GlobalKeyVariable.navigatorState.currentContext == null);
    return GlobalKeyVariable.navigatorState.currentContext!;
  }

  ///
  /// Other dependencies
  ///
  final NotificationRepository _notificationRepository;
  final AuthenticationRepositoty _authenticationRepositoty;
  final CustomSharedPreferences _sp;
  final NotificationViewModel _notificationViewModel;
  final ConversationViewModel _conversationViewModel;
  final ChatViewModel _chatViewModel;

  AppNotificationViewModel({
    required NotificationRepository notificationRepository,
    required AuthenticationRepositoty authenticationRepositoty,
    required CustomSharedPreferences sp,
    required NotificationViewModel notificationViewModel,
    required ConversationViewModel conversationViewModel,
    required ChatViewModel chatViewModel,
  })  : _notificationRepository = notificationRepository,
        _authenticationRepositoty = authenticationRepositoty,
        _sp = sp,
        _notificationViewModel = notificationViewModel,
        _conversationViewModel = conversationViewModel,
        _chatViewModel = chatViewModel;

  ///
  /// Events
  ///
  Future<void> connectToSocket(String host, String port) async {
    try {
      _socket = await Socket.connect(host, int.parse(port));

      // Authorize socket connection with access token
      _socket?.write(_sp.accessToken);

      // Listen data from socket
      String data = "";
      _socketSubscription = _socket!.listen(
        (event) async {
          String msg = String.fromCharCodes(event);
          int index = msg.indexOf(_END_OF_DATA_SYMBOL);
          // if index != -1, it means that we have received a full message
          if (index != -1) {
            await _handleDataFromSocket(data + msg.substring(0, index));
            data = "" + msg.substring(index + 1);
          } else {
            data += msg;
          }
        },
        onError: (error) {
          debugPrint("$_DEBUG_TAG FAILED TO CONNECT TO SERVER SOCKET: $error");
          _reconnectSocket(host, port);
        },
        onDone: () {
          debugPrint("$_DEBUG_TAG DISCONNECTED FROM SERVER SOCKET");
          _reconnectSocket(host, port);
        },
      );

      // Ping server every 5 seconds
      _timer = Timer.periodic(Duration(seconds: _timerPreiod), (timer) {
        _socket?.write("PING");
      });
    } catch (e) {
      debugPrint("$_DEBUG_TAG ERROR $e");
      _reconnectSocket(host, port);
    }
  }

  Future<void> _handleDataFromSocket(String data) async {
    if (data.toLowerCase() == "CONNECTED".toLowerCase()) {
      debugPrint("$_DEBUG_TAG SUCCESSFULLY CONNECTED TO SERVER SOCKET");
      return;
    }
    if (data.toLowerCase() == "PONG".toLowerCase()) {
      debugPrint("$_DEBUG_TAG PONG");
      return;
    }
    // Handle data from socket
    debugPrint("$_DEBUG_TAG DATA FROM SERVER SOCKET: $data");
    try {
      if (jsonDecode(data) is! Map<String, dynamic>) return;
      var socketDataBody = SocketDataBody.fromJson(jsonDecode(data));
      var notificationType =
          NotificationType.fromValue(socketDataBody.type?.constantType ?? '');
      NotificationData? notiData;
      Message? message;
      Conversation? conversation;
      switch (notificationType) {
        case NotificationType.MATCHING:
        case NotificationType.REQUEST_MATCHING:
        case NotificationType.REJECT_MATCHING:
          unreadNotificationCount++;
          notiData =
              NotificationData.fromJson(jsonDecode(socketDataBody.data ?? ''));
          _notificationViewModel.notificationData =
              _notificationViewModel.notificationData.insertFirst(notiData);
          _notificationViewModel.updateUI();
          break;
        case NotificationType.NEW_CONVERSATION:
          conversation =
              Conversation.fromJson(jsonDecode(socketDataBody.data ?? ''));
          _conversationViewModel.conversations =
              _conversationViewModel.conversations.insertFirst(conversation);
          _conversationViewModel.updateUI();
          break;
        case NotificationType.NEW_MESSAGE:
          message = Message.fromJson(jsonDecode(socketDataBody.data ?? ''));
          _conversationViewModel.refreshConversation(message.conversationId);
          if (message.conversationId == _chatViewModel.conversation?.id) {
            _chatViewModel.messages = _chatViewModel.messages.insertFirst(
              message,
              removeIfDuplicate: (element) => element.id == message?.id,
            );
            _chatViewModel.updateUI();
          }
          break;
        default:
          break;
      }
      _showNotificationToast(notificationType,
          data: notiData, message: message);
    } catch (e) {
      debugPrint("$_DEBUG_TAG DATA ERROR $e");
    } finally {
      updateUI();
    }
  }

  Future<void> _showNotificationToast(
    NotificationType type, {
    NotificationData? data,
    Message? message,
  }) async {
    try {
      if (data == null && message == null) return;
      Widget prefixWidget = EMPTY_WIDGET;
      Widget contentWidget = EMPTY_WIDGET;
      switch (type) {
        case NotificationType.MATCHING:
        case NotificationType.REQUEST_MATCHING:
        case NotificationType.REJECT_MATCHING:
          if (data == null) return;
          prefixWidget = CustomContainer(
            padding: const EdgeInsets.all(2),
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(1000),
            child: CustomImage.avatar(
              url: type.isAdminNotification ? null : data.sender?.avatar,
              assetUrl: type.isAdminNotification
                  ? "assets/images/logo_dash.png"
                  : null,
              size: 40,
              borderRadius: BorderRadius.circular(1000),
            ),
          );
          contentWidget = CustomText(
            data.content,
            size: 16,
            color: Colors.white,
            maxLines: 2,
          );
          break;
        case NotificationType.NEW_CONVERSATION:
          break;
        case NotificationType.NEW_MESSAGE:
          if (message == null ||
              message.conversationId == _chatViewModel.conversation?.id ||
              message.senderId == getIt.get<AppData>().user?.id) {
            return;
          }
          var sender = (await _authenticationRepositoty
                  .getAccountById(message.senderId!))
              .data;
          prefixWidget = CustomContainer(
            padding: const EdgeInsets.all(2),
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(1000),
            child: CustomImage.avatar(
              url: sender?.avatar,
              size: 40,
              borderRadius: BorderRadius.circular(1000),
            ),
          );
          contentWidget = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                sender?.email,
                size: 16,
                color: Colors.white,
                maxLines: 1,
              ),
              CustomText(
                message.conversationPreviewContent,
                size: 14,
                color: Colors.white,
                maxLines: 1,
              ),
            ],
          );
          break;
        default:
          break;
      }
      showCustomBanner(
          onTap: () async => (await _context)
              .navigateNotification(type, data: data, message: message),
          durationInMilliseconds: 2000,
          widget: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              prefixWidget,
              const SizedBox(width: 16),
              Flexible(child: contentWidget)
            ],
          ));
    } catch (e) {
      debugPrint("$_DEBUG_TAG DATA ERROR $e");
    }
  }

  Future<void> _reconnectSocket(String host, String port) async {
    disconnectSocket();
    await Future.delayed(Duration(seconds: _reconnectSocketDelay));
    await connectToSocket(host, port);
  }

  void disconnectSocket() {
    _socketSubscription?.cancel();
    _socket?.close();
    _timer?.cancel();
    _socketSubscription = null;
    _socket = null;
    _timer = null;
  }

  Future<void> getUnreadNotificationCount() async {
    unreadNotificationCount =
        await _notificationRepository.getUnreadNotificationCount();
    updateUI();
  }

  void clearNotification() {
    unreadNotificationCount = 0;
    disconnectSocket();
    updateUI();
  }
}
