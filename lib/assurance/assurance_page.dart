// import 'package:flutter/material.dart';
// import 'package:mon_app/components/header.dart';
// import '../components/volet.dart'; // Import du Volet

// class AssurancePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         bool isLargeScreen = constraints.maxWidth > 800;

//         return Scaffold(
//           backgroundColor: const Color.fromARGB(255, 246, 241, 241),
//           body: Row(
//             children: [
//               // Utilisation du Volet pour les grands écrans
//               if (isLargeScreen)
//                 const Volet(
//                   appartementDetails:
//                       'Type de l\'appartement \nNuméro de l\'appartement \nRue \nCode Postal',
//                 ),

//               // Contenu principal
//               Expanded(
//                 child: Column(
//                   children: [
//                     // Header
//                     Header(
//                       title: 'Assurance',
//                       showMenuButton: !isLargeScreen,
//                       nom: 'ZITOUNI',
//                       prenom: 'Sarah',
//                     ),

//                     const Expanded(
//                       child: Center(
//                         child: Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Text(
//                             'Page dédiée à votre assurance.',
//                             style: TextStyle(fontSize: 18, color: Colors.black54),
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
//               : null,
//         );
//       },
//     );
//   }
// }
