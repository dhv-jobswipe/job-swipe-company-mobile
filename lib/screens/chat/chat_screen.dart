import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/app_text_sytle.dart';
import 'package:pbl5/app_common_data/extensions/scroll_ext.dart';
import 'package:pbl5/generated/assets.gen.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/chat/widgets/chat_input_widget.dart';
import 'package:pbl5/screens/chat/widgets/chat_item_widget.dart';
import 'package:pbl5/shared_customization/animations/three_bounce/loading_animation.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/widgets/buttons/custom_icon_button.dart';
import 'package:pbl5/shared_customization/widgets/custom_list_tile.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_dismiss_keyboard.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_image.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import 'package:pbl5/view_models/chat_view_model.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.conversationId});
  final String conversationId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatViewModel viewModel;
  final _itemScrollController = ItemScrollController();
  bool isLoadMore = false;
  String get conversationId => widget.conversationId;

  @override
  void initState() {
    viewModel = getIt.get<ChatViewModel>();
    viewModel.getConversation(conversationId).whenComplete(() {
      viewModel.getMessages();
      viewModel.markAllAsRead();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDismissKeyboard(
      child: BaseView(
        viewModel: viewModel,
        mobileBuilder: (context) {
          var backgroundColor = Colors.white38;
          var messages =
              context.select((ChatViewModel vm) => vm.messages?.data);
          var conversation =
              context.select((ChatViewModel vm) => vm.conversation);
          var canLoadMore =
              context.select((ChatViewModel vm) => vm.canLoadMore);
          var page = context
              .select((ChatViewModel vm) => vm.messages?.paging?.nextPage ?? 0);
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leadingWidth: 40,
              leading: CustomIconButton(
                  onPressed: () {
                    viewModel.clearData();
                    context.pop();
                  },
                  icon: Icons.arrow_back_ios,
                  color: Colors.pink,
                  size: 23,
                  padding: const EdgeInsets.symmetric(horizontal: 16)),
              title: CustomListTile(
                contentPadding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                leading: CustomImage.avatar(
                  url: conversation?.user?.avatar,
                  borderRadius: BorderRadius.circular(100),
                  size: 45,
                ),
                onTap: () {},
                titleWidget: CustomText(
                  "${conversation?.user?.lastName} ${conversation?.user?.firstName}",
                  style: AppTextStyle.titleText,
                  color: Colors.pink,
                ),
              ),
              actions: const [],
            ),
            body: Column(
              children: [
                ///
                /// List messages
                ///
                Expanded(
                  child: Builder(builder: (context) {
                    // Loading
                    if (messages == null) {
                      return const Center(
                          child: LoadingAnimation(color: Colors.pink));
                    }
                    // Empty
                    if (messages.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icons.icEmptyMessage.svg(
                            height: context.screenSize.width * 0.5,
                            width: context.screenSize.width * 0.5,
                          ),
                          const SizedBox(height: 16),
                          CustomText("No message")
                        ],
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // is load more
                        if (isLoadMore)
                          const Center(
                              child:
                                  LinearProgressIndicator(color: Colors.pink)),
                        Flexible(
                          child: NotificationListener(
                            onNotification: (notification) {
                              if (notification.isTopScroll && canLoadMore) {
                                setState(() => isLoadMore = true);
                                viewModel
                                    .getMessages(page: page)
                                    .whenComplete(() {
                                  setState(() => isLoadMore = false);
                                  return false;
                                });
                              }
                              return false;
                            },
                            child: ScrollablePositionedList.separated(
                              separatorBuilder: (_, index) =>
                                  const SizedBox(height: 3),
                              itemScrollController: _itemScrollController,
                              itemCount: messages.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              reverse: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              itemBuilder: (context, index) {
                                return ChatItemWidget(
                                  key: Key(const Uuid().v4()),
                                  bgColor: backgroundColor,
                                  message: messages[index],
                                  nextMessage: index < messages.length - 1
                                      ? messages[index + 1]
                                      : null,
                                  prevMessage:
                                      index >= 1 ? messages[index - 1] : null,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 4),

                ///
                /// Chat input
                ///
                ChatInputWidget(onSend: (inputModel) {
                  viewModel.sendMessage(
                      content: inputModel.content, files: inputModel.files);
                })
              ],
            ),
          );
        },
      ),
    );
  }
}
