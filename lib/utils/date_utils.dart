/// Utilitaires de date/heure relative — utilisés dans Messages, Notifications, Historique.
class DomusDateUtils {
  DomusDateUtils._();

  static const List<String> _weekDays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];

  static String relativeLabel(DateTime date, {DateTime? now}) {
    final n = now ?? DateTime.now();
    final diff = n.difference(date);
    if (diff.inMinutes < 1) return "À l'instant";
    if (diff.inMinutes < 60) return 'Il y a ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Il y a ${diff.inHours}h';
    if (diff.inDays == 1) return 'Hier';
    if (diff.inDays < 7) return _weekDays[date.weekday - 1];
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
  }
}

