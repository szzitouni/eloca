import 'package:dio/dio.dart';
import 'package:mon_app/login/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthentificationService authService;
  final Dio dioInstance;  // Ajout d'une instance de Dio
  bool isRefreshing = false;
  String? pendingToken;

  AuthInterceptor({required this.authService, required this.dioInstance});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await authService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Gestion du token expiré
      if (!isRefreshing) {
        isRefreshing = true;
        try {
          final newToken = await authService.refreshToken();
          if (newToken != null) {
            pendingToken = newToken;
            // Réessayer la requête avec le nouveau token
            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $newToken';
            final response = await dioInstance.fetch(options);  // Utilisation de l'instance Dio
            handler.resolve(response);
          } else {
            // Si le rafraîchissement échoue, déconnexion
            await authService.logout();
            handler.reject(err);
          }
        } catch (e) {
          // En cas d'erreur, déconnexion
          await authService.logout();
          handler.reject(err);
        } finally {
          isRefreshing = false;
        }
      } else {
        // Attendre le token actualisé
        while (pendingToken == null && isRefreshing) {
          await Future.delayed(Duration(milliseconds: 100));
        }
        if (pendingToken != null) {
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $pendingToken';
          final response = await dioInstance.fetch(options);  // Utilisation de l'instance Dio
          handler.resolve(response);
        } else {
          handler.reject(err);
        }
      }
    } else {
      super.onError(err, handler);
    }
  }
}
