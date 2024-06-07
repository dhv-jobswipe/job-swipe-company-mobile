import 'package:flutter/widgets.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/dialogs/dialog_helper.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class ChangePasswordViewModel extends BaseViewModel {
  ///
  /// States
  ///
  String? currentPwd;
  String? newPwd;
  String? confirmNewPwd;

  ///
  /// Other dependencies
  ///
  final AuthenticationRepositoty _authenticationRepositoty;

  ChangePasswordViewModel({
    required AuthenticationRepositoty authenticationRepositoty,
  }) : _authenticationRepositoty = authenticationRepositoty;

  ///
  /// Events
  ///
  Future<void> changePassword({
    void Function(String error)? onFail,
    VoidCallback? onSuccess,
  }) async {
    if (currentPwd.isEmptyOrNull ||
        newPwd.isEmptyOrNull ||
        confirmNewPwd.isEmptyOrNull) {
      onFail?.call("Please fill all fields");
      return;
    }
    final cancel = showLoading();
    try {
      bool isSuccess = await _authenticationRepositoty.changePassword(
        currentPwd: currentPwd!,
        newPwd: newPwd!,
        confirmNewPwd: confirmNewPwd!,
      );
      if (isSuccess) onSuccess?.call();
    } catch (e) {
      onFail?.call(parseError(e));
    } finally {
      cancel();
      updateUI();
    }
  }
}
