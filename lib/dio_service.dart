import 'package:dio/dio.dart';
import 'login/auth_service.dart';  // Importez votre service d'authentification
import 'interceptor.dart'; // Importez votre Interceptor personnalisé

class DioService {
  // Instance de Dio partagée
  static final Dio _dio = Dio();

  // Méthode pour accéder à l'instance globale de Dio
  static Dio get instance {
    // Si c'est la première fois qu'on y accède, on ajoute l'intercepteur
    if (_dio.interceptors.isEmpty) {
      // Crée une instance du service d'authentification
      final authService = AuthentificationService();
      
      // Ajoute l'intercepteur d'authentification
      _dio.interceptors.add(AuthInterceptor(authService: authService, dioInstance: _dio));
    }
    return _dio;
  }

  // Constructeur privé pour empêcher la création d'autres instances
  DioService._();
}
