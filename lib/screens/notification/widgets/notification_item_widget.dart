import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/app_text_sytle.dart';
import 'package:pbl5/app_common_data/enums/notification_type.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/notification_data/notification_data.dart';
import 'package:pbl5/screens/notification/widgets/notifcation_avatar_widget.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/widgets/custom_container.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import 'package:pbl5/view_models/app_notification_view_model.dart';
import 'package:pbl5/view_models/notification_view_model.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({super.key, required this.item});
  final NotificationData item;
  NotificationType get type =>
      NotificationType.fromValue(item.type?.constantType ?? '');

  @override
  Widget build(BuildContext context) {
    var color = context.appTheme.appThemeData;
    return InkWell(
      onTap: () {
        if (item.readStatus == false) {
          getIt
              .get<NotificationViewModel>()
              .markAsRead(item.id ?? '')
              .then((_) {
            var appNotiVM = getIt.get<AppNotificationViewModel>();
            appNotiVM.unreadNotificationCount--;
            appNotiVM.updateUI();
            context.navigateNotification(type);
          });
        } else {
          context.navigateNotification(type);
        }
      },
      child: CustomContainer(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: (item.readStatus ?? true)
            ? color.transparent
            : Colors.pinkAccent.withOpacity(0.15),
        child: Row(
          children: [
            NotificationAvatarWidget(
              url: item.sender?.avatar,
              notificationType: item.type,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Content
                  CustomText(
                    item.content,
                    style: AppTextStyle.titleText,
                    fontWeight: FontWeight.w500,
                    size: 17,
                    maxLines: 2,
                  ),
                  // Time
                  CustomText.timeAgo(
                    dateTime: item.createdAt.toDateTime ?? DateTime.now(),
                    size: 13,
                    color: color.gray500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
