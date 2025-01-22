import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'models/userContext.dart';
import 'config/config_dev.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  SecureStorageService._internal(); // constructeur privé 


  /// Enregistrer une donnée s
Future<void> write(String key, String value) async {
  try {
    print('Tentative d’écriture pour la clé : $key avec la valeur : $value');
    await _secureStorage.write(key: key, value: value);
    print('Écriture réussie pour la clé : $key');
  } catch (e) {
    print('Erreur lors de l’écriture pour la clé : $key : $e');
  }
}

  /// Lire une donnée
Future<String?> read(String key) async {
  try {
    print('Tentative de lecture pour la clé : $key');
    final value = await _secureStorage.read(key: key);
    //print('Lecture réussie pour la clé : $key, valeur : $value');
    print ('Lecture réussie');
    return value;
  } catch (e) {
    print('Erreur lors de la lecture pour la clé : $key : $e');
    return null;
  }
}

/// Supprimer une donnée 
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }
  

  /// Enregistrer le UserContext
    Future<void> setUserContext(UserContext userContext) async {
    try {
      //print('\n Tentative d’enregistrement du UserContext : $userContext');
      final jsonString = json.encode(userContext.toJson());
      //print('\n UserContext JSON prêt pour stockage : $jsonString');
      
      await write(Config.USER_CONTEXT_KEY, jsonString);
      //print('\n UserContext écrit dans le stockage avec la clé : ${Config.USER_CONTEXT_KEY}');
      
      // Vérification des données écrites
      // final writtenData = await read(Config.USER_CONTEXT_KEY);
      // print('\nVérification : données écrites dans le stockage : $writtenData');
    } catch (e) {
      print('Erreur lors de l’écriture ou de la vérification dans le stockage sécurisé : $e');
    }
  }




  Future<UserContext?> getUserContext() async {
  try {
    // Lecture des données depuis le stockage
    print('Clé utilisée pour le stockage : ${Config.USER_CONTEXT_KEY}');
    final jsonString = await read(Config.USER_CONTEXT_KEY);
    print('Données brutes récupérées du stockage : $jsonString');

    // Vérification si les données sont nulles
    if (jsonString == null) {
      print('Aucun UserContext trouvé dans le stockage.');
      return null;
    }

    // Désérialisation des données JSON
    final userContext = UserContext.fromJson(json.decode(jsonString));
    //print('UserContext désérialisé avec succès : $userContext');
    print ('UserContext Désérialisé avec succes');
    return userContext;

  } catch (e) {
    // Gestion des erreurs de désérialisation ou autre
    print('Erreur lors de la récupération de UserContext : $e');
    return null;
  }
}



  /// Enregistrer le token d'authentification
  Future<void> setAuthToken(String token) async {
    await write('authToken', token);
  }

  /// Récupérer le token d'authentification
  Future<String?> getAuthToken() async {
    return await read('authToken');
  }

  /// Supprimer le token d'authentification
  Future<void> clearAuthToken() async {
    await delete('authToken');
  }
}
