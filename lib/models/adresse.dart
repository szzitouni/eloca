
class Adresse {
  final String? volet1;
  final String? volet2;
  final String? volet3;
  final String? volet4;
  final String? volet5;
  final String? volet6;
  final String? volet7;

  Adresse({
    this.volet1,
    this.volet2,
    this.volet3,
    this.volet4,
    this.volet5,
    this.volet6,
    this.volet7,
  });

   factory Adresse.fromJson(Map<String, dynamic> json) {
    return Adresse(
      volet1: json['volet1'],
      volet2: json['volet2'],
      volet3: json['volet3'],
      volet4: json['volet4'],
      volet5: json['volet5'],
      volet6: json['volet6'],
      volet7: json['volet7'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'volet1': volet1,
      'volet2': volet2,
      'volet3': volet3,
      'volet4': volet4,
      'volet5': volet5,
      'volet6': volet6,
      'volet7': volet7,
    };
  }
}