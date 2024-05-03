import 'package:flutter/material.dart';
import 'package:pbl5/models/credential/credential.dart';
import 'package:pbl5/services/api_models/api_response/api_response.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/storages.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class LogInViewModel extends BaseViewModel {
  final AuthenticationRepositoty authenticationRepositoty;
  final CustomSharedPreferences customSharedPreferences;
  final emailController = TextEditingController()..text = 'rachael81@gmail.com';
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
      onSuccessLogin(entity, onSuccess);
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  Future<void> onSuccessLogin(
    ApiResponse<Credential> entity,
    VoidCallback? onSuccess,
  ) async {
    await customSharedPreferences.setToken(
        entity.data?.accessToken ?? '', entity.data?.refreshToken ?? '');

    debugPrint('Access Token: ${customSharedPreferences.accessToken}');
    debugPrint('Refresh Token: ${customSharedPreferences.refreshToken}');
    onSuccess?.call();
  }
}
