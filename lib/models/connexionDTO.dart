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
      authuserInfo: json['authuserInfo'] != null ? AuthUserInfo.fromJson(json['authuserInfo']) : null,
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
      'authuserInfo': authuserInfo?.toJson(),
      'connexions': connexions?.map((i) => i.toJson()).toList(),
      'statusConnexion': statusConnexion?.toJson(),
    };
  }

}
