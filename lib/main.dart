import 'package:flutter/material.dart';
import 'profile/profile_page.dart';
import 'account/account_page.dart';
import 'cgu/cgu_page.dart';
import 'login/login_page.dart';
import 'dashboard/dashboard_page.dart';
import 'messages/messages_page.dart';
import 'reports/reports_page.dart';
import 'themes/eloca_theme.dart'; // Ton fichier de thème personnalisé


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eloca',
      
      debugShowCheckedModeBanner: false, // Désactive le bandeau "debug"
      theme: AppTheme.themeData,
      initialRoute: '/login', // Page initiale : LoginPage
      routes: _routes, // Map des routes
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('Page non trouvée')),
        ),
      ),
    );
  }
}

// Map des routes pour une gestion plus propre
final Map<String, WidgetBuilder> _routes = {
  '/login': (context) => LoginPage(),
  '/dashboard': (context) => DashboardPage(),
  '/messages': (context) => MessagesPage(),
  '/profil': (context) => ProfilePage(),
  '/account': (context) => AccountPage(),
  '/cgu': (context) => CguPage(),
  '/reports': (context) => ReportsPage(),
};
