import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/system_roles_response/system_constant_note.dart';

part 'system_roles_response.g.dart';

part 'system_roles_response.freezed.dart';

@freezed
class SystemRolesResponse with _$SystemRolesResponse {
  const factory SystemRolesResponse({
    required String status,
    required List<SystemConstant> data,
  }) = _SystemRolesResponse;

  factory SystemRolesResponse.fromJson(Map<String, dynamic> json) =>
      _$SystemRolesResponseFromJson(json);
}

@freezed
class SystemConstant with _$SystemConstant {
  @JsonSerializable(includeIfNull: false)
  const factory SystemConstant({
    @JsonKey(name: "constant_id") String? constantId,
    @JsonKey(name: "constant_type", includeFromJson: true, includeToJson: false)
    String? constantType,
    @JsonKey(name: "constant_name", includeFromJson: true, includeToJson: false)
    String? constantName,
    @JsonKey(includeFromJson: true, includeToJson: false)
    SystemConstantNote? note,
  }) = _SystemRole;

  factory SystemConstant.fromJson(Map<String, dynamic> json) =>
      _$SystemConstantFromJson(json);
}
