// import 'package:flutter/material.dart';
// import '../components/header.dart'; // Import du Header
// import '../components/volet.dart'; // Import du Volet

// class DocumentsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         bool isLargeScreen = constraints.maxWidth > 800;

//         return Scaffold(
//           backgroundColor: const Color.fromARGB(255, 246, 241, 241),
//           body: Row(
//             children: [
//               // Barre latérale (Volet) pour les grands écrans
//               if (isLargeScreen)
//                 const Volet(
//                   appartementDetails:
//                       'Type de l\'appartement \nNuméro de l\'appartement \nRue \nCode Postal',
//                 ),

//               // Contenu principal
//                Expanded(
//                 child: Column(
//                   children: [
//                     // Ajout du Header
//                     Header(
//                       title: 'Documents',
//                       showMenuButton: false,
//                       nom: 'ZITOUNI',
//                       prenom: 'Sarah',
//                     ),

//                     // Corps principal de la page
//                     const Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Center(
//                           child: Text(
//                             'Documents',
//                             style: const TextStyle(fontSize: 18),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           // Drawer pour petit écran
//           drawer: !isLargeScreen
//               ? const Drawer(
//                   child: Volet(
//                     appartementDetails:
//                         'Type de l\'appartement \nNuméro de l\'appartement \nRue \nCode Postal',
//                   ),
//                 )
//               : null, // Pas de Drawer si la taille est grande
//         );
//       },
//     );
//   }
// }
