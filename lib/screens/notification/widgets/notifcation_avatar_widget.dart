import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/common_data/global_variable.dart';
import 'package:pbl5/app_common_data/enums/notification_type.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/shared_customization/widgets/custom_container.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationAvatarWidget extends StatelessWidget {
  const NotificationAvatarWidget({
    super.key,
    required this.url,
    required this.notificationType,
    this.size = 60,
  });
  final String? url;
  final SystemConstant? notificationType;
  final double size;

  @override
  Widget build(BuildContext context) {
    var type = NotificationType.fromValue(notificationType?.constantType ?? '');
    return Stack(
      children: [
        CustomContainer(
          padding: const EdgeInsets.all(2),
          border: Border.all(
            color: type.color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(1000),
          child: CustomImage.avatar(
            url: type.isAdminNotification ? null : url,
            assetUrl:
                type.isAdminNotification ? "assets/images/logo_dash.png" : null,
            size: size,
            borderRadius: BorderRadius.circular(size),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: icon,
        )
      ],
    );
  }

  Widget get icon {
    try {
      var type =
          NotificationType.fromValue(notificationType?.constantType ?? '');
      switch (type) {
        case NotificationType.MATCHING:
          return CircleAvatar(
            radius: 13,
            backgroundColor: Colors.pink,
            child: FaIcon(
              FontAwesomeIcons.solidHeart,
              color: Colors.white,
              size: 15,
            ),
          );
        case NotificationType.REQUEST_MATCHING:
          return CircleAvatar(
            radius: 13,
            backgroundColor: Colors.green,
            child: FaIcon(
              FontAwesomeIcons.solidPaperPlane,
              color: Colors.white,
              size: 14,
            ),
          );
        case NotificationType.REJECT_MATCHING:
          return CircleAvatar(
            radius: 13,
            backgroundColor: Colors.black,
            child: FaIcon(
              FontAwesomeIcons.xmark,
              color: Colors.white,
              size: 16,
            ),
          );
        case NotificationType.ADMIN_ACTIVATE_ACCOUNT:
        case NotificationType.ADMIN_DEACTIVATE_ACCOUNT:
          return CircleAvatar(
            radius: 13,
            backgroundColor: Colors.blue,
            child: FaIcon(
              FontAwesomeIcons.userTie,
              color: Colors.white,
              size: 14,
            ),
          );
        default:
          return const SizedBox.shrink();
      }
    } catch (e) {
      return EMPTY_WIDGET;
    }
  }
}
