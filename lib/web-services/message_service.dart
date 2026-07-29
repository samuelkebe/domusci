import '../models/conversation.dart';
import 'mock/mock_conversations.dart';

class MessageService {
  Future<List<Conversation>> fetchConversations() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return MockConversations.all;
  }
}
