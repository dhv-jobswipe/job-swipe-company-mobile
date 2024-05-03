// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging.g.dart';
part 'paging.freezed.dart';

@freezed
class Paging with _$Paging {
  const factory Paging({
    @JsonKey(name: 'current_page', includeFromJson: true, includeToJson: false)
    @Default(0)
    int currentPage,
    @JsonKey(name: 'next_page', includeFromJson: true, includeToJson: false)
    @Default(0)
    int nextPage,
    @JsonKey(name: 'previous_page', includeFromJson: true, includeToJson: false)
    @Default(0)
    int prevPage,
    @JsonKey(name: 'total_page', includeFromJson: true, includeToJson: false)
    @Default(0)
    int totalPages,
    @JsonKey(name: 'total_count', includeFromJson: true, includeToJson: false)
    @Default(0)
    int totalCount,
  }) = _Paging;

  static Paging get empty => const Paging();

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);
}
