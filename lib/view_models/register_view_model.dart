import 'package:flutter/material.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
  final AuthenticationRepositoty authenticationRepositoty;
  final emailController = TextEditingController()..text = 'user@gmail.com';
  final passwordController = TextEditingController()..text = '123456Aa';
  final addressController = TextEditingController()..text = 'Hanoi';
  final phoneController = TextEditingController()..text = '0123456789';
  final firstNameController = TextEditingController()..text = 'User';
  final lastNameController = TextEditingController()..text = 'User';
  final dobController = TextEditingController()..text = '1999-01-01';
  bool gender = true;

  RegisterViewModel({
    required this.authenticationRepositoty,
  });

  Future<void> onRegisterPressed({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
    required String systemRoleId,
  }) async {
    try {
      debugPrint(emailController.text);
      debugPrint(passwordController.text);
      await authenticationRepositoty.register(
        user: User(
          email: emailController.text,
          password: passwordController.text,
          address: addressController.text,
          phoneNumber: phoneController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          gender: gender,
          dob: dobController.text,
          systemRole: SystemConstant(constantId: systemRoleId),
        ),
      );
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(parseError(error));
    }
  }
}
