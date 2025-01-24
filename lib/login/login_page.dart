import 'package:flutter/material.dart';
import 'package:mon_app/dashboard/dashboard_page.dart';
import 'package:mon_app/login/auth_service.dart';
import 'package:mon_app/models/connexionDTO.dart';
import 'package:mon_app/models/offerDTO.dart';
import 'package:mon_app/models/userContext.dart';
import 'login_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LoginService _loginService = LoginService();
  final FocusNode _passwordFocusNode = FocusNode();
  final AuthentificationService authentificationService = AuthentificationService();
  late OfferDTO offer;

  // Soumission du formulaire
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      try {
        ConnexionDTO? connexionDTO = await _loginService.login(context, email, password);

        if (connexionDTO != null) {
          UserContext userContext = UserContext(contextList: connexionDTO.connexions, email: email);
          await setContextAndGoHome(userContext, 100);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erreur: Connexion échouée')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de connexion: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> setContextAndGoHome(UserContext userContext, int index) async {
    try {
      if (userContext.contextList != null && userContext.contextList!.isNotEmpty) {
        if (index >= 0 && index < userContext.contextList!.length) {
          userContext.currentContext = userContext.contextList![index];
        } else {
          print('Index invalide, assignation du premier contexte disponible.');
          userContext.currentContext = userContext.contextList![0];
        }
      } else {
        print('Liste des contextes vide ou null.');
        throw Exception("Aucun contexte utilisateur disponible.");
      }

      await authentificationService.setUserContext(userContext);
      print("\n\n\n Login page : UserContext set successfully");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(),
        ),
      );
    } catch (e) {
      print('\n\nException levée : méthode setContextAndGoHome()\n\nErreur : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Désactiver le bouton retour
      child: Scaffold(
        appBar: null, // Pas d'AppBar
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/eloca.png',
                      height: 100,
                    ),
                    SizedBox(height: 30),
                    Image.asset(
                      'assets/images/teddy_2.png',
                      height: 250,
                    ),
                    SizedBox(height: 1),

                    Container(
                      constraints: BoxConstraints(maxWidth: 400),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
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
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(_passwordFocusNode);
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            decoration: const InputDecoration(
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
                            onFieldSubmitted: (value) {
                              _submit();
                            },
                          ),
                          SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
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
      ),
    );
  }
}
