import 'dart:convert';
import 'package:ventefilms/widget/show_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ventefilms/config.dart';

class Authentication {
  static bool isAuthenticated = false;

  static Future<void> logoutUser(context) async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getInt('idUser').toString();

    final response = await http.post(
      Uri.parse(
          'http://${AppConfig.serverIP}:${AppConfig.serverPort}/api/logout'),
      body: {'id_user': id},
    );

    if (response.statusCode == 200) {
      // Effacez le token et l'ID utilisateur localement
      await Authentication.clearTokens();
      isAuthenticated = false;
    } else {
      // Gérez les erreurs, par exemple, affichez un message d'erreur à l'utilisateur.
      final errorMessage = json.decode(response.body)['error'];
      print(errorMessage);
      showErrorDialog(context, errorMessage);
    }
  }

  static Future<bool> authenticated() async {
    final token = await Authentication.getToken();

    if (token != null && token.isNotEmpty) {
      isAuthenticated = true;
    } else {
      isAuthenticated = false;
    }
    return isAuthenticated;
  }

  static Future<void> saveToken(String apiToken, int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_token', apiToken);
    await prefs.setInt('idUser', id);
  }

  static Future<Map<String, dynamic>?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final apiToken = prefs.getString('api_token');
    final userId = prefs.getInt('idUser');
    if (apiToken != null && userId != null) {
      return {'token': apiToken, 'id': userId};
    } else {
      return null;
    }
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<Map<String, dynamic>> fetchUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id_user = prefs.getInt('idUser').toString();

    if (id_user != "") {
      final response = await http.post(
        Uri.parse(
            'http://${AppConfig.serverIP}:${AppConfig.serverPort}/api/getUserData'),
        body: {'user_id': id_user},
      );
      if (response.statusCode == 200) {
        return json.decode(response.body)['user'];
      } else {
        throw Exception(
            'Impossible de récupérer les données de l\'utilisateur');
      }
    } else {
      throw Exception(
          'Impossible d\'envoyer la requête pour récupérer les données de l\'utilisateur');
    }
  }

  static Future<String> updateProfil(newFullName, newEmail, imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id_user = prefs.getInt('idUser').toString();

    if (id_user != "") {
      final response = await http.post(
        Uri.parse(
            'http://${AppConfig.serverIP}:${AppConfig.serverPort}/api/update/profil'),
        body: {
          'user_id': id_user,
          'name': newFullName,
          'email': newEmail,
          'image': imagePath
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body)['succes'];
      } else {
        throw Exception(
            'Impossible de terminer la modification de données les données de l\'utilisateur');
      }
    } else {
      throw Exception('Impossible d\'envoyer les données de modifcations');
    }
  }
}
