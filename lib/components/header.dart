import 'package:flutter/material.dart';
import 'package:mon_app/login/auth_service.dart';
import 'package:mon_app/login/login_service.dart';
import 'package:mon_app/models/userContext.dart'; // Assurez-vous que AuthService est bien importé

class Header extends StatefulWidget {
  final String title;
  final bool showMenuButton;
  //final ConnexionDTO connexionDTO; // Injection de ConnexionDTO

  Header({
    required this.title,
    required this.showMenuButton,
    //required this.connexionDTO,
  });

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final authentificationService = AuthentificationService();
  UserContext? userContext; // Stocker les données utilisateur

  @override
  void initState() {
    super.initState();
    loadUserContext();
  }

  Future<void> loadUserContext() async {
    final context = await getUserContext();
    setState(() {
      userContext = context;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0, // Enlève l'ombre sous l'AppBar
      leading: widget.showMenuButton
          ? Builder(
              builder: (BuildContext context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                tooltip: 'Ouvrir le menu', // Tooltip pour accessibilité
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            )
          : null,

      title: Center(
        child: Image.asset(
          'assets/images/eloca.png',
          height: 55, // Taille du logo
        ),
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'profil') {
                Navigator.pushReplacementNamed(context, '/profil');
              } else if (value == 'CGU') {
                Navigator.pushReplacementNamed(context, '/cgu');
              } else if (value == 'Déconnexion') {
                try {
                  // Révoquer le token et rediriger vers la page de login
                  await authentificationService.logout();
                  Navigator.pushReplacementNamed(context, '/login');
                } catch (error) {
                  // Afficher un message d'erreur si la révocation échoue
                  debugPrint('Erreur lors de la déconnexion : $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Impossible de se déconnecter. Veuillez réessayer.')),
                  );
                }
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'profil',
                child: Text('Mon profil'),
              ),
              const PopupMenuItem(
                value: 'CGU',
                child: Text('Mentions légales et CGU'),
              ),
              const PopupMenuItem(
                value: 'Déconnexion',
                child: Text('Déconnexion'),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Couleur du cadre
                  width: 1, // Épaisseur du cadre
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    userContext != null
                        ? '${userContext?.currentContext?.prenom.toString()} ${userContext?.currentContext?.nom.toString()}'
                        : 'Utilisateur inconnu', // Affichage par défaut si les données sont absentes
                    style: const TextStyle(
                      color: Colors.black, // Couleur du texte
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8), // Espace

                  // Petite flèche vers le bas
                  const Icon(
                    Icons.arrow_drop_down, // Icône flèche vers le bas
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8), // Espace

                  // Icône d'utilisateur à gauche
                  const Icon(
                    Icons.person_rounded, // Icône utilisateur
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<UserContext?> getUserContext() {
    return authentificationService.userContext;
  }

}
