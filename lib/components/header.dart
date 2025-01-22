import 'package:flutter/material.dart';
import 'package:mon_app/login/auth_service.dart';
import 'package:mon_app/models/userContext.dart';
import 'package:mon_app/secure_storage_service.dart';
import 'package:mon_app/themes/eloca_theme.dart';

class Header extends StatefulWidget {
  final String title;
  final bool showMenuButton;
  

  Header({
    required this.title,
    required this.showMenuButton,
  });

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final SecureStorageService _secureStorageService = SecureStorageService(); 
  final AuthentificationService authentificationService = AuthentificationService();
  UserContext? userContext;

  @override
  void initState() {
    super.initState();
    loadUserContext();
  }

  Future<void> loadUserContext() async {
    final context = await authentificationService.getUserContext();
    setState(() {
      userContext = context;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      leading: widget.showMenuButton
          ? Builder(
              builder: (BuildContext context) => IconButton(
                icon: const Icon(Icons.menu, color: AppTheme.secondaryColor),
                tooltip: 'Ouvrir le menu',
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            )
          : null,
      title: Center(
        child: Image.asset(
          'assets/images/eloca.png',
          height: 55,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'profil') {
                Navigator.pushReplacementNamed(context, '/profil');
              } else if (value == 'CGU') {
                Navigator.pushReplacementNamed(context, '/cgu');
              } else if (value == 'Déconnexion') {
                try {
                  await authentificationService.logout();
                  Navigator.pushReplacementNamed(context, '/login');
                } catch (error) {
                  debugPrint('Erreur lors de la déconnexion : $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Impossible de se déconnecter. Veuillez réessayer.')),
                  );
                }
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'profil',
                child: Text(
                  'Mon profil',
                  style: AppTheme.popupMenuTextStyle,
                ),
              ),
              const PopupMenuItem(
                value: 'CGU',
                child: Text(
                  'Mentions légales et CGU',
                  style: AppTheme.popupMenuTextStyle,
                ),
              ),
              PopupMenuItem(
                value: 'Déconnexion',
                child: Text(
                  'Déconnexion',
                  style: AppTheme.popupMenuHighlightedTextStyle,
                ),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: AppTheme.popupMenuDecoration,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    userContext != null
                        ? '${userContext?.currentContext?.prenom ?? ''} ${userContext?.currentContext?.nom ?? ''}'
                        : 'Utilisateur inconnu',
                    style: AppTheme.userNameTextStyle,
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: AppTheme.secondaryColor,
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.person_rounded,
                    color: AppTheme.secondaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
