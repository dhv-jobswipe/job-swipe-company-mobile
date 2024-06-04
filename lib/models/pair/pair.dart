import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/models/user/user.dart';

part 'pair.freezed.dart';
part 'pair.g.dart';

@freezed
class Pair with _$Pair {
  const factory Pair({
    String? id,
    @JsonKey(name: "matched_time") String? matchedTime,
    User? user,
    @JsonKey(name: "user_matched") bool? userMatched,
    Company? company,
    @JsonKey(name: "company_matched") bool? companyMatched,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,
  }) = _Pair;

  static Pair get empty => const Pair();

  factory Pair.fromJson(Map<String, dynamic> json) => _$PairFromJson(json);
}
