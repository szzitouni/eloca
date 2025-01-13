import 'package:flutter/material.dart';
import '../components/header.dart'; // Import du Header
import '../components/volet.dart'; // Import du Volet

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 246, 241, 241),
          body: Row(
            children: [
              // Utilisation du Volet pour les grands écrans
              if (isLargeScreen)
                const Volet(),

              // Contenu principal
              Expanded(
                child: Column(
                  children: [
                    // Ajout du Header
                    Header(
                      title: 'Messages',
                      showMenuButton: !isLargeScreen,
                    ),

                    const Expanded(
                      child: Center(
                        child: Text(
                          'Messages',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Drawer pour petit écran
          drawer: !isLargeScreen
              ? const Drawer(
                  child: Volet(),
                )
              : null,
        );
      },
    );
  }
}
