import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey, // Ajout de la clé pour la validation du formulaire
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo de l'application tout en haut
                  Image.asset(
                    'assets/images/eloca.png', // Chemin de ton logo
                    height: 100, // Taille du logo
                  ),
                  SizedBox(height: 30), // Espacement entre le logo et l'image de l'ours

                  // Image au-dessus du formulaire
                  Image.asset(
                    'assets/images/teddy_2.png', // Chemin correct de l'image
                    height: 250, // Taille de l'image
                  ),
                  SizedBox(height: 1), // Décale le formulaire vers le bas

                  // Formulaire de connexion
                  Container(
                    constraints: BoxConstraints(maxWidth: 400), // Limite la taille max
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre email';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Veuillez entrer un email valide';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre mot de passe';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Action de connexion si le formulaire est valide
                              /*
                              Navigator.pushReplacementNamed(context, '/dashboard');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Connexion en cours...')), -- a revoir 
                                 
                              );
                              */
                              Navigator.pushReplacementNamed(context, '/dashboard');
                            
                            }
                          },
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
