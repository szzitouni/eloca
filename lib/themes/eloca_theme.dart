import 'package:flutter/material.dart';

class AppTheme {
  // Couleurs globales
  static const Color backgroundColor = Color(0xFFF6F1F1);
  static const Color primaryColor = Colors.blue;
  static const Color secondaryColor = Colors.black;
  static const Color positiveBalanceColor = Colors.green;
  static const Color negativeBalanceColor = Colors.red;
  static const Color subtitleColor = Colors.grey;

  // Styles de texte globaux
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: secondaryColor,
  );

  static const TextStyle generalTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: secondaryColor,
  );

  static const TextStyle preferencesTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    textBaseline: TextBaseline.alphabetic,
    color: secondaryColor,
  );

  static const TextStyle infoTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: secondaryColor,
  );

  static const TextStyle balanceTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: positiveBalanceColor, // Couleur par défaut
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: subtitleColor,
  );

  static const TextStyle appBarTitleTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: secondaryColor,
  );

  static const TextStyle popupMenuTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: secondaryColor,
  );

  static const TextStyle popupMenuHighlightedTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle userNameTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: secondaryColor,
  );

  // Styles pour les boutons
  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor, // Couleur de fond
    foregroundColor: Colors.white, // Couleur du texte
    textStyle: buttonTextStyle,    // Style du texte
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  static final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: primaryColor, // Couleur du texte
    textStyle: buttonTextStyle,
    side: const BorderSide(
      color: primaryColor,
      width: 2.0,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  // Méthode pour personnaliser la couleur du texte en fonction du solde
  static TextStyle getBalanceColorStyle(String solde) {
    final balance = double.tryParse(solde.replaceAll('€', '').trim());
    return balance != null && balance < 0
        ? balanceTextStyle.copyWith(color: negativeBalanceColor)
        : balanceTextStyle.copyWith(color: positiveBalanceColor);
  }

  // Méthode pour récupérer ThemeData
  static ThemeData get themeData {
    return ThemeData(
      // Couleurs
      scaffoldBackgroundColor: backgroundColor, // Correcte
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor, // Remplacement de accentColor par colorScheme.secondary
      ),

      // Text Styles
      textTheme: const TextTheme(
        titleLarge: titleTextStyle, // Utilisation de titleLarge au lieu de headline6
        bodyMedium: generalTextStyle,
        bodyLarge: preferencesTextStyle,
        titleMedium: infoTextStyle,
        labelLarge: buttonTextStyle,
        titleSmall: subtitleTextStyle,
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: appBarTitleTextStyle,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: elevatedButtonStyle,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: outlinedButtonStyle,
      ),
    );
  }

  // Si tu veux utiliser popupMenuDecoration, assure-toi qu'elle est définie
  static final BoxDecoration popupMenuDecoration = BoxDecoration(
    border: Border.all(
      color: secondaryColor,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(5),
  );
}
