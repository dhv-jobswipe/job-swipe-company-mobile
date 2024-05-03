import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error_response.g.dart';
part 'api_error_response.freezed.dart';

@freezed
class ApiErrorResponse with _$ApiErrorResponse {
  const factory ApiErrorResponse({
    String? code,
    String? message,
  }) = _ApiErrorResponse;

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);
}
