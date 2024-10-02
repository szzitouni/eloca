class AuthUserInfo {
  List<dynamic>? authorities;
  String? cgu;
  String? email;
  int? id;
  List<int>? idImmeuble;
  List<int>? idLot;
  List<int>? idPole;
  List<int>? idProfil;
  List<int>? idTiers;
  List<int>? listIdPoleTC;
  String? nom;
  String? prenom;
  String? referenceLocataire;
  String? username;

 AuthUserInfo({
    this.authorities,
    this.cgu,
    this.email,
    this.id,
    this.idImmeuble,
    this.idLot,
    this.idPole,
    this.idProfil,
    this.idTiers,
    this.listIdPoleTC,
    this.nom,
    this.prenom,
    this.referenceLocataire,
    this.username,
  });
   // Factory pour créer une instance de AuthUserInfo à partir d'un JSON
  factory AuthUserInfo.fromJson(Map<String, dynamic> json) {
    return AuthUserInfo(
      authorities: json['authorities'] != null ? List<dynamic>.from(json['authorities']) : null,
      cgu: json['cgu'],
      email: json['email'],
      id: json['id'],
      idImmeuble: json['idImmeuble'] != null ? List<int>.from(json['idImmeuble']) : null,
      idLot: json['idLot'] != null ? List<int>.from(json['idLot']) : null,
      idPole: json['idPole'] != null ? List<int>.from(json['idPole']) : null,
      idProfil: json['idProfil'] != null ? List<int>.from(json['idProfil']) : null,
      idTiers: json['idTiers'] != null ? List<int>.from(json['idTiers']) : null,
      listIdPoleTC: json['listIdPoleTC'] != null ? List<int>.from(json['listIdPoleTC']) : null,
      nom: json['nom'],
      prenom: json['prenom'],
      referenceLocataire: json['referenceLocataire'],
      username: json['username'],
    );
  }

  // Méthode pour convertir l'objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'authorities': authorities,
      'cgu': cgu,
      'email': email,
      'id': id,
      'idImmeuble': idImmeuble,
      'idLot': idLot,
      'idPole': idPole,
      'idProfil': idProfil,
      'idTiers': idTiers,
      'listIdPoleTC': listIdPoleTC,
      'nom': nom,
      'prenom': prenom,
      'referenceLocataire': referenceLocataire,
      'username': username,
    };
  }


}
