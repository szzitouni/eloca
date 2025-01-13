import 'adresse.dart';
import 'infosLot.dart';

class Connexion {
  final Adresse? adresse;
  final int? idImmeuble;
  final int? idProfil;
  final int? idTiers;
  final String? identifiant;
  final List<InfosLot>? infosLot;
  final String? lettreCleMaya;
  final String? nom;
  final String? nomImmeuble;
  final String? prenom;
  final String? telephone;
  final bool? hasPositifSold;

  Connexion({
    this.adresse,
    this.idImmeuble,
    this.idProfil,
    this.idTiers,
    this.identifiant,
    this.infosLot,
    this.lettreCleMaya,
    this.nom,
    this.nomImmeuble,
    this.prenom,
    this.telephone,
    this.hasPositifSold,
  });

  // Méthode pour convertir un JSON en Connexion
  factory Connexion.fromJson(Map<String, dynamic> json) {
  return Connexion(
    adresse: json['adresse'] != null ? Adresse.fromJson(json['adresse']) : null,
    idImmeuble: json['idImmeuble'] ?? 0,
    idProfil: json['idProfil'] ?? 0,
    idTiers: json['idTiers'] ?? 0,
    identifiant: json['identifiant'] ?? '',
    infosLot: json['infosLot'] != null
        ? (json['infosLot'] as List).map((item) => InfosLot.fromJson(item)).toList()
        : [],
    lettreCleMaya: json['lettreCleMaya'] ?? '',
    nom: json['nom'] ?? '',
    nomImmeuble: json['nomImmeuble'] ?? '',
    prenom: json['prenom'] ?? '',
    telephone: json['telephone'] ?? '',
    hasPositifSold: json['hasPositifSold'] ?? false,
  );
}
  // Méthode pour convertir un objet Connexion en JSON
  Map<String, dynamic> toJson() {
    return {
      'adresse': adresse?.toJson(),
      'idImmeuble': idImmeuble,
      'idProfil': idProfil,
      'idTiers': idTiers,
      'identifiant': identifiant,
      'infosLot': infosLot?.map((e) => e.toJson()).toList(),
      'lettreCleMaya': lettreCleMaya,
      'nom': nom,
      'nomImmeuble': nomImmeuble,
      'prenom': prenom,
      'telephone': telephone,
      'hasPositifSold': hasPositifSold,
    };
  }

   @override
  String toString() {
    return '''
      Connexion(
      adresse: ${adresse.toString()},
      idImmeuble: $idImmeuble,
      idProfil: $idProfil,
      idTiers: $idTiers,
      identifiant: $identifiant,
      infosLot: ${infosLot.toString()},
      lettreCleMaya: $lettreCleMaya,
      nom: $nom,
      nomImmeuble: $nomImmeuble,
      prenom: $prenom,
      telephone: $telephone,
      hasPositifSold: $hasPositifSold
    )''';
  }

}
