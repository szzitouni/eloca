import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mon_app/config/config_dev.dart';
import 'package:mon_app/login/auth_service.dart'; // Assurez-vous que Config est correctement configuré

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
}
