import '../../models/notification_item.dart';

class MockNotifications {
  MockNotifications._();

  static const List<NotificationItem> all = [
    NotificationItem(
      type: NotificationType.newListing,
      title: 'Nouvelle annonce près de chez vous',
      description: "Un appartement 3 pièces vient d'être publié à Cocody",
      time: 'Il y a 12 min',
      unread: true,
    ),
    NotificationItem(
      type: NotificationType.priceDrop,
      title: 'Baisse de prix',
      description: 'La villa de Riviera Golf a baissé de 15 000 000 FCFA',
      time: 'Il y a 2h',
      unread: true,
    ),
    NotificationItem(
      type: NotificationType.message,
      title: 'Nouveau message',
      description: 'Agence Riviera Immo vous a répondu',
      time: 'Il y a 3h',
      unread: true,
    ),
    NotificationItem(
      type: NotificationType.visitConfirmed,
      title: 'Visite confirmée',
      description: 'Votre visite du samedi 10h est confirmée',
      time: 'Hier',
    ),
    NotificationItem(
      type: NotificationType.listingValidated,
      title: 'Annonce validée',
      description: "Votre annonce « Studio meublé » est en ligne",
      time: 'Il y a 2 jours',
    ),
  ];
}
