import 'package:flutter/widgets.dart';
import 'package:pbl5/models/notification_data/notification_data.dart';
import 'package:pbl5/services/api_models/api_page_response/api_page_response.dart';
import 'package:pbl5/services/service_repositories/notification_repository.dart';
import 'package:pbl5/shared_customization/extensions/api_page_response_ext.dart';
import 'package:pbl5/shared_customization/helpers/dialogs/dialog_helper.dart';
import 'package:pbl5/view_models/base_view_model.dart';

// git commit -m "PBL-594 notification"

class NotificationViewModel extends BaseViewModel {
  ///
  /// States
  ///
  ApiPageResponse<NotificationData>? notificationData;

  ///
  /// Other dependencies
  ///
  final NotificationRepository _notificationRepository;

  NotificationViewModel({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  ///
  /// Events
  ///
  Future<void> getNotifications({int page = 1}) async {
    try {
      var response = await _notificationRepository.getNotifications(page: page);
      notificationData = notificationData.insertPage(response);
    } catch (e) {
      debugPrint(e.toString());
      notificationData = ApiPageResponse.empty();
    }
    updateUI();
  }

  Future<void> markAsRead(String id) async {
    try {
      bool isSuccess = await _notificationRepository.markAsRead(id);
      if (isSuccess) {
        notificationData = notificationData?.update(
            (element) => element.copyWith(readStatus: true),
            (element) => element.id == id);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    updateUI();
  }

  Future<void> markAllAsRead() async {
    final cancel = showLoading();
    try {
      bool isSuccess = await _notificationRepository.markAllAsRead();
      if (isSuccess) {
        notificationData = notificationData.update(
            (element) => element.copyWith(readStatus: true),
            (element) => element.readStatus == false);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      cancel();
    }
    updateUI();
  }
}
