import 'package:flutter/material.dart';
import 'package:pbl5/generated/assets.gen.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/conversation/widgets/conversation_item_widget.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/widgets/custom_divider.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_dismiss_keyboard.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_list.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import 'package:pbl5/view_models/conversation_view_model.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late final ConversationViewModel viewModel;

  @override
  void initState() {
    viewModel = getIt.get<ConversationViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDismissKeyboard(
      child: BaseView(
        viewModel: viewModel,
        mobileBuilder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(
              'JobSwipe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.pink,
              ),
            ),
            leading: const SizedBox.shrink(),
            leadingWidth: 0,
          ),
          body: CustomList(
              sourceData: context
                  .select((ConversationViewModel vm) => vm.conversations),
              onReload: viewModel.getConversation,
              onItemRender: (item) =>
                  ConversationItemWidget(conversation: item),
              onLoadMore: (page) => viewModel.getConversation(page: page),
              separatedWidget:
                  CustomDivider.horizontal(color: Colors.pink.shade300),
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
                    "No conversation",
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
