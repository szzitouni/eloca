import 'dart:convert';
import 'package:dio/dio.dart';  // Utilisez Dio de manière centralisée via DioService
import 'package:mon_app/login/auth_service.dart';
import 'package:mon_app/models/userContext.dart';
import '../config/config_dev.dart';
import '../models/gestionnaire.dart';
import '../dio_service.dart';  // Importez DioService

class DashboardService {
  final Dio dioClient;
  

  final authentificationService = AuthentificationService();

  // Utilisation de l'instance partagée de Dio
  DashboardService() : dioClient = DioService.instance;

  // Méthode pour récupérer un gestionnaire à partir d'un idProfil
Future<Gestionnaire?> getGestionnaire(int idProfil) async {
  // print('idProfil  depuis getGestionnaire  ${idProfil}'); CHECK Bon Id
  if (idProfil <= 0) {
    throw ArgumentError('L\'idProfil doit être valide et supérieur à 0.');
  }

  // Vérifier si le token est valide avant d'effectuer la requête
  String? token = await authentificationService.getToken();
  if (token == null || token.isEmpty) {
    throw Exception("Token d'authentification manquant, veuillez vous reconnecter.");
  }

  // Paramètres pour la requête
  final queryParameters = {'fonction': 'GECOM'};

  // URL de l'API
  final uri = Uri.parse('${Config.URL_API_PROFIL}/api/v1/profil/gestionnaire/$idProfil')
      .replace(queryParameters: queryParameters);

  try {
    // Effectuer la requête GET avec l'en-tête Authorization en utilisant Dio
    final response = await dioClient.get(
      uri.toString(),
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',  // Ajouter ici votre token dans l'en-tête
        },
        validateStatus: (status) {
          // Accepter tous les statuts (y compris 401) pour pouvoir gérer l'erreur nous-mêmes
          return status! < 500;  // Permet de ne pas lancer d'exception pour les erreurs 4xx
        },
      ),
    );

   
  
    if (response.statusCode == 200) {
      // Convertir le JSON en objet Gestionnaire
      final List<dynamic> jsonResponse = response.data;
      if (jsonResponse.isNotEmpty) {
        return Gestionnaire.fromJson(jsonResponse[0]);
      } else {
        print('Aucun gestionnaire trouvé.');
        return null;
      }
    } else if (response.statusCode == 401) {
      // Gérer manuellement l'erreur 401 (Token expiré)
      print('Token expiré, tentative de rafraîchissement...');
      try {
        // Essayer de rafraîchir le token
        String? newToken = await authentificationService.refreshToken();
        if (newToken != null) {
          // Réessayer la requête avec le nouveau token
          final retryResponse = await dioClient.get(
            uri.toString(),
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $newToken',
              },
            ),
          );
          if (retryResponse.statusCode == 200) {
            final List<dynamic> retryJsonResponse = retryResponse.data;
            if (retryJsonResponse.isNotEmpty) {
              return Gestionnaire.fromJson(retryJsonResponse[0]);
            } else {
              print('Aucun gestionnaire trouvé après rafraîchissement du token.');
              return null;
            }
          } else {
            throw Exception('Erreur lors de la récupération du gestionnaire après rafraîchissement du token: ${retryResponse.statusCode}');
          }
        } else {
          throw Exception('Échec du rafraîchissement du token. Veuillez vous reconnecter.');
        }
      } catch (e) {
        // Si le rafraîchissement échoue, l'utilisateur doit se reconnecter
        throw Exception('Token expiré et échec du rafraîchissement: $e');
      }
    } else {
      throw Exception('Erreur lors de la récupération du gestionnaire: ${response.statusCode}');
    }
  } catch (e) {
    print('Erreur dans getGestionnaire: $e');
    // Gérer l'erreur en la renvoyant plus précisément
    if (e is DioException) {
      return Future.error('Erreur lors de la connexion: ${e.message}');
    }
    return Future.error('Erreur inconnue: $e');
  }
}




  Future<UserContext?> getUserContext() {
    return authentificationService.userContext;
  }
}
