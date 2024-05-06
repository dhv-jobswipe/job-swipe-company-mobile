import 'package:pbl5/app_common_data/enums/system_constant_prefix.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/services/api_models/api_response/api_response.dart';
import 'package:pbl5/services/apis/api_client.dart';

class SystemConstantRepository {
  final ApiClient apis;

  const SystemConstantRepository({required this.apis});

  Future<ApiResponse<List<SystemConstant>>> getSystemConstantsByPrefix(
          SystemConstantPrefix prefix) =>
      apis.getSystemConstantsByPrefix(prefix.prefix);
}
