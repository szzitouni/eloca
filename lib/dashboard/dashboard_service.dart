import 'dart:convert'; // Pour convertir les données JSON
import 'package:http/http.dart' as http;
import '../config/config_dev.dart';
import '../models/gestionnaire.dart'; // Assure-toi que la classe Gestionnaire est importée

class DashboardService {
  // Méthode pour récupérer un gestionnaire à partir de l'idProfil
  Future<List<Gestionnaire>> getGestionnaires(int idProfil, {List<String>? codeFonction}) async {
    try {
      String url = '${Config.URL_API_PROFIL}/gestionnaire/$idProfil';

      // Ajouter les paramètres optionnels si codeFonction est fourni
      if (codeFonction != null && codeFonction.isNotEmpty) {
        String queryString = codeFonction.map((f) => 'fonction=$f').join('&');
        url += '?$queryString';
      }

      // requête GET
      final response = await http.get(Uri.parse(url));

      
      if (response.statusCode == 200) {
        // Décodage de  la réponse JSON
        List<dynamic> jsonList = jsonDecode(response.body);

        // Conversion de chaque élément du JSON en Gestionnaire
        List<Gestionnaire> gestionnaires = jsonList
            .map((jsonItem) => Gestionnaire.fromJson(jsonItem))
            .toList();

        return gestionnaires;
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération des gestionnaires: $e');
    }
  }
}
