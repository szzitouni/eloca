import 'package:flutter/material.dart';
import 'package:mon_app/login/auth_service.dart';
import 'package:mon_app/models/userContext.dart';
import 'package:mon_app/profile/profile_service.dart';
import '../components/header.dart'; // Import du Header
import '../components/volet.dart'; // Import du Volet
import '../themes/eloca_theme.dart'; // Import du fichier de thème

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final AuthentificationService authentificationService = AuthentificationService();
  final ProfileService profileService = ProfileService();

  UserContext? userContext;
  bool isLoadingPreferences = true;
  bool receiveDocumentsByMail = false;
  bool viewDocumentsOnlineOnly = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    loadUserContext();
    loadDematerialisationStatus();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> loadUserContext() async {
    try {
      final context = await authentificationService.getUserContext();
      setState(() {
        userContext = context;
      });
    } catch (e) {
      print('Erreur lors du chargement du contexte utilisateur : $e');
    }
  }

  Future<void> loadDematerialisationStatus() async {
    try {
      final status = await profileService.getDematerialisationStatus();
      setState(() {
        if (status) {
          receiveDocumentsByMail = true;
        } else {
          viewDocumentsOnlineOnly = true;
        }
      });
    } catch (e) {
      print('Erreur lors de la récupération du statut de dématérialisation : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors du chargement des préférences.')),
      );
    } finally {
      setState(() {
        isLoadingPreferences = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          body: Row(
            children: [
              if (isLargeScreen) const Volet(), // Barre latérale pour grands écrans
              Expanded(
                child: Column(
                  children: [
                    Header(title: 'Profil', showMenuButton: !isLargeScreen),
                    _buildScrollableTabBar(),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildGeneralInfo(),
                          _buildPreferences(),
                          _buildPasswordSettings(),
                          _buildCookieSettings(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          drawer: !isLargeScreen ? const Drawer(child: Volet()) : null,
        );
      },
    );
  }

  Widget _buildScrollableTabBar() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            _scrollController.animateTo(
              _scrollController.offset - 100,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: AppTheme.secondaryColor,
              indicatorColor: AppTheme.primaryColor,
              tabs: const [
                Tab(text: 'Informations générales'),
                Tab(text: 'Mes préférences'),
                Tab(text: 'Mon mot de passe'),
                Tab(text: 'Paramétrer les cookies'),
              ],
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            _scrollController.animateTo(
              _scrollController.offset + 100,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }

  Widget _buildGeneralInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userContext != null
                ? 'Nom et Prénom : ${userContext?.currentContext?.prenom ?? ''} ${userContext?.currentContext?.nom ?? ''}'
                : 'Nom et Prénom : inconnu',
            style: AppTheme.generalTextStyle,
          ),
          const SizedBox(height: 10),
          Text(
            userContext != null
                ? 'Adresse postale : ${userContext?.currentContext?.adresse ?? ''}'
                : 'Adresse postale : inconnue',
            style: AppTheme.generalTextStyle,
          ),
          const SizedBox(height: 10),
          Text(
            userContext != null
                ? 'Adresse e-mail : ${userContext?.email ?? ''}'
                : 'Adresse e-mail : inconnue',
            style: AppTheme.generalTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferences() {
    if (isLoadingPreferences) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documents de gestion, je souhaite :',
            style: AppTheme.generalTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
            value: viewDocumentsOnlineOnly,
            title: const Text('Les consulter uniquement depuis mon espace client (web/app)'),
            onChanged: (bool? value) {
              setState(() {
                viewDocumentsOnlineOnly = value ?? false;
                if (viewDocumentsOnlineOnly) receiveDocumentsByMail = false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            value: receiveDocumentsByMail,
            title: const Text('Les recevoir en plus par courrier postal'),
            onChanged: (bool? value) {
              setState(() {
                receiveDocumentsByMail = value ?? false;
                if (receiveDocumentsByMail) viewDocumentsOnlineOnly = false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (viewDocumentsOnlineOnly || receiveDocumentsByMail) {
                  print('Préférences sauvegardées :');
                  print('  - Consultation en ligne : $viewDocumentsOnlineOnly');
                  print('  - Réception par courrier : $receiveDocumentsByMail');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Préférences enregistrées avec succès.')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez sélectionner au moins une option.')),
                  );
                }
              },
              child: const Text('Enregistrer'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordSettings() {
    return Center(
      child: Text(
        'Section pour changer le mot de passe',
        style: AppTheme.generalTextStyle.copyWith(fontSize: 18),
      ),
    );
  }

  Widget _buildCookieSettings() {
    return Center(
      child: Text(
        'Section pour paramétrer les cookies',
        style: AppTheme.generalTextStyle.copyWith(fontSize: 18),
      ),
    );
  }
}
