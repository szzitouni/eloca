import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mon_app/login/auth_service.dart';
import 'package:mon_app/secure_storage_service.dart';
import '../config/config_dev.dart';  
import '../models/connexionDTO.dart';
import '../models/offerDTO.dart';
import 'package:flutter/material.dart';
import '../screens/ErrorScreen.dart';

class LoginService {

  late Uri url;
   final SecureStorageService _secureStorageService = SecureStorageService();
  final AuthentificationService authentificationService =AuthentificationService();
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
     url = Uri.parse('${Config.URL_API_PROFIL}/api-free/v1/user/offer').replace(queryParameters: queryParameters);
     // print("URL appelée : $url"); CHECK Bonne url

    try {
      // Effectuer la requête GET
      final response = await http.get(url, headers: headers);

      // Affiche le statut de la réponse pour diagnostic
      // print('Status Code: ${response.statusCode}');

      
      //print('Response body: ${response.body}');

      // Vérifier si la réponse est valide (statut 200 OK)
      if (response.statusCode == 200) {
        // Convertir la réponse en objet OfferDTO
        final jsonResponse = json.decode(response.body);

        // Affiche la réponse JSON pour vérifier sa structure
        // print('JSON response: $jsonResponse'); CHECK Bonne json response

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
  



   

  
  

  Future<String?> getAccessToken() async {
    return await _secureStorageService.read( 'access_token');
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

  //Méthode de connexion VVV
    Future<ConnexionDTO?> login(BuildContext context, String email, String password) async {
    try {
      String mailClient = email.trim().toLowerCase();

      // Récupération de l'offre de manière asynchrone
      OfferDTO? offerDto = await getOffer(mailClient); // Utilisation de await ici
      // print("OfferDTO récupéré: $offerDto");
      // print("Site récupéré: ${offerDto?.site}");

      if (offerDto == null) {
        throw Exception("OfferDTO est null");
      }

      String msg = '';
      SiteEnum? siteEnum = offerDto.site;

      // Gestion des différentes offres
      switch (siteEnum) {
        case SiteEnum.GlocLocataire:
        case SiteEnum.GlocLocataireMobile:
        case SiteEnum.GlocCollaborateur:
          print("Appel de la méthode login pour $email");

          // Appel au service d'authentification
          ConnexionDTO? connexionDTO = await authentificationService.login(email, password); // Utilisation de await ici

          if (connexionDTO == null) {
            throw Exception("Erreur lors de la récupération de ConnexionDTO");
          }
    
          return connexionDTO;

        case SiteEnum.TwentyCampus:
        case SiteEnum.TwentyCampusMobile:
        case SiteEnum.TwentyCampusWeb:
          msg = "Error offer for TwentyCampus. Redirect to ${offerDto.redirectUrl}";
          print(msg);
          goToErrorOffer(context, msg);
          break;

        case SiteEnum.GlocBailleur:
        case SiteEnum.GlocBailleurMobile:
          msg = "Error offer for GlocBailleur. Redirect to ${offerDto.redirectUrl}";
          print(msg);
          goToErrorOffer(context, msg);
          break;

        default:
          msg = "Compte inexistant.";
          print(msg);
          goToErrorOffer(context, msg);
      }
    } catch (error) {
      print("Erreur lors de login: $error");
      ScaffoldMessenger.of(context).showSnackBar( // comeback
        SnackBar(content: Text("Erreur de connexion: ${error.toString()}")),
      );
    }
    return null;
  }


}
