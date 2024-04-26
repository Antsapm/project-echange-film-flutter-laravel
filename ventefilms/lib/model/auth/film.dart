import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventefilms/config.dart';

class Film {
  final String titre;
  final String type;
  final String genre;
  final String langue;
  final File? file;
  final File? image;
  final String photo;
  final String duration;
  final String lien;

  Film({
    required this.titre,
    required this.type,
    required this.genre,
    required this.langue,
    required this.file,
    required this.image,
    required this.photo,
    required this.duration,
    required this.lien,
  });

  static Future<Map<String, dynamic>> recuperationInfo(context) async {
    final response = await http.get(Uri.parse(
        'http://${AppConfig.serverIP}:${AppConfig.serverPort}/api/getInsertionInfo'));

    if (response.statusCode == 200) {
      // final answer = json.decode();
      return json.decode(response.body)['bigInfo'];
    } else {
      throw Exception('Impossible de récupérer les données d\'insertion');
    }
  }

  static Future<List<dynamic>> recuperationFilm() async {
    final response = await http.post(
      Uri.parse(
          'http://${AppConfig.serverIP}:${AppConfig.serverPort}/api/recup/film'),
    );

    if (response.statusCode == 200) {
      // final answer = json.decode();
      return json.decode(response.body)['films'];
    } else {
      throw Exception('Impossible de récupérer les données d\'insertion');
    }
  }

  static Future<List<dynamic>> recuperationFilmTitled(String titre) async {
    final response = await http.post(
        Uri.parse(
            'http://${AppConfig.serverIP}:${AppConfig.serverPort}/api/recup/film'),
        body: {'titre': titre});

    if (response.statusCode == 200) {
      // final answer = json.decode();
      return json.decode(response.body)['films'];
    } else {
      throw Exception('Impossible de récupérer les données d\'insertion');
    }
  }

  static Future<void> submitFilm(Film film) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getInt('idUser').toString();
      
      final response = await http.post(
        Uri.parse(
            'http://${AppConfig.serverIP}:${AppConfig.serverPort}/api/uploadFilm'),
        body: {
          'titre': film.titre.toString(),
          'type': film.type.toString(),
          'genre': film.genre.toString(),
          'langue': film.langue.toString(),
          'user': idUser.toString(),
          'file': film.file,
          // 'image': film.image,
          'photo': film.photo.toString(),
        },
      );

      if (response.statusCode == 200) {
        // Traitement de la réponse du backend
        final responseData = json.decode(response.body);

        print(responseData['message']);
      } else {
        // Gérer les erreurs, afficher un message d'erreur, etc.
        print('Erreur lors de l\'enregistrement du film');
      }
      // print(film);
    } catch (error) {
      // Gérer les erreurs, afficher un message d'erreur, etc.
      print('Erreur de tranfert de données : $error');
    }
  }
}
