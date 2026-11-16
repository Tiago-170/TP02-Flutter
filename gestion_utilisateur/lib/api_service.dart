import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://172.16.195.254:3000/api/utilisateurs';   // A configurer

  Future<List<dynamic>> fetchUtilisateurs() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception("Erreur API ${response.statusCode}");
    }
  }

  Future<void> addUtilisateur(String nom, String email, String telephone) async {
  
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nom': nom,
          'email': email,
          'telephone': telephone,
        }),
      );
  
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception("Erreur API ${response.statusCode}");
      }
    }
  }