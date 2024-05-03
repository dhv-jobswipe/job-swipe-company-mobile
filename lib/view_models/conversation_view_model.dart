import 'package:flutter/material.dart';
import 'package:pbl5/models/conversation/conversation.dart';
import 'package:pbl5/services/service_repositories/chat_repository.dart';
import 'package:pbl5/shared_customization/extensions/api_page_response_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/view_models/base_view_model.dart';
import 'package:pbl5/services/api_models/api_page_response/api_page_response.dart';

class ConversationViewModel extends BaseViewModel {
  ///
  /// State
  ///
  ApiPageResponse<Conversation>? conversations;

  ///
  /// Other dependencies
  ///
  final ChatRepository _chatRepository;

  ConversationViewModel({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  ///
  /// Events
  ///
  Future<void> getConversation({int page = 1}) async {
    try {
      var response = await _chatRepository.getConversations(page: page);
      conversations = conversations.insertPage(response);
      updateUI();
    } catch (e) {
      debugPrint(e.toString());
      conversations = ApiPageResponse.empty();
    }
  }

  Future<void> refreshConversation(String? id) async {
    if (id.isEmptyOrNull) return;
    try {
      var response = await _chatRepository.getConversationById(id!);
      if (response.data != null) {
        conversations = conversations.update(
            (element) => element = response.data!,
            (element) => element.id == id);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      updateUI();
    }
  }
}
