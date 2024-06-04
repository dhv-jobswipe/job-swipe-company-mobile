import 'package:flutter/material.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
  final AuthenticationRepositoty authenticationRepositoty;
  final emailController = TextEditingController()..text = '';
  final passwordController = TextEditingController()..text = '';
  final addressController = TextEditingController()..text = '';
  final phoneController = TextEditingController()..text = '';
  final companyNameController = TextEditingController()..text = '';
  final comapyUrlController = TextEditingController()..text = '';
  final establishedDateController = TextEditingController()..text = '';

  RegisterViewModel({required this.authenticationRepositoty});

  Future<void> onRegisterPressed({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
    required String systemRoleId,
  }) async {
    try {
      debugPrint(emailController.text);
      debugPrint(passwordController.text);
      await authenticationRepositoty.register(
        Company(
          email: emailController.text,
          address: addressController.text,
          phoneNumber: phoneController.text,
          companyName: companyNameController.text,
          companyUrl: comapyUrlController.text,
          establishedDate: establishedDateController.text.toDatetimeApi,
          systemRole: SystemConstant(constantId: systemRoleId),
        ),
        passwordController.text,
      );
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(parseError(error));
    }
  }
}
