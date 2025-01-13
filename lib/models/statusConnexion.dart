class StatusConnexion {
  final String? errorMessage;
  final HttpStatusEnum? httpStatus;
  final String? offer;
  final RedirectToAppMobileEnum? redirectToAppMobile;
  final String? redirectUrl;

  StatusConnexion({
    this.errorMessage,
    this.httpStatus,
    this.offer,
    this.redirectToAppMobile,
    this.redirectUrl,
  });

  // Factory pour créer une instance de StatusConnexion à partir d'un JSON
  factory StatusConnexion.fromJson(Map<String, dynamic> json) {
  return StatusConnexion(
    errorMessage: json['errorMessage'] ?? '',
    httpStatus: json['httpStatus'] != null
        ? HttpStatusEnumExtension.fromValue(json['httpStatus'])
        : null,
    offer: json['offer'] ?? '',
    redirectToAppMobile: json['redirectToAppMobile'] != null
        ? RedirectToAppMobileEnumExtension.fromValue(json['redirectToAppMobile'])
        : null,
    redirectUrl: json['redirectUrl'] ?? '',
  );
}

  // Méthode pour convertir l'objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'errorMessage': errorMessage,
      'httpStatus': httpStatus?.toValue(),
      'offer': offer,
      'redirectToAppMobile': redirectToAppMobile?.toValue(),
      'redirectUrl': redirectUrl,
    };
  }

  @override
  String toString() {
    return '''
      StatusConnexion(
      errorMessage: $errorMessage,
      httpStatus: $httpStatus,
      offer: $offer,
      redirectToAppMobile: $redirectToAppMobile,
      redirectUrl: $redirectUrl
    )''';
  }
}

enum HttpStatusEnum {
  continue100,
  switchingProtocols101,
  processing102,
  checkpoint103,
  ok200,
  created201,
  accepted202,
  nonAuthoritativeInformation203,
  noContent204,
  resetContent205,
  partialContent206,
  multiStatus207,
  alreadyReported208,
  imUsed226,
  multipleChoices300,
  movedPermanently301,
  found302,
  movedTemporarily302,
  seeOther303,
  notModified304,
  useProxy305,
  temporaryRedirect307,
  permanentRedirect308,
  badRequest400,
  unauthorized401,
  paymentRequired402,
  forbidden403,
  notFound404,
  methodNotAllowed405,
  notAcceptable406,
  proxyAuthenticationRequired407,
  requestTimeout408,
  conflict409,
  gone410,
  lengthRequired411,
  preconditionFailed412,
  payloadTooLarge413,
  requestUriTooLong414,
  unsupportedMediaType415,
  requestedRangeNotSatisfiable416,
  expectationFailed417,
  iAmATeapot418,
  insufficientSpaceOnResource419,
  methodFailure420,
  destinationLocked421,
  unprocessableEntity422,
  locked423,
  failedDependency424,
  upgradeRequired426,
  preconditionRequired428,
  tooManyRequests429,
  requestHeaderFieldsTooLarge431,
  unavailableForLegalReasons451,
  internalServerError500,
  notImplemented501,
  badGateway502,
  serviceUnavailable503,
  gatewayTimeout504,
  httpVersionNotSupported505,
  variantAlsoNegotiates506,
  insufficientStorage507,
  loopDetected508,
  bandwidthLimitExceeded509,
  notExtended510,
  networkAuthenticationRequired511
}

// Extension pour faciliter la conversion entre enum et string
extension HttpStatusEnumExtension on HttpStatusEnum {
  static HttpStatusEnum? fromValue(String value) {
    return HttpStatusEnum.values.firstWhere(
        (element) => element.toValue() == value,
        orElse: () => HttpStatusEnum.internalServerError500);
  }

  String toValue() {
    return this.toString().split('.').last.replaceAll('_', ' ');
  }
}

enum RedirectToAppMobileEnum {
  glocLocataire,
  glocLocataireMobile,
  glocBailleur,
  glocBailleurMobile,
  glocCollaborateur,
  twentyCampusMobile,
  twentyCampusWeb,
  twentyCampus,
}

// Extension pour faciliter la conversion entre enum et string
extension RedirectToAppMobileEnumExtension on RedirectToAppMobileEnum {
  static RedirectToAppMobileEnum? fromValue(String value) {
    return RedirectToAppMobileEnum.values.firstWhere(
        (element) => element.toValue() == value,
        orElse: () => RedirectToAppMobileEnum.twentyCampus);
  }

  String toValue() {
    return this.toString().split('.').last.replaceAll('_', '-');
  }
}
