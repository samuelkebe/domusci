import 'package:pisso/models/bien_immobilier_model.dart';
import 'package:pisso/models/type_bien.dart';

import 'enum/statut_annonce.dart';
import 'enum/type_offre.dart';

class Annonce {
   String? id;
   String? libelle;
   String? description;
   TypeOffre? typeOffre;
   TypeBienImmobilier? typeBienImmobilier;
   StatutAnnonce? statutAnnonce;
   BienImmobilier? bienImmobilier;
   List<String>? images;
   bool? negociable;
   bool? disponible;
   DateTime? dateLiberation;
   DateTime? dateCreation;


   Annonce({
      this.id,
      this.libelle,
      this.description,
      this.typeOffre,
      this.typeBienImmobilier,
      this.statutAnnonce,
      this.bienImmobilier,
      this.images,
      this.negociable,
      this.disponible,
      this.dateLiberation,
      this.dateCreation,
   });
}
