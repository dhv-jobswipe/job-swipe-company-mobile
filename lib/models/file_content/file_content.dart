import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_content.freezed.dart';
part 'file_content.g.dart';

@freezed
class FileContent with _$FileContent {
  factory FileContent({
    String? id,
    String? url,
    String? name,
    @JsonKey(name: 'mime_type') String? mimeType,
    int? size,
  }) = _FileContent;

  factory FileContent.fromJson(Map<String, dynamic> json) =>
      _$FileContentFromJson(json);
}
