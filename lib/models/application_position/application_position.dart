import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/skill/skill.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';

part 'application_position.freezed.dart';
part 'application_position.g.dart';

//git commit -m "PBL-541 <message>"
//git commit -m "PBL-696 <message>"
//git commit -m "PBL-703 <message>"
//git commit -m "PBL-703 <message>"
//git commit -m "PBL-540 <message>"
@freezed
class ApplicationPosition with _$ApplicationPosition {
  const factory ApplicationPosition({
    String? id,
    bool? status,
    @JsonKey(name: 'apply_position') SystemConstant? applyPosition,
    @JsonKey(name: 'salary_range') SystemConstant? salaryRange,
    List<Skill>? skills,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _ApplicationPosition;

  static ApplicationPosition get empty => const ApplicationPosition();

  factory ApplicationPosition.fromJson(Map<String, dynamic> json) =>
      _$ApplicationPositionFromJson(json);
}
