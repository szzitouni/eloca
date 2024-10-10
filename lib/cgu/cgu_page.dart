import 'package:flutter/material.dart';
import 'package:mon_app/models/adresse.dart';
import '../components/header/header.dart'; // Import du Header

class CguPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:  Color.fromARGB(255, 246, 241, 241), // Couleur de fond
      body: Column(
        children: [
          // Ajout du Header
          Header(
            title: 'Conditions Générales d\'Utilisation',
            showMenuButton: true, // Affiche le bouton pour le menu
            nom: 'ZITOUNI', 
            prenom: 'Sarah', 
           /// adresse: {'',''}, COMEBACK
          ),

          // Le reste du corps de la page CGU
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Mentions légales et Conditions générales d\'utilisation',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
