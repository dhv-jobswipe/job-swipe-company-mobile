import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';

part 'application_position.freezed.dart';
part 'application_position.g.dart';

@freezed
class ApplicationPosition with _$ApplicationPosition {
  factory ApplicationPosition({
    String? id,
    bool? status,
    @JsonKey(name: 'apply_position') SystemConstant? applyPosition,
    List<Skill>? skills,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _ApplicationPosition;

  factory ApplicationPosition.fromJson(Map<String, dynamic> json) =>
      _$ApplicationPositionFromJson(json);
}

@freezed
class Skill with _$Skill {
  factory Skill({
    String? id,
    @JsonKey(name: 'created_at') String? createdAt,
    SystemConstant? skill,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
