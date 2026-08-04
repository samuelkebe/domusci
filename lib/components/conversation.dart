class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  const ChatMessage({required this.text, required this.isMe, required this.time});
}

class Conversation {
  final String name;
  final String subtitle;
  final String avatarUrl;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool online;
  final List<ChatMessage> messages;

  const Conversation({
    required this.name,
    this.subtitle = '',
    required this.avatarUrl,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.online = false,
    this.messages = const [],
  });
}

