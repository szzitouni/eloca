import 'package:flutter/material.dart';
import 'package:mon_app/models/offerDTO.dart';
import 'login_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Contrôleurs pour les champs email et mot de passe
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Clé pour valider le formulaire
  final _formKey = GlobalKey<FormState>();

  // Instance du service d'authentification
  final LoginService _loginService = LoginService();

  // FocusNode pour gérer le focus entre les champs
  final FocusNode _passwordFocusNode = FocusNode();

  late OfferDTO offer;
  
  get gestionnaire => null;
 

// Soumission du formulaire
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      // Récupération des valeurs saisies
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      try {
        // Appel de la méthode login dans AuthentificationService
        await _loginService.loginV3(context, email, password);
        
       
       
      } catch (e) {
        // Gestion des erreurs de connexion
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de connexion: ${e.toString()}')),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey, // Clé pour la validation du formulaire
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo de l'application
                  Image.asset(
                    'assets/images/eloca.png', 
                    height: 100, // Taille du logo
                  ),
                  SizedBox(height: 30), // Espacement

                  // Image au-dessus du formulaire
                  Image.asset(
                    'assets/images/teddy_2.png', // Chemin de l'image
                    height: 250, // Taille de l'image
                  ),
                  SizedBox(height: 1), // Espacement entre l'image et le formulaire

                  // Formulaire de connexion
                  Container(
                    constraints: BoxConstraints(maxWidth: 400), // Limitation de la largeur du formulaire
                    child: Column(
                      children: [
                        // Champ email
                        TextFormField(
                          controller: _emailController, // Associer le contrôleur
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress, // Type de clavier pour l'email
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre email';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Veuillez entrer un email valide';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            // Lorsqu'on appuie sur "Entrée" dans le champ email, passer au champ mot de passe
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                        ),
                        SizedBox(height: 20), // Espacement entre les champs

                        // Champ mot de passe
                        TextFormField(
                          controller: _passwordController, // Associer le contrôleur
                          focusNode: _passwordFocusNode, // Associer le FocusNode
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true, // Cacher le texte du mot de passe
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre mot de passe';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            // Lorsqu'on appuie sur "Entrée" dans le champ mot de passe, soumettre le formulaire
                            _submit();
                          },
                        ),
                        SizedBox(height: 32), // Espacement avant le bouton

                        // Bouton de connexion
                        ElevatedButton(
                          onPressed: _submit, // Appelle la méthode _submit lorsqu'on appuie sur le bouton
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Couleur bleue du bouton
                            foregroundColor: Colors.white, // Couleur du texte
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                          child: Text('Me connecter'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
