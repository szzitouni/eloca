import 'connexion.dart';

class UserContext {
  Connexion? currentContext;
  List<Connexion>? contextList;
  final String? email;

  UserContext({
    this.currentContext,
    this.contextList,
    this.email,
  });
 
  factory UserContext.fromJson(Map<String, dynamic> json) {
    return UserContext(
      currentContext: json['currentContext'] != null ? Connexion.fromJson(json['currentContext']) : null,
      contextList: json['contextList'] != null
          ? List<Connexion>.from(json['contextList'].map((x) => Connexion.fromJson(x)))
          : null,
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentContext': currentContext?.toJson(),
      'contextList': contextList?.map((e) => e.toJson()).toList(),
      'email': email,
    };
  }

   @override
  String toString() {
    return 'UserContext {\n'
        '  email: $email,\n'
        '  currentContext: ${currentContext?.toString() ?? "null"},\n'
        '  contextList: ${contextList != null ? contextList!.map((e) => e.toString()).join(", ") : "null"}\n'
        '}';
  }
}
