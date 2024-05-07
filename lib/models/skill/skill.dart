import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
class Skill with _$Skill {
  const factory Skill({
    String? id,
    SystemConstant? skill,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(false)
    bool isGenerated,
  }) = _Skill;

  static Skill get empty => const Skill();

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
