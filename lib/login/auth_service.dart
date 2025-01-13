import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mon_app/config/config_dev.dart';
import 'package:mon_app/dashboard/dashboard_service.dart';
import 'package:mon_app/models/connexionDTO.dart';
import 'package:mon_app/models/userContext.dart';

class AuthentificationService {
  // Clés
  static const String ACCESS_TOKEN_KEY = 'access_token';
  static const String REFRESH_TOKEN_KEY = 'refresh_token';
  static const String USER_CONTEXT_KEY = 'userContext';

  final storage = FlutterSecureStorage();
  late bool isCollab;
   UserContext? _userContext; /// remettre à late ? COMEBACK

  // Getter pour userContext
  Future<UserContext?> get userContext async {
    if (_userContext == null) {
      final jsonString = await storage.read(key:USER_CONTEXT_KEY);
     
      // print('JSON b4 : \n\n\n $jsonString \n\n '); CHECK BoN Json
      
      if (jsonString != null) {
        _userContext = UserContext.fromJson(json.decode(jsonString));
       
        // print('UserContext  : \n\n\n ${_userContext.toString()} \n\n '); Check Bon UC

      }
    }

    return _userContext;
  }

  // Setter pour userContext
  Future<void> setUserContext(UserContext userContext, {bool withoutLocalSave = false}) async {
  _userContext = userContext;
  if (!withoutLocalSave) {
    final jsonString = json.encode(userContext.toJson());
    await storage.write(key: USER_CONTEXT_KEY, value: jsonString);

    // Validation après écriture
    final savedJson = await storage.read(key: USER_CONTEXT_KEY);
     // print('Vérification du UserContext enregistré : $savedJson'); CHECK Bon UC
  }
}

  // Obtenir idProfil
 Future<int> getIdProfil() async {
  final context = await userContext;
  if (context == null) {
    print('UserContext est null.');
    return 0;
  }

  // print('UserContext récupéré : ${context.toJson()}'); CHECK Bon UC
  final idProfil = context.currentContext?.idProfil ?? 0;

  if (idProfil == 0) {
    print('idProfil est invalide ou absent.');
  }
  return idProfil;
}

  // Login
  Future<ConnexionDTO?> login(String email, String password) async {
  try {
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
      final data = jsonDecode(response.body);
      final accessToken = data[ACCESS_TOKEN_KEY];
      final refreshToken = data[REFRESH_TOKEN_KEY];

      await saveToken(accessToken);
      await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);

      return await connexionV2();
    } else {
      throw Exception('Échec de l\'authentification : ${response.body}');
    }
  } catch (e) {
    print('Erreur dans login : $e');
    rethrow; // Important pour gérer l'erreur dans la couche d'appel
  }
}


  Future<void> logout() async {
    isCollab=false;
    try {
      // Révoquer le token côté serveur
      clearUserContext();

      // Effectuer une redirection ou un nettoyage spécifique à l'application
    } catch (error) {
      print("Erreur lors de la déconnexion : $error");
    }
  }

  // Vérification de la connexion
  Future<bool> isLoggedIn() async {
    String? token = await storage.read(key: ACCESS_TOKEN_KEY);
    return token != null && token.isNotEmpty;
  }

  // Connexion V2
  Future<ConnexionDTO?> connexionV2() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Non authentifié : Token absent.');
    }

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'application': 'gloc-locataire',
    };

    final url = Uri.parse('${Config.URL_API_PROFIL}/api/v1/profil/connexionV2');

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(null),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return ConnexionDTO.fromJson(jsonResponse);
      } else {
        print('Erreur de requête: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Erreur lors de la requête: $error');
      return null;
    }
  }

  // Révoquer le token
  Future<void> revokeToken() async {
    try {
      String? accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
      if (accessToken == null) {
        throw Exception('Aucun token d\'accès trouvé. Veuillez vous reconnecter.');
      }

      final url = Uri.parse(Config.URL_REVOKE_TOKEN);

      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $accessToken',
      };

      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        print("Le token a été révoqué côté serveur avec succès.");
        await deleteToken();
      } else {
        throw Exception('Erreur lors de la révocation du token.');
      }
    } catch (error) {
      print('Erreur lors de la révocation du token : $error');
      throw Exception('Erreur lors de la révocation du token');
    }
  }

  // Méthode pour obtenir le token
  Future<String?> getToken() async {
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      if (token == null || token.isEmpty) {
        throw Exception("Aucun token trouvé. Veuillez vous reconnecter.");
      }
      return token;
    } catch (error) {
      print('Erreur lors de la récupération du token : $error');
      return null;
    }
  }

  // Effacer le contexte utilisateur
  Future<void> clearUserContext() async {
    try {
      await revokeToken();
      //_userContext = null;
    } catch (e) {
      print('Erreur lors de la suppression du contexte utilisateur : $e');
    }
  }

  // Rafraîchir le token
  Future<String?> refreshToken() async {
    try {
      final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

      if (refreshToken == null) {
        throw Exception("Aucun token de rafraîchissement disponible.");
      }

      final response = await http.post(
        Uri.parse(Config.URL_TOKEN),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ${Config.PROJECT_ACCESS_TOKEN}',
        },
        body: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final newAccessToken = responseBody['access_token'];
        final newRefreshToken = responseBody['refresh_token'];

        if (newAccessToken != null) {
          // Sauvegarder les nouveaux tokens
          await saveToken(newAccessToken);
          if (newRefreshToken != null) {
            await saveRefreshToken(newRefreshToken);
          }
          return newAccessToken;
        } else {
          throw Exception("Réponse invalide : pas de nouveau token d'accès.");
        }
      } else {
        throw Exception("Échec du rafraîchissement du token : ${response.statusCode}");
      }
    } catch (error) {
      print("Erreur lors du rafraîchissement du token : $error");
      return null;
    }
  }

  // Sauvegarder le token d'accès
  Future<void> saveToken(String token) async {
    try {
      await storage.write(key: ACCESS_TOKEN_KEY, value: token);
    } catch (error) {
      print('Erreur lors de la sauvegarde du token : $error');
      throw Exception("Impossible de sauvegarder le token.");
    }
  }

  // Sauvegarder le refresh token
  Future<void> saveRefreshToken(String token) async {
    try {
      await storage.write(key: REFRESH_TOKEN_KEY, value: token);
    } catch (error) {
      print('Erreur lors de la sauvegarde du token : $error');
      throw Exception("Impossible de sauvegarder le token.");
    }
  }

  // Supprimer les tokens
  Future<void> deleteToken() async {
    try {
      await storage.delete(key: ACCESS_TOKEN_KEY);
      await storage.delete(key: REFRESH_TOKEN_KEY);
      print("Les tokens ont été supprimés localement.");
    } catch (error) {
      print('Erreur lors de la suppression du token : $error');
      throw Exception("Impossible de supprimer le token.");
    }
  }

  // Autoriser avec le refresh token si nécessaire
  Future<String?> authorizeWithRefreshToken() async {
    String? token = await getToken();
    if (token != null && token.isNotEmpty) {
      return token;
    }

    // Si le token d'accès est expiré, tenter de le rafraîchir
    String? newToken = await refreshToken();
    if (newToken == null) {
      throw Exception("Impossible d'obtenir un token valide.");
    }
    return newToken;
  }
}
