import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mon_app/config/config_dev.dart';
import 'package:mon_app/exceptions/badCurrentPwdException.dart';
import 'package:mon_app/login/auth_service.dart';
import 'package:mon_app/models/ChangerMdpDTO.dart'; // Assurez-vous que Config est correctement configuré

class ProfileService {
  final Map<String, String> defaultHeaders;
  final AuthentificationService authentificationService=AuthentificationService();

  ProfileService({
    this.defaultHeaders = const {},

  });

  /// Récupère le statut de dématérialisation
  Future<bool> getDematerialisationStatus() async {
    final url = Uri.parse('${Config.URL_API_PROFIL}/api/v1/profil/courrier');
    final token = await authentificationService.getToken();
    final id=await authentificationService.getIdProfil();

    final headers = {
      ...defaultHeaders,
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'idProfil':'${id}'
    };

    try {
      print ('\n\nid : $id');
      print('token : $token \n\n');
      // Effectuer la requête HTTP GET
      final response = await http.get(
        url,
        headers: headers,
      );

      // Vérifier le statut de la réponse
      if (response.statusCode == 200) {
        // Analyser la réponse JSON en tant que booléen
        return json.decode(response.body) as bool;
      } else if (response.statusCode == 401) {
        throw Exception('Authentification échouée : Veuillez vérifier vos identifiants.');
      } else {
        throw Exception(
          'Erreur lors de la récupération du statut de dématérialisation : ${response.statusCode} ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Erreur réseau : $e');
    }
  }

  /// Met à jour le statut de dématérialisation
  Future<bool> changeDematerialisationStatus(bool isPaperDocument ) async {
    // Construction de l'url 
    final url = Uri.parse('${Config.URL_API_PROFIL}/api/v1/profil/courrier/$isPaperDocument');

    //Récupération de token et de l'id du profil 
    final token = await authentificationService.getToken();
    final id=await authentificationService.getIdProfil();

    // en-tetes 
    final headers = {
      ...defaultHeaders,
      'Authorization': 'Bearer $token',
      'idProfil':'${id}'
    };

    try {
      print('En-têtes : $headers');

      // Eequête HTTP post

      final response = await http.post(
      url,
       headers: headers,
    );

      // Vérification du statut de la réponse
      if (response.statusCode == 200) {
        // print ('\n\nPréferences sauvegardées : Version Papier : ${await getDematerialisationStatus()}\n\n');
        return response.body.toLowerCase() == 'true';
      } else if (response.statusCode == 401) {
        throw Exception('Mise à jour de la dématérialisation: Veuillez rééssayer ');
      } else {
        throw Exception(
          'Erreur lors de la récupération du statut de dématérialisation : ${response.statusCode} ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Erreur réseau : $e');
    }
  }


Future<String> modifierMDP(ChangerMdpDTO? changerMdpDTO, {bool reportProgress = false}) async {
   //Récupération de token et de l'id du profil 
    final token = await authentificationService.getToken();
    final id=await authentificationService.getIdProfil();
    
    if (changerMdpDTO == null) {
      throw ArgumentError('changerMdpDTO ne peut pas être null');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'idProfil':'${id}'


    };

    final body = json.encode(changerMdpDTO.toJson());

    try {
      final response = await http.post(
        Uri.parse('${Config.URL_API_PROFIL}/api/v1/profil/password'),
        headers: headers,

        body: body,
      );

      if (response.statusCode == 200) {
        // Traite la réponse si nécessaire
        return response.body;
      } else if (response.statusCode==400){
        throw BadCurrentPwdException();
      }else{
        throw Exception('Erreur lors de la modification du mot de passe: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

}
