import '../models/notification_item.dart';
import 'mock/mock_notifications.dart';

class NotificationService {
  Future<List<NotificationItem>> fetchAll() async {
    await Future.delayed(const Duration(milliseconds: 350));
    return MockNotifications.all;
  }
}
