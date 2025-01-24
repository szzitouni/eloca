import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';


class AppLocalizations {
  final String locale;

  AppLocalizations(this.locale);

  static late Map<String, String> _localizedStrings;

  Future<void> load() async {
    final jsonString = await rootBundle.loadString('assets/lang/$locale.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  static AppLocalizations of(context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}
