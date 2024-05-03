import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_awards.g.dart';

part 'user_awards.freezed.dart';

@freezed
class UserAwards with _$UserAwards {
  @JsonSerializable(includeIfNull: false)
  const factory UserAwards({
    @JsonKey(name: 'id', includeIfNull: false) String? id,
    @JsonKey(name: 'account_id', includeIfNull: false) String? accountId,
    @JsonKey(name: 'certificate_time', includeIfNull: false)
    String? certificateTime,
    @JsonKey(name: 'certificate_name', includeIfNull: false)
    String? certificateName,
    @JsonKey(name: 'note', includeIfNull: false) String? note,
    @JsonKey(name: 'created_at', includeIfNull: false) String? createdAt,
    @JsonKey(name: 'updated_at', includeIfNull: false) String? updatedAt,
  }) = _UserAwards;

  factory UserAwards.fromJson(Map<String, dynamic> json) =>
      _$UserAwardsFromJson(json);
}
