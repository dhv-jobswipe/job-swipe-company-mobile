import 'dart:math';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:pbl5/app_common_data/extensions/unread_count_ext.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/conversation/conversation_screen.dart';
import 'package:pbl5/screens/notification/notification_screen.dart';
import 'package:pbl5/screens/profile/profile_screen.dart';
import 'package:pbl5/screens/swipe_selection/swipe_selection_screen.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_dismiss_keyboard.dart';
import 'package:pbl5/view_models/app_notification_view_model.dart';
import 'package:pbl5/view_models/conversation_view_model.dart';
import 'package:pbl5/view_models/main_view_model.dart';
import 'package:pbl5/view_models/notification_view_model.dart';
import 'package:pbl5/view_models/profile_view_model.dart';
import 'package:pbl5/view_models/swipe_selection_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainViewModel viewModel;
  late AppNotificationViewModel appNotificationViewModel;

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);
  final _pageController = PageController(initialPage: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const SwipeSelectionScreen(),
    const NotificationScreen(),
    const ConversationScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    viewModel = GetIt.instance.get<MainViewModel>();
    appNotificationViewModel = GetIt.instance.get<AppNotificationViewModel>();
    // Connect to socket server
    appNotificationViewModel
      ..connectToSocket(
        dotenv.env["SOCKET_HOST"]!,
        dotenv.env["SOCKET_PORT"]!,
      )
      ..getUnreadNotificationCount();
    // Get notifications
    GetIt.instance.get<NotificationViewModel>().getNotifications();
    // Get conversations
    GetIt.instance.get<ConversationViewModel>().getConversation();
    // Get profile
    GetIt.instance.get<ProfileViewModel>().getProfile();
    //Get list companies
    GetIt.instance.get<SwipeSelectionViewModel>().getRecommendedCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView.multi(
      providers: [
        ChangeNotifierProvider(create: (_) => viewModel),
        ChangeNotifierProvider(create: (_) => appNotificationViewModel),
      ],
      canPop: false,
      mobileBuilder: (context) {
        return CustomDismissKeyboard(
          canPop: false,
          child: Scaffold(
            backgroundColor: Colors.white38,
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  bottomBarPages.length, (index) => bottomBarPages[index]),
            ),
            extendBody: true,
            bottomNavigationBar: (bottomBarPages.length <= maxCount)
                ? AnimatedNotchBottomBar(
                    /// Provide NotchBottomBarController
                    notchBottomBarController: _controller,
                    color: Colors.white,
                    showLabel: false,
                    shadowElevation: 8,
                    kBottomRadius: 28.0,
                    notchShader: const SweepGradient(
                      startAngle: 0,
                      endAngle: pi / 5,
                      colors: [
                        Color(0xFFFF3868),
                        Color(0xFFFFB49A),
                      ],
                      tileMode: TileMode.mirror,
                    ).createShader(
                        Rect.fromCircle(center: Offset.zero, radius: 8.0)),
                    notchColor: Colors.white,

                    /// restart app if you change removeMargins
                    removeMargins: false,
                    bottomBarWidth: 500,
                    showShadow: true,
                    durationInMilliSeconds: 350,
                    elevation: 1,
                    bottomBarItems: [
                      BottomBarItem(
                        inActiveItem: Icon(
                          FontAwesomeIcons.house,
                          color: Colors.black54,
                          size: 24,
                        ),
                        activeItem: Icon(
                          FontAwesomeIcons.house,
                          color: Colors.white,
                          size: 24,
                        ),
                        itemLabel: 'Page 1',
                      ),
                      BottomBarItem(
                        inActiveItem: Icon(
                          FontAwesomeIcons.solidBell,
                          color: Colors.black54,
                          size: 24,
                        ).withUnreadCount(
                          context.select<AppNotificationViewModel, int>(
                              (vm) => vm.unreadNotificationCount),
                        ),
                        activeItem: Icon(
                          FontAwesomeIcons.solidBell,
                          color: Colors.white,
                          size: 24,
                        ).withUnreadCount(
                          context.select<AppNotificationViewModel, int>(
                              (vm) => vm.unreadNotificationCount),
                        ),
                        itemLabel: 'Page 2',
                      ),
                      BottomBarItem(
                        inActiveItem: Icon(
                          FontAwesomeIcons.solidMessage,
                          color: Colors.black54,
                          size: 24,
                        ),
                        activeItem: Icon(
                          FontAwesomeIcons.solidMessage,
                          color: Colors.white,
                          size: 24,
                        ),
                        itemLabel: 'Page 4',
                      ),
                      BottomBarItem(
                        inActiveItem: Icon(
                          FontAwesomeIcons.solidUser,
                          color: Colors.black54,
                          size: 24,
                        ),
                        activeItem: Icon(
                          FontAwesomeIcons.solidUser,
                          color: Colors.white,
                          size: 24,
                        ),
                        itemLabel: 'Page 5',
                      ),
                    ],
                    onTap: (index) {
                      /// perform action on tab change and to update pages you can update pages without pages
                      _pageController.jumpToPage(index);
                    },
                    kIconSize: 24.0,
                  )
                : null,
          ),
        );
      },
    );
  }
}
