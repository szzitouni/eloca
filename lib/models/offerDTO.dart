class OfferDTO {
  final String? redirectUrl;
  final SiteEnum? site;

  OfferDTO({this.redirectUrl, this.site});

  factory OfferDTO.fromJson(Map<String, dynamic> json) {
    return OfferDTO(
      redirectUrl: json['redirectUrl'],
      site: SiteEnumExtension.fromString(json['site']),
    );
  }

  Map<String, dynamic> toJson() => {
        'redirectUrl': redirectUrl,
        'site': site?.toShortString(),
      };
}

enum SiteEnum {
  GlocLocataire,
  GlocLocataireMobile,
  GlocBailleur,
  GlocBailleurMobile,
  GlocCollaborateur,
  TwentyCampusMobile,
  TwentyCampusWeb,
  TwentyCampus,
}

extension SiteEnumExtension on SiteEnum {
  String toShortString() {
    return this.toString().split('.').last; // Renvoie le nom de l'enum en tant que chaîne
  }

  static SiteEnum? fromString(String? site) {
    switch (site) {
      case 'gloc-locataire':
      case 'GLOC_LOCATAIRE': // COMEBACK
        return SiteEnum.GlocLocataire;
      case 'gloc-locataire-mobile':
        return SiteEnum.GlocLocataireMobile;
      case 'gloc-bailleur':
        return SiteEnum.GlocBailleur;
      case 'gloc-bailleur-mobile':
        return SiteEnum.GlocBailleurMobile;
      case 'gloc-collaborateur':
        return SiteEnum.GlocCollaborateur;
      case 'twenty-campus-mobile':
        return SiteEnum.TwentyCampusMobile;
      case 'twenty-campus-web':
        return SiteEnum.TwentyCampusWeb;
      case 'twenty-campus':
        return SiteEnum.TwentyCampus;
      default:
        return null;
    }
  }
}
