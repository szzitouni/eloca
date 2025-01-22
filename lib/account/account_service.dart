import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mon_app/config/config_dev.dart';

class AccountService {
  
  final Map<String, String> defaultHeaders;
  final bool withCredentials;

  AccountService({
   
    required this.defaultHeaders,
    this.withCredentials = false,
  });

  /// Method to get the solde for a specific profile.
  Future<Map<String, String>> getSolde(int idProfil, {bool reportProgress = false}) async {
    // Check if idProfil is null or undefined (like in the original Java code).
    // if (idProfil == null) {
    //   throw ArgumentError('Required parameter idProfil was null or undefined.');
    // }
    // inutile car idProfil ne peut pas etre nukl :) 

    // Setting the headers.
    Map<String, String> headers = Map.from(defaultHeaders);
    headers['Accept'] = 'application/json'; // Accept header as 'application/json'

    // Construct the URL for the API endpoint
    final Uri url =  Uri.parse('${Config.URL_API_PROFIL}/${Uri.encodeComponent(idProfil.toString())}/solde');

    try {
      // Make the GET request.
      final response = await http.get(url, headers: headers);

      // Report progress (for now, you could handle this separately).
      if (reportProgress) {
        // Implement your progress reporting logic here if needed.
      }

      // Check if the response status is OK (200).
      if (response.statusCode == 200) {
        // Parse the response body as JSON.
        Map<String, dynamic> responseBody = json.decode(response.body);

        // Convert the parsed data into a Map<String, String> (matching the original return type).
        return Map<String, String>.from(responseBody);
      } else {
        // Handle non-OK responses (you could throw custom exceptions here).
        throw Exception('Failed to load solde');
      }
    } catch (e) {
      // Handle errors (network issues, parsing issues, etc.).
      throw Exception('Error: $e');
    }
  }
}
