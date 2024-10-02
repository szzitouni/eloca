import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;

  ErrorScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Error")),
      body: Center(child: Text(message)),
    );
  }
}
