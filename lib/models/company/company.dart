import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/application_position/application_position.dart';
import 'package:pbl5/models/language/language.dart';
import 'package:pbl5/models/other_description/other_description.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';

part 'company.g.dart';

part 'company.freezed.dart';

@freezed
class Company with _$Company {
  const factory Company({
    @JsonKey(name: 'account_id') String? id,
    String? email,
    @JsonKey(name: 'account_status') bool? accountStatus,
    String? address,
    String? avatar,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: "system_role") SystemConstant? systemRole,
    @JsonKey(name: "company_name") String? companyName,
    @JsonKey(name: "company_url") String? companyUrl,
    @JsonKey(name: "established_date") String? establishedDate,
    @Default([]) List<OtherDescription> others,
    @Default([])
    @JsonKey(name: 'application_positions')
    List<ApplicationPosition> applicationPositions,
    @Default([]) List<Language> languages,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: "deleted_at") String? deletedAt,
  }) = _Company;

  static Company get empty => const Company();

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}
