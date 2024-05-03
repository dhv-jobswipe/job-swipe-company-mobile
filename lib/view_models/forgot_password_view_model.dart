import 'package:flutter/widgets.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/dialogs/dialog_helper.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  ///
  /// States
  ///
  String? email;

  ///
  /// Other dependencies
  ///
  final AuthenticationRepositoty _authenticationRepositoty;

  ForgotPasswordViewModel({
    required AuthenticationRepositoty authenticationRepositoty,
  }) : _authenticationRepositoty = authenticationRepositoty;

  ///
  /// Events
  ///
  Future<void> sendForgotPasswordRequest({
    void Function(String error)? onFail,
    VoidCallback? onSuccess,
  }) async {
    if (email.isEmptyOrNull) return;
    final cancel = showLoading();
    try {
      bool isSuccess = await _authenticationRepositoty.forgotPassword(email!);
      if (isSuccess) {
        onSuccess?.call();
      }
    } catch (e) {
      debugPrint("Error: $e");
      onFail?.call(parseError(e));
    } finally {
      cancel();
      updateUI();
    }
  }
}
