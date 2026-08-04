import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';

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

  String get icon {
    switch (type) {
      case NotificationType.newListing:
        return Mdi.abacus;
      case NotificationType.priceDrop:
        return Mdi.trending_down;
      case NotificationType.message:
        return Mdi.chat;
      case NotificationType.visitConfirmed:
        return Mdi.event_available;
      case NotificationType.listingValidated:
        return Mdi.verified;
    }
  }
}

