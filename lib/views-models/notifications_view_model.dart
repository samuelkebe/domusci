import 'package:flutter/foundation.dart';
import '../models/notification_item.dart';
import '../utils/view_state.dart';
import '../web-services/notification_service.dart';

/// ViewModel — Notifications.
class NotificationsViewModel extends ChangeNotifier {
  final NotificationService _service;
  NotificationsViewModel({NotificationService? service}) : _service = service ?? NotificationService();

  ViewState state = ViewState.idle;
  List<NotificationItem> notifications = [];

  bool get isLoading => state == ViewState.loading;
  int get unreadCount => notifications.where((n) => n.unread).length;

  Future<void> load() async {
    state = ViewState.loading;
    notifyListeners();
    notifications = await _service.fetchAll();
    state = ViewState.loaded;
    notifyListeners();
  }

  void markAllRead() {
    notifications = notifications
        .map((n) => NotificationItem(type: n.type, title: n.title, description: n.description, time: n.time, unread: false))
        .toList();
    notifyListeners();
  }
}
