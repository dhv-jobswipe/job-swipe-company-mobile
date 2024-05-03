import 'package:freezed_annotation/freezed_annotation.dart';
import '/services/api_models/paging/paging.dart';
import '/services/api_models/api_error_response/api_error_response.dart';

part 'api_page_response.g.dart';
part 'api_page_response.freezed.dart';

@Freezed(genericArgumentFactories: true)
class ApiPageResponse<T> with _$ApiPageResponse<T> {
  const factory ApiPageResponse({
    String? status,
    List<T>? data,
    String? message,
    ApiErrorResponse? error,
    @JsonKey(name: "meta") Paging? paging,
  }) = _ApiPageResponse<T>;

  factory ApiPageResponse.empty() => const ApiPageResponse(data: []);

  factory ApiPageResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiPageResponseFromJson(json, fromJsonT);
}
