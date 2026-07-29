import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/enum/statut_notification.dart';
import '../models/notification_model.dart';
import '../resources/color.dart';
import '../resources/utils/format_date.dart';
import '../utils/theme_provider.dart';
import '../views-models/notifications_view_model.dart';

class CardNotifications extends StatelessWidget {
  final NotificationModel notification;

  const CardNotifications({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    late final themeProvider = Provider.of<ThemeProvider>(context);
    late final isDarkMode = themeProvider.isDarkMode;
    final viewModel = Provider.of<NotificationsViewModel>(context, listen: false);

    return Card(
      color: isDarkMode ? AppColors.black : AppColors.lighgrey,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: notification.statutNotification == StatutNotification.LUE
                ? Colors.grey
                : AppColors.primaryColor,

            borderRadius: BorderRadius.circular(10),
          ),

          child: Icon(
            Icons.notifications,
            color: isDarkMode ? AppColors.white : AppColors.white,
            size: 20,
          ),
        ),
        title: Text(
          notification.commentaire ?? 'Notification',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: notification.statutNotification == StatutNotification.LUE
                ? (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700)  // Notifications lues
                : (isDarkMode ? Colors.white : Colors.black),                 // Notifications non lues
          ),
        ),        subtitle: Text(
        'Reçue le : ${formatDate(notification.dateHeureCreation)}',
        style:  Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
        onExpansionChanged: (expanded) {
          if (!expanded) {
            // la notif passe à lue quand l'usager ferme la notif
            // viewModel.markAsRead(notification);
          }
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              notification.commentaire ?? '',
              style:  Theme.of(context).textTheme.bodyMedium?.copyWith(

              ),
            ),
          ),
        ],
      ),
    );
  }
}

