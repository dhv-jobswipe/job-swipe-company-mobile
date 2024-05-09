import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/models/user/user.dart';

part 'pair.freezed.dart';

part 'pair.g.dart';

@freezed
class Pair with _$Pair {
  @JsonSerializable(includeIfNull: false)
  const factory Pair({
    String? id,
    @JsonKey(name: 'Paired_time') String? PairedTime,
    User? user,
    @JsonKey(name: 'user_Paired') bool? userPaired,
    Company? company,
    @JsonKey(name: 'company_Paired') bool? companyPaired,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Pair;

  factory Pair.fromJson(Map<String, dynamic> json) => _$PairFromJson(json);
}
