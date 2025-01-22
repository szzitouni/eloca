import 'package:flutter/material.dart';
import '../components/header.dart'; // Import du Header
import '../components/volet.dart'; // Import du Volet
import '../themes/eloca_theme.dart'; // Import du fichier de thème

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  String? selectedConversation; // Conversation sélectionnée
  final List<String> conversations = [
    'Conversation avec le gestionnaire',
    'Conversation avec le comptable',
    'Problème avec un projet immobilier',
    'Réclamation sur un service'
  ];

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
            title: const Text('Messages'),
            backgroundColor: AppTheme.primaryColor,
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _showMessageOptionsDialog,
              ),
            ],
          ),
          drawer: !isLargeScreen
              ? const Drawer(
                  child: Volet(),
                )
              : null, // Drawer pour petit écran
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

                    // Contenu de la page avec deux colonnes : conversations à gauche et messages à droite
                    Expanded(
                      child: Row(
                        children: [
                          // Colonne des conversations à gauche
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: _showMessageOptionsDialog,
                                  child: const Text("Nouvelle conversation"),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: conversations.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(conversations[index]),
                                        onTap: () {
                                          setState(() {
                                            selectedConversation = conversations[index];
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Colonne des messages à droite
                          Expanded(
                            flex: 2,
                            child: selectedConversation == null
                                ? const Center(child: Text('Veuillez sélectionner une conversation.'))
                                : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          selectedConversation!,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        // Affichage des messages (actuellement statiques)
                                        const Text(
                                          'Détail du message...',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        // Champ pour rédiger un nouveau message
                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: messageController,
                                          decoration: InputDecoration(
                                            labelText: 'Écrivez votre message...',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        // Boutons pour envoyer ou ajouter une pièce jointe
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.attach_file),
                                              onPressed: () {
                                                // Logique pour ajouter une pièce jointe
                                              },
                                            ),
                                            Spacer(),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Logique pour envoyer le message
                                                _sendMessage();
                                              },
                                              child: const Text("Envoyer"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Affiche la boîte de dialogue pour choisir l'option du nouveau message
  void _showMessageOptionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Je souhaite :'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Contacter mon gestionnaire'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    selectedConversation = 'Contacter mon gestionnaire';
                  });
                },
              ),
              ListTile(
                title: const Text('Contacter mon comptable'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    selectedConversation = 'Contacter mon comptable';
                  });
                },
              ),
              ListTile(
                title: const Text('Projet Immobilier'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    selectedConversation = 'Projet Immobilier';
                  });
                },
              ),
              ListTile(
                title: const Text('Faire une réclamation'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    selectedConversation = 'Faire une réclamation';
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Fonction pour envoyer un message
  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        // Ajouter le message envoyé à la conversation
        conversations.add(messageController.text);
        messageController.clear(); // Vider le champ de texte après l'envoi
      });
    }
  }
}
