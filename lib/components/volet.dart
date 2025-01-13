import 'package:flutter/material.dart';
import 'package:mon_app/login/auth_service.dart';
import 'package:mon_app/models/adresse.dart';
import 'package:mon_app/models/userContext.dart';

class Volet extends StatefulWidget {
  const Volet() ;

  @override
  _VoletState createState() => _VoletState();
}

class _VoletState extends State<Volet> {
  final authentificationService = AuthentificationService();
  UserContext? userContext; // Stocker les données utilisateur
  Adresse? adresse ;

  @override
  void initState() {
    super.initState();
    loadUserContext();
  }

  Future<void> loadUserContext() async {
    final context = await getUserContext();
    setState(() {
      userContext = context;
    });
     adresse =userContext!.currentContext?.infosLot?[0].adresse;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Largeur fixe pour le volet
      decoration: BoxDecoration(
        color: Colors.white, // Couleur de fond du volet
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // Ombre sous le volet
          ),
        ],
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue, // Couleur de l'en-tête du volet
            ),
            child: Text(
              userContext != null
                  ? '${this.getCompleteAdress()}'
                  : 'Adresse inconnue', // Affichage par défaut si les données sont absentes,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          ListTile(
            title: const Text('Accueil'),
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            title: const Text('Compte'),
            onTap: () {
              Navigator.pushNamed(context, '/account');
            },
          ),
          ListTile(
            title: const Text('Messages'),
            onTap: () {
              Navigator.pushNamed(context, '/messages');
            },
          ),
          ListTile(
            title: const Text('Signalements'),
            onTap: () {
              Navigator.pushNamed(context, '/reports');
            },
          ),
          ListTile(
            title: const Text('Documents'),
            onTap: () {
              Navigator.pushNamed(context, '/documents');
            },
          ),
          ListTile(
            title: const Text('Assurance'),
            onTap: () {
              Navigator.pushNamed(context, '/assurance');
            },
          ),
        ],
      ),
    );
  }

  Future<UserContext?> getUserContext() {
    return authentificationService.userContext;
  }

  
  String getCompleteAdress(){
    //return userContext!.currentContext?.infosLot?[0].typeLot.split(',').map((item) => item.trim()).toList();
    return ('${userContext!.currentContext?.infosLot?[0].typeLot} \n ${userContext!.currentContext?.adresse.toString()}');
  }
}
//${userContext!.currentContext?.infosLot?[0].adresse}