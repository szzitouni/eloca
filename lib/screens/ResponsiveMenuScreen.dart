import 'package:flutter/material.dart';

class ResponsiveMenuScreen extends StatelessWidget {
  const ResponsiveMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Utilisation de MediaQuery pour obtenir la taille de l'écran
    final width = MediaQuery.of(context).size.width;

    // Si la largeur de l'écran est supérieure à 600, afficher le menu en haut (grand écran)
    // Sinon, afficher le menu en bas (mobile)
    return Scaffold(
      appBar: width > 600 ? AppBar(title: const Text('Menu')) : null,
      body: Center(
        child: Text('Contenu principal ici'),
      ),
      bottomNavigationBar: width <= 600
          ? BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              ],
              onTap: (index) {
                // Logique de navigation ici
              },
            )
          : null,
    );
  }
}
