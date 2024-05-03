import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/account/account.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';

part 'notification_data.freezed.dart';
part 'notification_data.g.dart';

@freezed
class NotificationData with _$NotificationData {
  factory NotificationData({
    String? id,
    @JsonKey(name: "object_id") String? objectId,
    String? content,
    SystemConstant? type,
    @JsonKey(name: "read_status") bool? readStatus,
    Account? sender,
    Account? receiver,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,
  }) = _NotificationData;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
}
