import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mon_app/secure_storage_service.dart';
import '../config/config_dev.dart'; // Remplace par la configuration appropriée
import '../models/gestionnaire.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReportsService {
  final http.Client httpClient;
  final _secureStorageService = SecureStorageService(); 

  ReportsService({required this.httpClient});

  // Méthode pour récupérer un gestionnaire à partir d'un idProfil
  Future<Gestionnaire?> getGestionnaire(int idProfil) async {
    if (idProfil <= 0) {
      throw ArgumentError('L\'idProfil doit être valide et supérieur à 0.');
    }

    // Paramètres pour la requête
    final queryParameters = {'fonction': 'GECOM'};

    // URL de l'API
    final uri = Uri.parse('${Config.URL_API_PROFIL}/api/v1/profil/gestionnaire/$idProfil')
        .replace(queryParameters: queryParameters);

    try {
      final response = await httpClient.get(uri, headers: {
        'Accept': 'application/json',
      });

      // Affiche les détails pour le diagnostic
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Convertir le JSON en objet Gestionnaire
        final List<dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.isNotEmpty) {
          return Gestionnaire.fromJson(jsonResponse[0]);
        } else {
          print('Aucun gestionnaire trouvé.');
          return null;
        }
      } else {
        throw Exception('Erreur lors de la récupération du gestionnaire: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur dans getGestionnaire: $e');
      return null;
    }
  }

  // Exemples de méthodes supplémentaires pour 
  Future<void> saveGestionnaireToStorage(Gestionnaire gestionnaire) async {
    await _secureStorageService.write( 'gestionnaire', json.encode(gestionnaire.toJson()));
  }

  Future<Gestionnaire?> loadGestionnaireFromStorage() async {
    final jsonString = await _secureStorageService.read('gestionnaire');
    if (jsonString != null) {
      return Gestionnaire.fromJson(json.decode(jsonString));
    }
    return null;
  }
}
