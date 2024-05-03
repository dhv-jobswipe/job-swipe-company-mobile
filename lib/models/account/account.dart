import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
class Account with _$Account {
  factory Account({
    @JsonKey(name: "account_id") String? accountId,
    String? email,
    @JsonKey(name: "account_status") bool? accountStatus,
    String? address,
    String? avatar,
    @JsonKey(name: "phone_number") String? phoneNumber,
    @JsonKey(name: "system_role") SystemConstant? role,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,
    @JsonKey(name: "deleted_at") String? deletedAt,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
