import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/common_data/global_key_variable.dart';
import 'package:pbl5/models/conversation/conversation.dart';
import 'package:pbl5/models/message/message.dart';
import 'package:pbl5/services/service_repositories/chat_repository.dart';
import 'package:pbl5/shared_customization/extensions/api_page_response_ext.dart';
import 'package:pbl5/shared_customization/extensions/list_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/dialogs/dialog_helper.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/view_models/base_view_model.dart';
import 'package:pbl5/services/api_models/api_page_response/api_page_response.dart';

class ChatViewModel extends BaseViewModel {
  ///
  /// State
  ///
  ApiPageResponse<Message>? messages;
  Conversation? conversation;
  bool canLoadMore = true;
  BuildContext get _context => GlobalKeyVariable.navigatorState.currentContext!;

  ///
  /// Other dependencies
  ///
  final ChatRepository _chatRepository;

  ChatViewModel({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  ///
  /// Events
  ///
  ///
  Future<void> getConversation(String id) async {
    try {
      var response = await _chatRepository.getConversationById(id);
      conversation = response.data;
    } catch (e) {
      debugPrint("Error: $e".debug);
      showErrorDialog(_context, content: parseError(e));
      return;
    }
    updateUI();
  }

  Future<void> getMessages({int page = 1}) async {
    if (conversation == null || conversation!.id.isEmptyOrNull) return;
    try {
      var response =
          await _chatRepository.getMessages(conversation!.id!, page: page);
      messages = messages.insertPage(response);
      canLoadMore = (response.paging?.nextPage ?? 0) >
          (response.paging?.currentPage ?? 0);
    } catch (e) {
      debugPrint("Error: $e".debug);
      messages = ApiPageResponse.empty();
    }
    updateUI();
  }

  Future<void> sendMessage({
    String? content,
    List<File> files = const [],
  }) async {
    if (conversation == null || conversation!.id.isEmptyOrNull) return;
    if (content.isEmptyOrNull && files.isEmptyOrNull) return;
    try {
      var response = await _chatRepository.sendMessage(conversation!.id!,
          content: content, files: files);
      if (response.data == null) return;
      for (var m in response.data!) {
        messages = messages.insertFirst(m);
      }
    } catch (e) {
      debugPrint("Error: $e".debug);
      showErrorDialog(_context, content: parseError(e));
      return;
    }
    updateUI();
  }

  Future<void> markAsRead(String messageId) async {
    if (conversation == null || conversation!.id.isEmptyOrNull) return;
    try {
      var isSuccess =
          await _chatRepository.markAsReadMessage(conversation!.id!, messageId);
      if (isSuccess) {
        messages = messages.update(
            (element) => element.copyWith(readStatus: true),
            (element) => element.id == messageId);
        updateUI();
      }
    } catch (e) {
      debugPrint("Error: $e".debug);
      showErrorDialog(_context, content: parseError(e));
    }
  }

  Future<void> markAllAsRead() async {
    if (conversation == null || conversation!.id.isEmptyOrNull) return;
    try {
      var isSuccess =
          await _chatRepository.markAllAsReadMessage(conversation!.id!);
      if (isSuccess) {
        messages = messages.update(
            (element) => element.copyWith(readStatus: true),
            (element) => element.readStatus == false);
        updateUI();
      }
    } catch (e) {
      debugPrint("Error: $e".debug);
      showErrorDialog(_context, content: parseError(e));
    }
  }

  void clearData() async {
    messages = null;
    conversation = null;
    canLoadMore = true;
    updateUI();
  }
}
