import 'authUserInfo.dart';  
import 'connexion.dart';  
import 'statusConnexion.dart'; 

class ConnexionDTO {
  final AuthUserInfo? authuserInfo;
  final List<Connexion>? connexions;
  final StatusConnexion? statusConnexion;

  ConnexionDTO({
    this.authuserInfo,
    this.connexions,
    this.statusConnexion,
  });
  
   

  // Factory pour créer une instance de ConnexionDTO à partir d'un JSON
  factory ConnexionDTO.fromJson(Map<String, dynamic> json) {
    return ConnexionDTO(
      // Ici, on va directement utiliser `AuthUserInfo.fromJson()` sans vérification de nullité
      authuserInfo: AuthUserInfo.fromJson(json['authuserInfo']), // Plus besoin de vérifier si c'est null
      connexions: json['connexions'] != null
          ? (json['connexions'] as List).map((i) => Connexion.fromJson(i)).toList()
          : null,
      statusConnexion: json['statusConnexion'] != null
          ? StatusConnexion.fromJson(json['statusConnexion'])
          : null,
    );
  }

  // Méthode pour convertir l'objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'authuserInfo': authuserInfo?.toJson(), // Plus besoin de `?` car `authuserInfo` est `required`
      'connexions': connexions?.map((i) => i.toJson()).toList(),
      'statusConnexion': statusConnexion?.toJson(),
    };
  }

  @override
  String toString() {
    return '''
      ConnexionDTO(
      authUserInfo: ${authuserInfo.toString()},
      connexions: ${connexions?.map((e) => e.toString()).join(", ")},
      statusConnexion: ${statusConnexion.toString()}
    )''';
  }
  
}
