import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/extensions/message_ext.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/conversation/conversation.dart';
import 'package:pbl5/routes.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/widgets/custom_container.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_image.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import 'package:pbl5/view_models/conversation_view_model.dart';

class ConversationItemWidget extends StatelessWidget {
  const ConversationItemWidget({super.key, required this.conversation});
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .pushNamed(Routes.chat, arguments: conversation.id!)
            .whenComplete(() {
          getIt
              .get<ConversationViewModel>()
              .refreshConversation(conversation.id!);
        });
      },
      child: CustomContainer(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CustomImage.avatar(
              size: 60,
              borderRadius: BorderRadius.circular(1000),
              url: conversation.user?.avatar,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "${conversation.user?.lastName} ${conversation.user?.firstName}",
                    fontWeight: FontWeight.w600,
                    size: 16,
                    maxLines: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomText(
                          conversation.lastMessage?.conversationPreviewContent,
                          maxLines: 1,
                        ),
                      ),
                      if (conversation.lastMessage != null)
                        CustomText.timeAgo(
                          dateTime:
                              conversation.lastMessage!.createdAt.toDateTime ??
                                  DateTime.now(),
                          isShort: true,
                          padding: const EdgeInsets.only(left: 8),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (conversation.lastMessage?.readStatus == false) ...[
              const SizedBox(width: 10),
              CustomContainer(
                width: 8,
                height: 8,
                borderRadius: BorderRadius.circular(1000),
                color: Colors.pink,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
