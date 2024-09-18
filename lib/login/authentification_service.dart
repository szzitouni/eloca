import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config_dev.dart';  // Assure-toi que ce fichier est correctement importé

class AuthentificationService {
  
  // Méthode pour obtenir un token
  Future<void> login(String email, String password) async {
    final url = Uri.parse(Config.URL_TOKEN);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ${Config.PROJECT_ACCESS_TOKEN}',
      },
      body: {
        'grant_type': 'password',
        'username': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Traitement de la réponse
      final data = jsonDecode(response.body);
      print('Access Token: ${data['access_token']}');
      // Sauvegarde du token ou autre traitement
    } else {
      throw Exception('Échec de l\'authentification');
    }
  }

  // Méthode pour révoquer un token
  Future<void> revokeToken(String token) async {
    final url = Uri.parse(Config.URL_REVOKE_TOKEN);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Token révoqué avec succès');
    } else {
      throw Exception('Échec de la révocation du token');
    }
  }
}
