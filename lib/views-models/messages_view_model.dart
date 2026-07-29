import 'package:flutter/foundation.dart';
import '../models/conversation.dart';
import '../utils/view_state.dart';
import '../web-services/message_service.dart';

/// ViewModel — Messages / conversations.
class MessagesViewModel extends ChangeNotifier {
  final MessageService _service;
  MessagesViewModel({MessageService? service}) : _service = service ?? MessageService();

  ViewState state = ViewState.idle;
  List<Conversation> conversations = [];

  bool get isLoading => state == ViewState.loading;

  Future<void> load() async {
    state = ViewState.loading;
    notifyListeners();
    conversations = await _service.fetchConversations();
    state = ViewState.loaded;
    notifyListeners();
  }
}
