import 'package:flutter/material.dart';
import 'package:mon_app/exceptions/badCurrentPwdException.dart';
import 'package:mon_app/login/auth_service.dart';
import 'package:mon_app/models/ChangerMdpDTO.dart';
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

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();



  UserContext? userContext;
  bool isLoadingPreferences = true;
  bool receiveDocumentsByPost = false;
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
          receiveDocumentsByPost = true;
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
          backgroundColor: AppTheme.backgroundColor, // Utilisation de la couleur de fond définie dans le thème
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
              labelColor: AppTheme.secondaryColor, // Utilisation de la couleur secondaire du thème
              indicatorColor: AppTheme.primaryColor, // Utilisation de la couleur primaire du thème
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
            style: AppTheme.generalTextStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
            value: viewDocumentsOnlineOnly,
            title: const Text('Les consulter uniquement depuis mon espace client (web/app)'),
            onChanged: (bool? value) {
              setState(() {
                viewDocumentsOnlineOnly = value ?? false;
                if (viewDocumentsOnlineOnly) receiveDocumentsByPost = false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            value: receiveDocumentsByPost,
            title: const Text('Les recevoir en plus par courrier postal'),
            onChanged: (bool? value) {
              setState(() {
                receiveDocumentsByPost = value ?? false;
                if (receiveDocumentsByPost) viewDocumentsOnlineOnly = false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoadingPreferences = true; // Activer le chargement
                });

                try {
                  // Appel asynchrone pour sauvegarder les préférences
                  final isPaper = await profileService.changeDematerialisationStatus(receiveDocumentsByPost);

                  setState(() {
                    receiveDocumentsByPost = isPaper;
                    viewDocumentsOnlineOnly = !isPaper;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Préférences enregistrées avec succès.')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur : ${e.toString()}')),
                  );
                } finally {
                  setState(() {
                    isLoadingPreferences = false; // Désactiver le chargement
                  });
                }
              },
              style: AppTheme.elevatedButtonStyle, // Utilisation du style défini
              child: isLoadingPreferences
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Enregistrer'),
            ),

          ),
        ],
      ),
    );
  }


Widget _buildPasswordSettings() {
  // États pour gérer l'affichage/cachage des mots de passe
  ValueNotifier<bool> showCurrentPassword = ValueNotifier<bool>(false);
  ValueNotifier<bool> showNewPassword = ValueNotifier<bool>(false);
  ValueNotifier<bool> showConfirmPassword = ValueNotifier<bool>(false);

  // États pour suivre les critères de mot de passe
  ValueNotifier<bool> hasMinLength = ValueNotifier<bool>(false);
  ValueNotifier<bool> hasUpperLower = ValueNotifier<bool>(false);
  ValueNotifier<bool> hasNumber = ValueNotifier<bool>(false);
  ValueNotifier<bool> hasSpecialChar = ValueNotifier<bool>(false);


  // Fonction pour valider les critères
  void validatePassword(String password) {
    hasMinLength.value = password.length >= 12;
    hasUpperLower.value = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])').hasMatch(password);
    hasNumber.value = RegExp(r'\d').hasMatch(password);
    hasSpecialChar.value = RegExp(r'[!@#$€%^&*()_+\-=\[\]{}\"\\|,.<>\/?]').hasMatch(password);
  }

  void submitPasswordChangingRequest(String currentPassword,String newPassword, String confirmPassword) async {
  // Comparaison entre le mot de passe et sa confirmation 
  if (newPassword != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Les mots de passe ne correspondent pas !')));
     return;
  }

  // Vérification des critères de sécurité du (des) mot de passe
  if (hasSpecialChar.value && hasUpperLower.value && hasNumber.value && hasMinLength.value) {

     final changerMdpDTO = ChangerMdpDTO(
      ancienMotDePasse: currentPassword,
      motDePasse: newPassword,
      confirmPassword: confirmPassword,
    );
    try {
      // /password
      await  profileService.modifierMDP(changerMdpDTO);
       ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mot de passe modifié avec succès !')),
    );
       
  }
  catch(exception){
    print(exception);
    if(exception is BadCurrentPwdException){
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mot de passe actuel incorrect :)  ')),
    );

    }else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Petite exception sypatoche ')),
    );
  }
  }

   
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Le mot de passe ne respecte pas les critères !')),
    );
  }
}
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre
          const Text(
            'Modifier mon mot de passe',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Description
          const Text(
            'Indiquez votre mot de passe actuel afin de pouvoir le modifier',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 16),

          // Mot de passe actuel
          ValueListenableBuilder<bool>(
            valueListenable: showCurrentPassword,
            builder: (context, isVisible, _) {
              return TextFormField(
                controller:currentPasswordController,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  labelText: 'Mot de passe actuel',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => showCurrentPassword.value = !isVisible,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16),

          // Nouveau mot de passe
          Text(
            'Choisissez votre nouveau mot de passe',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 8),
          
          ValueListenableBuilder<bool>( 
            valueListenable: showNewPassword,
            builder: (context, isVisible, _) {
              return TextFormField(
                controller: newPasswordController, // Utilisation du contrôleur
                obscureText: !isVisible,
                onChanged: validatePassword, // Appelle la fonction de validation
                decoration: InputDecoration(
                  labelText: 'Nouveau mot de passe',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => showNewPassword.value = !isVisible,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16),

          // Critères de mot de passe
          const Text(
            'Pour la sécurité de vos données personnelles, merci de respecter les critères ci-dessous :',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDynamicCriteria(hasMinLength, 'Au moins 12 caractères'),
              buildDynamicCriteria(hasUpperLower, 'Au moins une majuscule et une minuscule'),
              buildDynamicCriteria(hasNumber, 'Au moins 1 chiffre'),
              buildDynamicCriteria(hasSpecialChar, 'Au moins 1 caractère spécial (ex: # @ & " ? ! \$ ...)'),
            ],
          ),
          SizedBox(height: 16),

          // Confirmer le mot de passe
          ValueListenableBuilder<bool>(
            valueListenable: showConfirmPassword,
            builder: (context, isVisible, _) {
              return TextFormField(
                controller: confirmPasswordController, // Utilisation du contrôleur
                obscureText: !isVisible,
                decoration: InputDecoration(
                  labelText: 'Confirmer le mot de passe',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => showConfirmPassword.value = !isVisible,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 24),

          // Bouton Enregistrer
          Center(
            child: ElevatedButton(
              onPressed: () {
                submitPasswordChangingRequest(
                  currentPasswordController.text,
                  newPasswordController.text,
                  confirmPasswordController.text
                );              
              },
              child: Text('Enregistrer'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Widget pour afficher une ligne de critère dynamique
Widget buildDynamicCriteria(ValueNotifier<bool> criteriaNotifier, String text) {
  return ValueListenableBuilder<bool>(
    valueListenable: criteriaNotifier,
    builder: (context, isValid, _) {
      return Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.circle_outlined,
            color: isValid ? Colors.green : Colors.grey,
            size: 20,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: isValid ? Colors.green : Colors.grey,
              ),
            ),
          ),
        ],
      );
    },
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
