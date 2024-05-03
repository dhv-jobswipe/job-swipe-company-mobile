import 'package:freezed_annotation/freezed_annotation.dart';

part 'other_description.freezed.dart';
part 'other_description.g.dart';

@freezed
class OtherDescription with _$OtherDescription {
  factory OtherDescription({
    String? id,
    String? title,
    String? description,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _OtherDescription;

  factory OtherDescription.fromJson(Map<String, dynamic> json) =>
      _$OtherDescriptionFromJson(json);
}
