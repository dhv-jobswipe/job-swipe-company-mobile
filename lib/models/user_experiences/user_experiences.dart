import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';

part 'user_experiences.g.dart';

part 'user_experiences.freezed.dart';

@freezed
class UserExperiences with _$UserExperiences {
  @JsonSerializable(includeIfNull: false)
  const factory UserExperiences({
    @JsonKey(name: 'id', includeIfNull: false) String? id,
    @JsonKey(name: 'account_id', includeIfNull: false) String? accountId,
    @JsonKey(name: 'experience_end_time', includeIfNull: false)
    String? experienceEndTime,
    @JsonKey(name: 'experience_start_time', includeIfNull: false)
    String? experienceStartTime,
    @JsonKey(name: 'experience_type', includeIfNull: false)
    SystemConstant? experienceType,
    @JsonKey(name: 'work_place', includeIfNull: false) String? workPlace,
    @JsonKey(name: 'position', includeIfNull: false) String? position,
    @JsonKey(name: 'note', includeIfNull: false) String? note,
    @JsonKey(name: 'created_at', includeIfNull: false) String? createdAt,
    @JsonKey(name: 'updated_at', includeIfNull: false) String? updatedAt,
  }) = _UserExperiences;

  factory UserExperiences.fromJson(Map<String, dynamic> json) =>
      _$UserExperiencesFromJson(json);
}
