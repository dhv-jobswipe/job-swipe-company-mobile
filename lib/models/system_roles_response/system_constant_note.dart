import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_constant_note.g.dart';
part 'system_constant_note.freezed.dart';

@freezed
class SystemConstantNote with _$SystemConstantNote {
  const factory SystemConstantNote({
    @Default([]) List<String> values,
    Validate? validate,
  }) = _SystemConstantNote;

  factory SystemConstantNote.fromJson(Map<String, dynamic> json) =>
      _$SystemConstantNoteFromJson(json);
}

@freezed
class Validate with _$Validate {
  const factory Validate({
    @JsonKey(name: "required_points") bool? requiredPoints,
    int? divisible,
    int? min,
    int? max,
  }) = _Validate;

  factory Validate.fromJson(Map<String, dynamic> json) =>
      _$ValidateFromJson(json);
}
