import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/application_position/application_position.dart';
import 'package:pbl5/models/language/language.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/models/user_awards/user_awards.dart';
import 'package:pbl5/models/user_educations/user_educations.dart';
import 'package:pbl5/models/user_experiences/user_experiences.dart';

part 'user.g.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'account_id') String? id,
    String? email,
    String? password,
    @JsonKey(name: 'account_status') bool? accountStatus,
    String? address,
    String? avatar,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: "system_role") SystemConstant? systemRole,
    bool? gender,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: 'date_of_birth') String? dob,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'application_positions')
    @Default([])
    @JsonKey(name: 'application_positions')
    List<ApplicationPosition> applicationPositions,
    @Default([]) List<Language> languages,
    @JsonKey(name: 'summary_introduction') String? summaryIntroduction,
    @Default([])
    @JsonKey(name: 'social_media_link')
    List<String> socialMediaLink,
    @Default([]) List<UserEducations> educations,
    @Default([]) List<UserAwards> awards,
    @Default([]) List<UserExperiences> experiences,
  }) = _User;

  static User get empty => const User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
