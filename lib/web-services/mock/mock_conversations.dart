import '../../models/conversation.dart';

class MockConversations {
  MockConversations._();

  static const List<Conversation> all = [
    Conversation(
      name: 'Agence Riviera Immo',
      avatarUrl: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=200&auto=format&fit=crop',
      lastMessage: 'La visite est confirmée pour samedi 10h ✅',
      time: '09:24',
      unreadCount: 2,
      online: true,
      messages: [
        ChatMessage(text: "Bonjour, la villa de Riviera Golf est-elle toujours disponible ?", isMe: false, time: '09:10'),
        ChatMessage(text: 'Oui tout à fait ! Souhaitez-vous programmer une visite ?', isMe: true, time: '09:14'),
        ChatMessage(text: 'Avec plaisir, samedi matin si possible 🙏', isMe: false, time: '09:20'),
        ChatMessage(text: 'La visite est confirmée pour samedi 10h ✅', isMe: true, time: '09:24'),
      ],
    ),
    Conversation(
      name: 'Amara Koffi',
      subtitle: 'Propriétaire',
      avatarUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?q=80&w=200&auto=format&fit=crop',
      lastMessage: 'Bonjour, le studio est-il toujours disponible ?',
      time: 'Hier',
    ),
    Conversation(
      name: 'CI Prestige Immobilier',
      avatarUrl: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=200&auto=format&fit=crop',
      lastMessage: 'Vous avez envoyé une photo',
      time: 'Hier',
    ),
    Conversation(
      name: 'Fatou Diabaté',
      avatarUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?q=80&w=200&auto=format&fit=crop',
      lastMessage: 'Merci, à bientôt 👋',
      time: 'Lun',
    ),
  ];
}
