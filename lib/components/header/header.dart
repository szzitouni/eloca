import 'package:flutter/material.dart';
import '../../models/adresse.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenuButton;
  final String nom;
  final String prenom;
  // final Adresse adresse; COMEBACK

  const Header({
    Key? key,
    required this.title,
    required this.showMenuButton,
    required this.nom,
    required this.prenom,
    //required this.adresse, COMEBACK
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0, // Enlève l'ombre sous l'AppBar
      leading: showMenuButton
          ? Builder(
              builder: (BuildContext context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black), // Icône de menu
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Ouvre le drawer
                },
              ),
            )
          : null, // Si showMenuButton est faux, pas de menu.

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
            onSelected: (value) {
              if (value == 'profil') {
                print('Mon profil sélectionné');
              } else if (value == 'CGU') {
                Navigator.pushReplacementNamed(context, '/cgu');
              } else if (value == 'Déconnexion') {
                Navigator.pushReplacementNamed(context, '/login');
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
                  // Nom et prénom de la personne
                  Text(
                    '$prenom $nom', // Affichage du prénom et du nom
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

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
