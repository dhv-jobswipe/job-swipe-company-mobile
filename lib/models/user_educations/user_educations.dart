import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_educations.g.dart';

part 'user_educations.freezed.dart';

@freezed
class UserEducations with _$UserEducations {
  @JsonSerializable(includeIfNull: false)
  const factory UserEducations({
    @JsonKey(name: 'id', includeIfNull: false) String? id,
    @JsonKey(name: 'account_id', includeIfNull: false) String? accountId,
    @JsonKey(name: 'study_place', includeIfNull: false) String? studyPlace,
    @JsonKey(name: 'study_end_time', includeIfNull: false) String? studyEndTime,
    @JsonKey(name: 'study_start_time', includeIfNull: false)
    String? studyStartTime,
    @JsonKey(name: 'majority', includeIfNull: false) String? majority,
    @JsonKey(name: 'cpa', includeIfNull: false) double? cpa,
    @JsonKey(name: 'note', includeIfNull: false) String? note,
    @JsonKey(name: 'created_at', includeIfNull: false) String? createdAt,
    @JsonKey(name: 'updated_at', includeIfNull: false) String? updatedAt,
  }) = _UserEducations;

  factory UserEducations.fromJson(Map<String, dynamic> json) =>
      _$UserEducationsFromJson(
        json,
      );
}
