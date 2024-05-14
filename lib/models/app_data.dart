import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/enums/system_constant_prefix.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/services/service_repositories/system_constant_repository.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';

//git commit -m "PBL-577 <message>"
//git commit -m "PBL-552 <message>"
class AppData {
  User? user;
  Company? company;
  Map<SystemConstantPrefix, List<SystemConstant>> systemConstants = {};

  Future<void> fetchAllSystemConstants() async {
    try {
      for (var prefix in SystemConstantPrefix.values) {
        var response = await getIt
            .get<SystemConstantRepository>()
            .getSystemConstantsByPrefix(prefix);
        systemConstants.putIfAbsent(prefix, () => response.data ?? []);
      }
    } catch (e) {
      debugPrint(parseError(e));
      systemConstants = {};
    }
  }

  void clear() {
    user = null;
    company = null;
  }
}
