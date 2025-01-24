class BadCurrentPwdException implements Exception {
  final String message = "Mot de passe actuel incorrect";

  @override
  String toString() {
    return "BadCurrentPwdException: $message";
  }
}