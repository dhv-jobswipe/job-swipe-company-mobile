import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pbl5/models/conversation/conversation.dart';
import 'package:pbl5/models/message/message.dart';
import 'package:pbl5/services/api_models/api_page_response/api_page_response.dart';
import 'package:pbl5/services/api_models/api_response/api_response.dart';
import 'package:pbl5/services/apis/api_client.dart';
import 'package:pbl5/shared_customization/extensions/file_ext.dart';
import 'package:pbl5/shared_customization/extensions/list_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';

class ChatRepository {
  final ApiClient apis;

  const ChatRepository({required this.apis});

  ///
  /// Conversations
  ///
  Future<ApiPageResponse<Conversation>> getConversations({int page = 1}) =>
      apis.getConversations(page: page);

  Future<ApiResponse<Conversation>> getConversationById(String id) =>
      apis.getConversationById(id);

  Future<int> unreadMessageCount(String conversationId) async {
    try {
      return (await apis.getUnreadMessageCount(conversationId)).data;
    } catch (e) {
      return 0;
    }
  }

  ///
  /// Messages
  ///
  Future<ApiPageResponse<Message>> getMessages(String conversationId,
          {int page = 1}) =>
      apis.getMessages(conversationId, page: page);

  Future<ApiResponse<Message>> getMessageById(
          String conversationId, String messageId) =>
      apis.getMessageById(conversationId, messageId);

  Future<ApiResponse<List<Message>>> sendMessage(
    String conversationId, {
    String? content,
    List<File> files = const [],
  }) async {
    List<MultipartFile> filesBody = [];
    for (var file in files) {
      var multipartFile = await file.toMultipartFile;
      if (multipartFile != null) filesBody.add(multipartFile);
    }
    FormData body = FormData.fromMap({
      if (content.isNotEmptyOrNull) "content": content,
      if (filesBody.isNotEmptyOrNull) "files": filesBody,
    });
    return apis.sendMessage(conversationId, body);
  }

  Future<bool> markAsReadMessage(
      String conversationId, String messageId) async {
    try {
      return (await apis.markAsReadMessage(conversationId, messageId)).status ==
          "success";
    } catch (e) {
      return false;
    }
  }

  Future<bool> markAllAsReadMessage(String conversationId) async {
    try {
      return (await apis.markAllAsReadMessage(conversationId)).status ==
          "success";
    } catch (e) {
      return false;
    }
  }
}
