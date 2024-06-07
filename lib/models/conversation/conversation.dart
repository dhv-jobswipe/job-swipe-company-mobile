import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/models/message/message.dart';
import 'package:pbl5/models/user/user.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  factory Conversation({
    String? id,
    User? user,
    Company? company,
    @JsonKey(name: "active_status") bool? activeStatus,
    @JsonKey(name: "last_message") Message? lastMessage,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
