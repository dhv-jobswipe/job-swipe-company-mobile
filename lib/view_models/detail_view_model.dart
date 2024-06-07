import 'package:flutter/material.dart';
import 'package:pbl5/models/application_position/application_position.dart';
import 'package:pbl5/models/pair/pair.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/services/service_repositories/apply_position_repository.dart';
import 'package:pbl5/services/service_repositories/swipe_selection_repository.dart';
import 'package:pbl5/services/service_repositories/user_repository.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/dialogs/dialog_helper.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class DetailViewModel extends BaseViewModel {
  User? user;
  Pair? pair;
  List<ApplicationPosition> applicationPositions = [];
  final UserRepository userRepository;
  final SwipeSelectionRepository swipeSelectionRepository;
  final ApplyPositionRepository applyPositionRepository;

  DetailViewModel({
    required this.userRepository,
    required this.swipeSelectionRepository,
    required this.applyPositionRepository,
  });

  Future<void> initState({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
    required String userId,
  }) async {
    final cancel = showLoading();
    try {
      pair = (await swipeSelectionRepository.getMatchByAccountId(userId)).data;
    } catch (e) {
      print(parseError(e));
    }

    try {
      user = (await userRepository.getProfileById(userId)).data;
      applicationPositions =
          (await applyPositionRepository.getApplyPositions()).data ?? [];
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(parseError(error));
    } finally {
      cancel();
    }
  }

  Future<void> sendInterviewMail({
    required String interviewDate,
    required String interviewPositionId,
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    if (pair?.id.isEmptyOrNull == true) return;
    final cancel = showLoading();
    try {
      await swipeSelectionRepository.sendInterviewInvitationMail(
          pairId: pair!.id!,
          interviewTime: interviewDate.toDatetimeHourApi!,
          interviewPositionId: interviewPositionId);
      onSuccess?.call();
    } catch (e) {
      onFailure?.call(parseError(e));
    } finally {
      cancel();
    }
  }

  Future<void> acceptPair({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    if (pair?.id.isEmptyOrNull == true) return;
    final cancel = showLoading();
    try {
      var res = (await swipeSelectionRepository.acceptPair(pair!.id!));
      if (res.data != null) {
        pair = res.data;
        updateUI();
      }
      onSuccess?.call();
    } catch (e) {
      onFailure?.call(parseError(e));
    } finally {
      cancel();
    }
  }

  Future<void> declinePair({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    if (pair?.id.isEmptyOrNull == true) return;
    final cancel = showLoading();
    try {
      var res = await swipeSelectionRepository.rejectPair(pair!.id!);
      if (res.data != null) {
        pair = res.data;
        updateUI();
      }
      onSuccess?.call();
    } catch (e) {
      onFailure?.call(parseError(e));
    } finally {
      cancel();
    }
  }

  void clear() {
    user = null;
  }
}
