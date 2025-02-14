

import 'package:flutter/material.dart';
import 'package:mon_app/login/auth_service.dart';
import 'package:mon_app/models/gestionnaire.dart';
import 'package:mon_app/dashboard/dashboard_service.dart'; 
import '../components/header.dart'; // Import du Header
import '../components/volet.dart'; // Import du Volet
import '../themes/eloca_theme.dart'; // Import du fichier de thème

class DashboardPage extends StatefulWidget {
  DashboardPage();

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _dashboardService = DashboardService(); 
  final _authentificationService = AuthentificationService();

  Gestionnaire? gestionnaire;
  String solde = '...';
  String signalementStatut = 'Aucun signalement';
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Méthode pour charger les données
 Future<void> _fetchData() async {
  try {
    final idProfil = await _authentificationService.getIdProfil();
    if (idProfil > 0) {
      final fetchedGestionnaire = await _dashboardService.getGestionnaire(idProfil);
      setState(() {
        gestionnaire = fetchedGestionnaire;
        solde = '150.00 €';
        signalementStatut = '2 signalements en attente';
        isLoading = false;
      });
    } else {
      print('ID Profil invalide (<= 0)');
    }
  } catch (e) {
    print('Erreur dans _fetchData : $e');
    setState(() {
      errorMessage = 'Erreur lors du chargement des données : $e';
      isLoading = false;
    });
  } finally {
    // Toujours s'assurer que isLoading est mis à jour
    if (isLoading) {
      setState(() {
        isLoading = false;
      });
    }
    print('Fin de _fetchData : isLoading=$isLoading');
  }
}


  // Méthode pour afficher un dialogue d'erreur
  void showErrorDialog(dynamic error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text(error.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Affiche un indicateur de chargement si les données sont en cours de récupération
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    // Affiche un message d'erreur si une erreur s'est produite
    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          body: Row(
            children: [
              if (isLargeScreen) Volet(),
              Expanded(
                child: Column(
                  children: [
                    Header(
                      title: 'Tableau de bord',
                      showMenuButton: !isLargeScreen,
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListView(
                              padding: const EdgeInsets.all(16.0),
                              children: [
                                MonCompteWidget(solde: solde),
                                const SizedBox(height: 16),
                                SignalementsWidget(statut: signalementStatut),
                                if (!isLargeScreen && gestionnaire != null)
                                  ContacterGestionnaireWidget(
                                    gestionnaire: gestionnaire!,
                                  ),
                              ],
                            ),
                          ),
                          if (isLargeScreen && gestionnaire != null)
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ContacterGestionnaireWidget(
                                  gestionnaire: gestionnaire!,
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
          drawer: !isLargeScreen
              ? Drawer(
                  child: Volet(),
                )
              : null,
        );
      },
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final Widget child;

  const DashboardCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTheme.titleTextStyle,
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class MonCompteWidget extends StatelessWidget {
  final String solde;

  const MonCompteWidget({required this.solde});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'MON COMPTE',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Solde :', style: AppTheme.subtitleTextStyle),
              Text(
                solde,
                style: AppTheme.getBalanceColorStyle(solde),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              style: AppTheme.elevatedButtonStyle,
              onPressed: () {
                Navigator.pushNamed(context, '/account');
              },
              child: Text('Voir le détail du compte', style: AppTheme.buttonTextStyle),

            ),
          ),
        ],
      ),
    );
  }
}

class SignalementsWidget extends StatelessWidget {
  final String statut;

  const SignalementsWidget({required this.statut});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'SIGNALEMENTS',
      child: Column(
        children: [
          Text(
            statut, 
            style: AppTheme.subtitleTextStyle),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              style: AppTheme.elevatedButtonStyle,
              onPressed: () {
                Navigator.pushNamed(context, '/reports');
              },
              child: Text('+ Nouveau signalement', style: AppTheme.buttonTextStyle),
            ),
          ),
        ],
      ),
    );
  }
}

class ContacterGestionnaireWidget extends StatelessWidget {
  final Gestionnaire gestionnaire;

  const ContacterGestionnaireWidget({required this.gestionnaire});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'CONTACTER MON GESTIONNAIRE',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nom : ${gestionnaire.nom}', style: AppTheme.subtitleTextStyle),
          const SizedBox(height: 8),
          Text('Email : ${gestionnaire.mail}', style: AppTheme.subtitleTextStyle),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              style: AppTheme.elevatedButtonStyle,
              onPressed: () {
                Navigator.pushNamed(context, '/messages');
              },
              child: Text('Contacter', style: AppTheme.buttonTextStyle),
            ),
          ),
        ],
      ),
    );
  }
}
