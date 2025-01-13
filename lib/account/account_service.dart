import 'dart:convert';
import 'package:http/http.dart' as http;

class AccountService {
  final String baseUrl;
  final Map<String, String> defaultHeaders;
  final bool withCredentials;

  AccountService({
    required this.baseUrl,
    required this.defaultHeaders,
    this.withCredentials = false,
  });

  /// Method to get the solde for a specific profile.
  Future<Map<String, String>> getSolde(int idProfil, {bool reportProgress = false}) async {
    // Check if idProfil is null or undefined (like in the original Java code).
    if (idProfil == null) {
      throw ArgumentError('Required parameter idProfil was null or undefined.');
    }

    // Setting the headers.
    Map<String, String> headers = Map.from(defaultHeaders);
    headers['Accept'] = 'application/json'; // Accept header as 'application/json'

    // Construct the URL for the API endpoint
    final Uri url = Uri.parse('$baseUrl/api/v1/profil/${Uri.encodeComponent(idProfil.toString())}/solde');

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
