import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/enums/system_constant_prefix.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/storages.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class LogInViewModel extends BaseViewModel {
  final AuthenticationRepositoty authenticationRepositoty;
  final CustomSharedPreferences customSharedPreferences;
  final emailController = TextEditingController()
    ..text = 'charlesharris@example.org';
  final passwordController = TextEditingController()..text = '123456Aa';

  LogInViewModel({
    required this.authenticationRepositoty,
    required this.customSharedPreferences,
  });

  Future<void> onLoginPressed({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      debugPrint(emailController.text);
      debugPrint(passwordController.text);
      final entity = await authenticationRepositoty.login(
        emailController.text,
        passwordController.text,
      );
      await customSharedPreferences.setToken(
          entity.data?.accessToken ?? '', entity.data?.refreshToken ?? '');

      debugPrint('Access Token: ${customSharedPreferences.accessToken}');
      debugPrint('Refresh Token: ${customSharedPreferences.refreshToken}');

      // Check account
      var account = (await authenticationRepositoty.getAccount()).data!;
      if (SystemRole.fromValue(account.role?.constantType ?? '') !=
          SystemRole.COMPANY) {
        onFailure?.call('Please login with company account.');
        return;
      }

      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(parseError(error));
    }
  }
}
