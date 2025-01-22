import 'package:flutter/material.dart';
import '../components/header.dart'; // Import du Header
import '../components/volet.dart'; // Import du Volet

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 246, 241, 241),
          body: Row(
            children: [
              // Barre latérale pour grands écrans
              if (isLargeScreen)
                const Volet(
                ),

              // Contenu principal
              Expanded(
                child: Column(
                  children: [
                    // Header
                    Header(
                      title: 'Mon Compte',
                      showMenuButton: !isLargeScreen,
                    ),

                    // Corps principal
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mon compte',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Section solde
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            width: double.infinity,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Colonne gauche
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    
                                    Text(
                                      'Solde',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink,
                                      ),
                                    ),
                                  ],
                                ),

                                // Texte à droite
                                const Text(
                                  'Vous payez par prélèvement automatique',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),

                          const Row(
                            children: [
                              Text('Relevé de compte'),
                              // AJouter un boutton ici 
                            ],

                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Drawer pour petits écrans
          drawer: !isLargeScreen
              ? const Drawer(
                  child: Volet(
                  ),
                )
              : null,
        );
      },
    );
  }
}
