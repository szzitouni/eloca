class Gestionnaire {
  final String? fonctionCode;
  final int? idProfil;
  final int? idTiers;
  final String? mail;
  final String? nom;
  final String? prenom;

  Gestionnaire({
    this.fonctionCode,
    this.idProfil,
    this.idTiers,
    this.mail,
    this.nom, 
    this.prenom,
  });

  // Création d'n objet Gestionnaire à partir d'une map 
  factory Gestionnaire.fromJson(Map<String, dynamic> json) {
    return Gestionnaire(
      fonctionCode: json['fonctionCode'],
      idProfil: json['idProfil'],
      idTiers: json['idTiers'],
      mail: json['mail'],
      nom: json['nom'],
      prenom: json['prenom'],
    );
  }

  // Conversion dun objet Gestionnaire en map
  Map<String, dynamic> toJson() {
    return {
      'fonctionCode': fonctionCode,
      'idProfil': idProfil,
      'idTiers': idTiers,
      'mail': mail,
      'nom': nom,
      'prenom': prenom,
    };
  }
}
