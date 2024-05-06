import 'package:freezed_annotation/freezed_annotation.dart';
import '/services/api_models/api_error_response/api_error_response.dart';

part 'api_response.g.dart';

part 'api_response.freezed.dart';

@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    String? status,
    T? data,
    String? message,
    ApiErrorResponse? error,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);
}
