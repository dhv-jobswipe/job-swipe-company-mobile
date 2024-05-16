import 'package:flutter/material.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/services/service_repositories/user_repository.dart';
import 'package:pbl5/shared_customization/helpers/dialogs/dialog_helper.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class DetailViewModel extends BaseViewModel {
  User? user;
  final UserRepository userRepository;

  DetailViewModel({
    required this.userRepository,
  });

  Future<void> onGetUserByIdPressed({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
    required String userId,
  }) async {
    final cancel = showLoading();
    try {
      user = (await userRepository.getProfileById(userId)).data;
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(parseError(error));
    } finally {
      cancel();
    }
  }

  void clear() {
    user = null;
  }
}
