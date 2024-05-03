import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential.g.dart';

part 'credential.freezed.dart';

@freezed
class Credential with _$Credential {
  const factory Credential({
    @JsonKey(name: "access_token") String? accessToken,
    @JsonKey(name: "refresh_token") String? refreshToken,
    @JsonKey(name: 'expired_at') String? expiredAt,
    @JsonKey(name: 'type') String? type,
  }) = _Credential;

  static Credential get empty => const Credential();

  factory Credential.fromJson(Map<String, dynamic> json) =>
      _$CredentialFromJson(json);
}
