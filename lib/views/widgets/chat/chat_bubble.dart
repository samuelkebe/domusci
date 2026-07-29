import 'package:flutter/material.dart';
import '../../../models/conversation.dart';
import '../../../ressources/app_colors.dart';
import '../../../ressources/app_text_styles.dart';

/// Bulle de message — style conversation moderne.
class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : Colors.white,
          border: isMe ? null : Border.all(color: AppColors.border),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        child: Text(
          message.text,
          style: AppTextStyles.bodyMd.copyWith(color: isMe ? Colors.white : AppColors.textPrimary),
        ),
      ),
    );
  }
}

/// Liste d'aperçu de conversation — écran Messages.
class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback? onTap;
  const ConversationTile({super.key, required this.conversation, this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasUnread = conversation.unreadCount > 0;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(conversation.avatarUrl, width: 52, height: 52, fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(width: 52, height: 52, color: AppColors.tertiary)),
                ),
                if (hasUnread)
                  Positioned(
                    top: -3,
                    right: -3,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(color: AppColors.favorite, shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: Text('${conversation.unreadCount}',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(conversation.name, style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
                      Text(conversation.time, style: AppTextStyles.caption),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    conversation.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySm.copyWith(
                      color: hasUnread ? AppColors.textPrimary : AppColors.textSecondary,
                      fontWeight: hasUnread ? FontWeight.w600 : FontWeight.w500,
                    ),
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
