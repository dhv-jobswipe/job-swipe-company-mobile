import 'package:flutter/material.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class IntegratedAuthViewModel extends BaseViewModel {
  final AuthenticationRepositoty authenticationRepositoty;
  SystemRolesResponse? systemRoleResponse;

  IntegratedAuthViewModel({
    required this.authenticationRepositoty,
  });

  Future<void> getSystemRole({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      systemRoleResponse = (await authenticationRepositoty.getSystemRole());
    } on Exception catch (error) {
      onFailure?.call(parseError(error));
    }
  }

  String? getUserSystemRoleId() {
    return systemRoleResponse?.data
        .firstWhere((e) => e.constantName!.toLowerCase() == 'user')
        .constantId;
  }

  String? getCompanySystemRoleId() {
    return systemRoleResponse?.data
        .firstWhere((e) => e.constantName!.toLowerCase() == 'company')
        .constantId;
  }
}
