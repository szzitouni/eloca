import 'package:flutter/material.dart';
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
      routes: {
        '/login': (context) => LoginPage(),  // page de connexion
        '/dashboard': (context) => DashboardPage(),  // page dashboard 
        '/reports': (context) => ReportsPage(), // page des signalements
        '/messages':(context) => MessagesPage(), // page des messages / contacts
        '/account' :(context) => AccountPage(), // page profil/compte
        '/cgu' : (context) => CguPage(),
      }, 
    );
  }
}
