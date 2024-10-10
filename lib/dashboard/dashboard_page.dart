import 'package:flutter/material.dart';
import '../components/header/header.dart'; // Import du Header

class DashboardPage extends StatelessWidget {
  DashboardPage();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 246, 241, 241),
          body: Row(
            children: [
              // Barre latérale (Drawer) pour les grands écrans
              if (isLargeScreen)
                Container(
                  width: 250, // Largeur fixe pour le drawer
                  decoration: BoxDecoration(
                    color: Colors.white, // Couleur de fond du drawer
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Ombre sous le drawer
                      ),
                    ],
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue, // Couleur de l'en-tête du drawer
                        ),
                        child: Text(
                          'Type de l\'appartement \nNuméro de l\'appartement \nRue \nCode Postal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Acceuil'),
                        onTap: () {
                          // Action 
                        },
                      ),
                      ListTile(
                        title: const Text('Compte'),
                        onTap: () {
                          Navigator.pushNamed(context, '/account');
                        },
                        
                      ),
                      ListTile(
                        title: const Text('Messages'),
                        onTap: () {
                          Navigator.pushNamed(context, '/messages');
                        },
                        
                      ),
                      ListTile(
                        title: const Text('Signalements'),
                        onTap: () {
                          Navigator.pushNamed(context, '/reports');
                        },
                        
                      ),
                      ListTile(
                        title: const Text('Documents'),
                        onTap: () {
                          Navigator.pushNamed(context, '/documents');
                        },
                        
                      ),
                      ListTile(
                        title: const Text('Assurance'),
                        onTap: () {
                          Navigator.pushNamed(context, '/assurance');
                        },
                        
                      ),
                    ],
                  ),
                ),

              Expanded(
                child: Column(
                  children: [
                    // Le Header utilise un bouton pour ouvrir le drawer
                    Header(
                      title: '',
                      showMenuButton: !isLargeScreen,
                      nom: 'ZITOUNI',
                      prenom: 'Sarah',
                    ), // Le Header est toujours visible

                    Expanded(
                      child: Row(
                        children: [
                          // Colonne principale pour les sections "Mon Compte" et "Signalements"
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.all(16),
                              children: [
                                // Si l'écran est petit,  "Contacter mon gestionnaire" est ici
                                if (!isLargeScreen)
                                  _contacterMonGestionnaire(context),

                                // Section Mon Compte
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'MON COMPTE',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Solde :',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              '0.0', // Remplace par ta logique pour le solde
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green, // Valeur par défaut
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Vous payez par prélèvement automatique',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Action pour afficher les détails du compte
                                            },
                                            child: Text('Voir le détail du compte'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16), // Espacement entre les sections

                                // Section Signalements
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'SIGNALEMENTS',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'Aucun signalement',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Naviguer vers la page de signalements
                                              Navigator.pushNamed(context, '/reports');
                                            },
                                            child: Text('+ Nouveau signalement'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16), // Espacement entre les sections
                              ],
                            ),
                          ),

                          // Section "Contacter mon gestionnaire" pour les grands écrans
                          if (isLargeScreen)
                            Container(
                              width: 250, 
                              height: 500,
                              child: _contacterMonGestionnaire(context),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Drawer pour petit écran
          drawer: !isLargeScreen
              ? Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue, // Couleur de l'en-tête du drawer
                        ),
                        child: Text(
                          'Type de l\'appartement \nNuméro de l\'appartement \nRue \nCode Postal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                       ListTile(
                        title: const Text('Acceuil'),
                        onTap: () {
                          // Action 
                        },
                      ),
                      ListTile(
                        title: const Text('Compte'),
                        onTap: () {
                          Navigator.pushNamed(context, '/account');
                        },
                        
                      ),
                      ListTile(
                        title: const Text('Messages'),
                        onTap: () {
                          Navigator.pushNamed(context, '/messages');
                        },
                        
                      ),
                      ListTile(
                        title: const Text('Signalements'),
                        onTap: () {
                          Navigator.pushNamed(context, '/reports');
                        },
                        
                      ),
                      ListTile(
                        title: const Text('Documents'),
                        onTap: () {
                          Navigator.pushNamed(context, '/documents');
                        },
                        
                      ),
                      ListTile(
                        title: const Text('Assurance'),
                        onTap: () {
                          Navigator.pushNamed(context, '/assurance');
                        },
                        
                      ),
                    ],
                  ),
                )
              : null, // Pas de Drawer si la taille est grande
        );
      },
    );
  }

  // Fonction pour la section "Contacter mon gestionnaire"
  Widget _contacterMonGestionnaire(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CONTACTER MON GESTIONNAIRE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nom : Sid LAAALLOUI',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Email : sid.laalaoui@example.com', // Remplace par l'email réel
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                   Navigator.pushNamed(context, '/messages');
                },
                child: Text('Contacter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
