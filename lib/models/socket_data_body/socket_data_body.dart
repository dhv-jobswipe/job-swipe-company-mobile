import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';

part 'socket_data_body.freezed.dart';
part 'socket_data_body.g.dart';

@freezed
class SocketDataBody with _$SocketDataBody {
  factory SocketDataBody({
    SystemConstant? type,
    String? data,
  }) = _SocketDataBody;

  factory SocketDataBody.fromJson(Map<String, dynamic> json) =>
      _$SocketDataBodyFromJson(json);
}
