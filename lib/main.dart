import 'package:flutter/material.dart';
import 'profile/profile_page.dart';
import 'account/account_page.dart';
import 'cgu/cgu_page.dart';
import 'login/login_page.dart';
import 'dashboard/dashboard_page.dart';
import 'messages/messages_page.dart';
import 'reports/reports_page.dart';


void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // Désactive le bandeau "debug"
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',  // On démarre avec la page de connexion
       onGenerateRoute: (settings) {
        switch (settings.name) {

          case '/login':
            return MaterialPageRoute(builder: (context) => LoginPage());

          case '/dashboard':
          return MaterialPageRoute(builder: (context) => DashboardPage());
          case '/messages':
            return MaterialPageRoute(builder: (context) => MessagesPage());
          case '/profil':
            return MaterialPageRoute(builder: (context) => ProfilePage());
          case '/account':
            return MaterialPageRoute(builder: (context) => AccountPage());
          case '/cgu':
            return MaterialPageRoute(builder: (context) => CguPage());
          case '/reports':
            return MaterialPageRoute(builder: (context) => ReportsPage());
          default:
            return null; // Pour les routes inconnues
        }
      },
    );
  }
}
