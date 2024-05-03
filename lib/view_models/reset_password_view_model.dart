import 'package:flutter/widgets.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/dialogs/dialog_helper.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class ResetPasswordViewModel extends BaseViewModel {
  ///
  /// States
  ///
  String? email;
  String? resetPwdCode;
  String? newPwd;
  String? confirmPwd;

  ///
  /// Other dependencies
  ///
  final AuthenticationRepositoty _authenticationRepositoty;

  ResetPasswordViewModel({
    required AuthenticationRepositoty authenticationRepositoty,
  }) : _authenticationRepositoty = authenticationRepositoty;

  ///
  /// Events
  ///
  void init(String email) {
    this.email = email;
  }

  Future<void> resendForgotPasswordRequest({
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

  Future<void> resetPassword({
    void Function(String error)? onFail,
    VoidCallback? onSuccess,
  }) async {
    if (email.isEmptyOrNull ||
        resetPwdCode.isEmptyOrNull ||
        newPwd.isEmptyOrNull ||
        confirmPwd.isEmptyOrNull) return;
    final cancel = showLoading();
    try {
      bool isSuccess = await _authenticationRepositoty.resetPassword(
          resetPwdCode!, email!, newPwd!, confirmPwd!);
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
