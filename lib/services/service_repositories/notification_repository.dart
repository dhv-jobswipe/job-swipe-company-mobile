import 'package:pbl5/models/notification_data/notification_data.dart';
import 'package:pbl5/services/api_models/api_page_response/api_page_response.dart';
import 'package:pbl5/services/api_models/api_response/api_response.dart';
import 'package:pbl5/services/apis/api_client.dart';

class NotificationRepository {
  final ApiClient apis;

  const NotificationRepository({required this.apis});

  Future<ApiPageResponse<NotificationData>> getNotifications({int page = 1}) =>
      apis.getNotifications(page: page);

  Future<ApiResponse<NotificationData>> getNotification(String id) =>
      apis.getNotificationById(id);

  Future<int> getUnreadNotificationCount() async {
    try {
      return (await apis.getUnreadNotificationCount()).data;
    } catch (e) {
      return 0;
    }
  }

  Future<bool> markAsRead(String id) async {
    try {
      return (await apis.markAsRead(id)).status == "success";
    } catch (e) {
      return false;
    }
  }

  Future<bool> markAllAsRead() async {
    try {
      return (await apis.markAllAsRead()).status == "success";
    } catch (e) {
      return false;
    }
  }
}
