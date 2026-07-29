
import 'enum/statut_notification.dart';
import 'enum/type_notification.dart';

class NotificationModel {
  int? id;
  DateTime? dateHeureCreation;
  String? commentaire;
  TypeNotification? typeNotification;
  StatutNotification? statutNotification;

  NotificationModel({
    this.id,
    this.dateHeureCreation,
    this.commentaire,
    this.typeNotification,
    this.statutNotification,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      dateHeureCreation: json['dateHeureCreation'] != null
          ? DateTime.parse(json['dateHeureCreation'])
          : null,
      commentaire: json['commentaire'],
     
      typeNotification: json['typeNotification'] != null
          ? TypeNotification.fromString(json['typeNotification'])
          : null,
      statutNotification: json['statutNotification'] != null
          ? StatutNotification.fromString(json['statutNotification'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateHeureCreation': dateHeureCreation?.toIso8601String(),
      'commentaire': commentaire,
      'typeNotification': typeNotification?.name,
      'statutNotification': statutNotification?.name,
    };
  }
}