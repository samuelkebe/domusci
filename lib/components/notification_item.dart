import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

enum NotificationType { newListing, priceDrop, message, visitConfirmed, listingValidated }

class NotificationItem {
  final NotificationType type;
  final String title;
  final String description;
  final String time;
  final bool unread;

  const NotificationItem({
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    this.unread = false,
  });

}

