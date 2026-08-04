class TypeBienImmobilier {
  int? id;
  String? libelle;
  String? description;

  TypeBienImmobilier({this.id, this.libelle, this.description});

  factory TypeBienImmobilier.fromJson(Map<String, dynamic> json) {
    return TypeBienImmobilier(
      id: json['id'],
      libelle: json['libelle'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelle': libelle,
      'description': description,
    };
  }
}
