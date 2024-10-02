import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config_dev.dart';  
import '../dashboard/dashboard_page.dart';
import '../models/connexionDTO.dart';
import '../models/offerDTO.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // me servira plus tard pour les tokens
import '../screens/ErrorScreen.dart';

class LoginService {

  late Uri url;
  final storage = FlutterSecureStorage();

  Future<OfferDTO?> getOffer(String mail) async {
    if (mail.isEmpty) {
      throw ArgumentError('Le paramètre mail est requis.');
    }

    // Paramètres de la requête
    final queryParameters = {'mail': mail};

    // Headers (inclure le header 'application')
    final headers = {
      'Accept': 'application/json',
      'application': 'gloc-locataire', 
    };

    // URL avec paramètres
    final uri = Uri.parse('${Config.URL_API_PROFIL}/api-free/v1/user/offer').replace(queryParameters: queryParameters);

    try {
      // Effectuer la requête GET
      final response = await http.get(uri, headers: headers);

      // Affiche le statut de la réponse pour diagnostic
      print('Status Code: ${response.statusCode}');

      
      print('Response body: ${response.body}');

      // Vérifier si la réponse est valide (statut 200 OK)
      if (response.statusCode == 200) {
        // Convertir la réponse en objet OfferDTO
        final jsonResponse = json.decode(response.body);

        // Affiche la réponse JSON pour vérifier sa structure
        print('JSON response: $jsonResponse');

        return OfferDTO.fromJson(jsonResponse);
      } else {
        // Gérer les erreurs HTTP
        print('Erreur de requête: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Erreur lors de la requête: $error');
      return null;
  }
  }



  Future<ConnexionDTO?> connexionV2() async {
    // Headers
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    // URL de la requête
    final url = Uri.parse('${Config.URL_API_PROFIL}/api/v1/profil/connexionV2');

    try {
      // Effectuer la requête POST
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(null), // Envoie null comme corps, ou remplace par les données nécessaires
      );

      // Vérifier si la réponse est valide (statut 200 OK)
      if (response.statusCode == 200) {
        // Convertir la réponse en objet ConnexionDTO
        final jsonResponse = json.decode(response.body);
        return ConnexionDTO.fromJson(jsonResponse);
      } else {
        // Gérer les erreurs HTTP
        print('Erreur de requête: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Erreur lors de la requête: $error');
      return null;
    }
  }


  
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
      final accessToken = data['access_token'];
      final refreshToken = data['refresh_token'];

      // Stocker les tokens de manière sécurisée
      await storage.write(key: 'access_token', value: accessToken);
      await storage.write(key: 'refresh_token', value: refreshToken);

      print('Access Token: $accessToken');
    } else {
      throw Exception('Échec de l\'authentification');
    }
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }


  Future<void> revokeToken() async {
  final accessToken = await storage.read(key: 'access_token');
  
  if (accessToken != null) {
    final url = Uri.parse(Config.URL_REVOKE_TOKEN);
    
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      print('Token révoqué avec succès');
      // Supprimer les tokens stockés
      await storage.deleteAll();
    } else {
      throw Exception('Échec de la révocation du token');
    }
  }
}
Future<void> logout() async {
    try {
      // Récupérer le access token et le refresh token depuis le storage sécurisé
      String? accessToken = await storage.read(key: 'access_token');
      String? refreshToken = await storage.read(key: 'refresh_token');

      if (accessToken == null || refreshToken == null) {
        throw Exception('No tokens available to revoke.');
      }

      // Préparer les headers pour la requête de révocation
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $accessToken',
      };

      // Préparer le body pour révoquer le refresh token
      final body = {
        'token': refreshToken,
        'token_type_hint': 'refresh_token',
      };

      // Envoyer la requête de révocation du refresh token au serveur
      final response = await http.post(
        Uri.parse(Config.URL_REVOKE_TOKEN),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Suppression des tokens du stockage sécurisé
        await storage.delete(key: 'access_token');
        await storage.delete(key: 'refresh_token');

        print('Logout successful. Tokens revoked and deleted.');
      } else {
        throw Exception('Failed to revoke tokens: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during logout: $error');
    }
  }

  // Similaire à `this.goTo()`
  void goToErrorOffer(BuildContext context, String message) {
    // Naviguer vers une page d'erreur avec un message personnalisé
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ErrorScreen(message: message),
      ),
    );
  }

  Future<void> loginV3(BuildContext context, String email, String password) async {
  try {
    // Nettoyage de l'email
    String mailClient = email.trim().toLowerCase();
    print("Email nettoyé: $mailClient");
    
    // Récupération de l'offre basée sur l'email
    OfferDTO? offerDto = await getOffer(mailClient);
    print("OfferDTO récupéré: $offerDto");

    if (offerDto == null) {
      throw Exception("OfferDTO est null");
    }

     print('OfferDTO: site=${offerDto.site}, redirectUrl=${offerDto.redirectUrl}');

    String msg = '';
    SiteEnum? siteEnum = offerDto.site;

    // Gestion des différentes offres
    switch (siteEnum) {
      case SiteEnum.GlocLocataire:
      case SiteEnum.GlocLocataireMobile:
      case SiteEnum.GlocCollaborateur:
        // Appel à la méthode login avec email et password
        print("Appel de la méthode login pour $email");
        await login(email, password);
        // Redirection vers le dashboard si l'authentification est réussie
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
        break;

      case SiteEnum.TwentyCampus:
      case SiteEnum.TwentyCampusMobile:
      case SiteEnum.TwentyCampusWeb:
        // Gestion des offres TwentyCampus
        msg = "Error offer for TwentyCampus. Redirect to ${offerDto.redirectUrl}";
        print(msg);
        goToErrorOffer(context, msg);
        break;

      case SiteEnum.GlocBailleur:
      case SiteEnum.GlocBailleurMobile:
        // Gestion des offres GlocBailleur
        msg = "Error offer for GlocBailleur. Redirect to ${offerDto.redirectUrl}";
        print(msg);
        goToErrorOffer(context, msg);
        break;

      default:
        // Gestion des comptes inexistants
        msg = "Compte inexistant.";
        print(msg);
        goToErrorOffer(context, msg);
    }
  } catch (error) {
    // Gestion des erreurs
    print("Erreur lors de loginV3: $error");
    if (error.toString()==''){

    }
    // Affiche un message d'erreur général
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Erreur de connexion: ${error.toString()}")),
    );
  }
}



}
