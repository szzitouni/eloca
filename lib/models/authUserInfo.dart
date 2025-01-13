class AuthUserInfo {
  List<dynamic>? authorities;
  String? cgu;
  String email;
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
    required this.email,
    this.id,
    this.idImmeuble,
    this.idLot,
    this.idPole,
    this.idProfil,
    this.idTiers,
    this.listIdPoleTC,
    required this.nom,
    required this.prenom,
    this.referenceLocataire,
    this.username,
  });

  
   // Factory pour créer une instance de AuthUserInfo à partir d'un JSON
  factory AuthUserInfo.fromJson(Map<String, dynamic> json) {
    return AuthUserInfo(
      authorities: json['authorities'] as List<dynamic>?,
      cgu: json['cgu'] as String?,
      email: json['email'] ?? '', // Assure que le champ email est obligatoire
      id: json['id'] as int?,
      idImmeuble: (json['idImmeuble'] as List<dynamic>?)
          ?.map((item) => item as int)
          .toList(),
      idLot: (json['idLot'] as List<dynamic>?)?.map((item) => item as int).toList(),
      idPole: (json['idPole'] as List<dynamic>?)?.map((item) => item as int).toList(),
      idProfil:
          (json['idProfil'] as List<dynamic>?)?.map((item) => item as int).toList(),
      idTiers: (json['idTiers'] as List<dynamic>?)?.map((item) => item as int).toList(),
      listIdPoleTC:
          (json['listIdPoleTC'] as List<dynamic>?)?.map((item) => item as int).toList(),
      nom: json['nom'] ?? '', // Assure que le champ nom est obligatoire
      prenom: json['prenom'] ?? '', // Assure que le champ prenom est obligatoire
      referenceLocataire: json['referenceLocataire'] as String?,
      username: json['username'] as String?,
    );
  }

  get adresse => null;
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


@override
  String toString() {
    return '''
      AuthUserInfo(
      email: $email,
      nom: $nom,
      prenom: $prenom,
      id: $id,
      username: $username,
      cgu: $cgu,
      referenceLocataire: $referenceLocataire,
      authorities: $authorities,
      idImmeuble: $idImmeuble,
      idLot: $idLot,
      idPole: $idPole,
      idProfil: $idProfil,
      idTiers: $idTiers,
      listIdPoleTC: $listIdPoleTC
      )''';
  }

}
