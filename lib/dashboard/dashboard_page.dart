import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {


  DashboardPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 241, 241),
      appBar: AppBar( 
        backgroundColor: Colors.white,
        elevation: 0, // Enlève l'ombre sous l'AppBar
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black), // Icône de menu à gauche
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Ouvre le drawer
            },
          ),
        ),
        title: Center(
          child: Image.asset(
            'assets/images/eloca.png',
            height: 55,  // Taille du logo
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'profil') {
                print('Mon profil sélectionné');
              } else if (value == 'CGU') {
                print('Mentions légales et CGU sélectionnées');
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
            padding: EdgeInsets.zero, // Enlève le padding par défaut autour du bouton
            offset: const Offset(0, 50), // Décale le menu déroulant de 50 pixels vers le bas
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(
              color: Colors.black, // Couleur du cadre
              width: 1, // Épaisseur du cadre
            ),
                color: Colors.transparent,
                
                borderRadius: BorderRadius.circular(3),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min, 
                children: [
                  // Nom et prénom de la personne
                   ///Text(' ${gestionnaire.prenom ?? }'' ${gestionnaire.nom ?? }',  
                   Text(' ''}',  
                    style: TextStyle(
                      color: Colors.black,  // Couleur du texte
                    ),
                  ),
                  SizedBox(width: 8), // Espace entre le texte et la flèche
                  // Petite flèche vers le bas
                  Icon(
                    Icons.arrow_downward_rounded, // Icône flèche vers le bas
                    color: Colors.black,
                  ),
                  SizedBox(width: 8), // Espace entre l'icône et le texte
                  // Icône d'utilisateur à gauche
                  Icon(
                    Icons.person_rounded, // Icône utilisateur
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue, // Couleur de l'en-tête du drawer
              ),
              child: Text(
                'Type de l\'appartement \nNuméro de l\'appartemeent \nRue \nCode Postal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: const Text('Option 1'),
              onTap: () {
                // Action pour "Option 1"
                Navigator.pop(context); // Ferme le drawer
              },
            ),
            ListTile(
              title: const Text('Option 2'),
              onTap: () {
                // Action pour "Option 2"
                Navigator.pop(context); // Ferme le drawer
              },
            ),
          ],
        ),
      ), 
      body: const Center(
        child: Text('Contenu du Dashboard'),
      ),
    );
  }
}
