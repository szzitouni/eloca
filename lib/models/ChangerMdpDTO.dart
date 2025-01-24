class ChangerMdpDTO {
  String? ancienMotDePasse;
  String? confirmPassword;
  String? motDePasse;

  // Constructeur
  ChangerMdpDTO({
    this.ancienMotDePasse,
    this.confirmPassword,
    this.motDePasse,
  });

  // Méthode pour convertir un objet JSON en instance de ChangerMdpDTO
  factory ChangerMdpDTO.fromJson(Map<String, dynamic> json) {
    return ChangerMdpDTO(
      ancienMotDePasse: json['ancienMotDePasse'],
      confirmPassword: json['confirmPassword'],
      motDePasse: json['motDePasse'],
    );
  }

  // Méthode pour convertir une instance de ChangerMdpDTO en objet JSON
  Map<String, dynamic> toJson() {
    return {
      'ancienMotDePasse': ancienMotDePasse,
      'confirmPassword': confirmPassword,
      'motDePasse': motDePasse,
    };
  }
}
