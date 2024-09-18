import 'adresse.dart';

class InfosLot {
  final Adresse? adresse;
  final String? codeTypeLot;
  final String? etage;
  final int? id;
  final List<InfosLot>? lotsSecondaire;
  final String? numeroPorte;
  final double? surfaceCarrez;
  final String? typeLot;

  InfosLot({
    this.adresse,
    this.codeTypeLot,
    this.etage,
    this.id,
    this.lotsSecondaire,
    this.numeroPorte,
    this.surfaceCarrez,
    this.typeLot,
  });
   // Méthode pour créer une instance d'InfosLot à partir d'un JSON
  factory InfosLot.fromJson(Map<String, dynamic> json) {
    return InfosLot(
      adresse: json['adresse'] != null ? Adresse.fromJson(json['adresse']) : null,
      codeTypeLot: json['codeTypeLot'],
      etage: json['etage'],
      id: json['id'],
      lotsSecondaire: json['lotsSecondaire'] != null
          ? List<InfosLot>.from(json['lotsSecondaire'].map((x) => InfosLot.fromJson(x)))
          : null,
      numeroPorte: json['numeroPorte'],
      surfaceCarrez: (json['surfaceCarrez'] as num?)?.toDouble(),
      typeLot: json['typeLot'],
    );
  }

  // Méthode pour convertir une instance d'InfosLot en JSON
  Map<String, dynamic> toJson() {
    return {
      'adresse': adresse?.toJson(),
      'codeTypeLot': codeTypeLot,
      'etage': etage,
      'id': id,
      'lotsSecondaire': lotsSecondaire?.map((e) => e.toJson()).toList(),
      'numeroPorte': numeroPorte,
      'surfaceCarrez': surfaceCarrez,
      'typeLot': typeLot,
    };
  }
  }

