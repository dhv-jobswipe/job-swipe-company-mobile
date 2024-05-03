import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pbl5/generated/assets.gen.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/notification/widgets/notification_item_widget.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/helpers/modal_popup/common_option_bottom_sheet.dart';
import 'package:pbl5/shared_customization/helpers/modal_popup/model_popup_helper.dart';
import 'package:pbl5/shared_customization/widgets/buttons/custom_icon_button.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_list.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import 'package:pbl5/view_models/app_notification_view_model.dart';
import 'package:pbl5/view_models/notification_view_model.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationViewModel viewModel;

  @override
  void initState() {
    viewModel = getIt.get<NotificationViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: viewModel,
      mobileBuilder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'JobSwipe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.pink,
              ),
            ),
            actions: [
              CustomIconButton(
                onPressed: () {
                  showCommonOptionBottomSheet([
                    CommonOptionBottomSheet(
                      icon: FontAwesomeIcons.circleCheck,
                      iconColor: Colors.pink,
                      title: "Mark all notifications as read",
                      onTap: () {
                        if (context
                                .of<AppNotificationViewModel>()
                                .unreadNotificationCount >
                            0) {
                          viewModel.markAllAsRead().whenComplete(() {
                            getIt.get<AppNotificationViewModel>()
                              ..unreadNotificationCount = 0
                              ..updateUI();
                          });
                        }
                      },
                    )
                  ]);
                },
                icon: FontAwesomeIcons.gear,
                color: Colors.black54,
                size: 22,
                padding: const EdgeInsets.all(12),
              )
            ],
            leading: const SizedBox.shrink(),
            leadingWidth: 0,
          ),
          body: CustomList(
              sourceData: context
                  .select((NotificationViewModel vm) => vm.notificationData),
              onReload: () async {
                await viewModel.getNotifications();
                await getIt
                    .get<AppNotificationViewModel>()
                    .getUnreadNotificationCount();
              },
              onItemRender: (item) => NotificationItemWidget(item: item),
              onLoadMore: (page) => viewModel.getNotifications(page: page),
              emptyListIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.icons.icEmptyNotification.svg(
                    height: context.screenSize.width * 0.5,
                    width: context.screenSize.width * 0.5,
                  ),
                  const SizedBox(height: 16),
                  CustomText(
                    "No notification",
                  ),
                ],
              )),
        );
      },
    );
  }
}
