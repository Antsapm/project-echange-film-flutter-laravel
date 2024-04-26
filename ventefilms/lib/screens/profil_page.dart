import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ventefilms/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ventefilms/widget/cardBox.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

// Widget pour afficher une statistique

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData().then((data) {
      setState(() {
        userData = data;
      });
    }).catchError((error, stackTrace) {
      // Gérer l'erreur, afficher une boîte de dialogue d'alerte, etc.
      print("Erreur : $error"); // Affichez l'erreur
      print("Stack trace : $stackTrace"); // Affichez le stack trace
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Impossible d\'accèder au données utilisateurs.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                },
                child: Text('Fermer'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Profil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(userData != null
                      ? userData!['photo'] != null
                          ? userData!['photo'].toString()
                          : userData!['photo'].toString()
                      : 'lib/asset/images/aho.jpg'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                        Icons.edit), // Icône de modification (personnalisable)
                    onPressed: () {
                      Navigator.pushNamed(context, '/profil/change');
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //       builder: (context) => ProfileEditPage()),
                      // );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              userData != null
                  ? userData!['name'] != null
                      ? userData!['name'].toString()
                      : userData!['name'].toString()
                  : 'Nom de l\'utilisateur',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              userData != null
                  ? userData!['email'] != null
                      ? userData!['email'].toString()
                      : userData!['email'].toString()
                  : 'exmple@gmail.com',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatWidget(label: 'Postés', value: '0', icon: Icons.send),
                StatWidget(
                    label: 'Téléchargés', value: '0', icon: Icons.download),
                StatWidget(label: 'Partagés', value: '0', icon: Icons.share),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers le formulaire d'insertion de film
                Navigator.pushNamed(context, '/film/ajouter');
              },
              child: Text('Ajouter un film'),
            ) // Ajoutez d'autres informations utilisateur ici
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id_user = prefs.getInt('idUser').toString();

    if (id_user != "") {
      final response = await http.post(
        Uri.parse(
            'http://${AppConfig.serverIP}:${AppConfig.serverPort}/api/getUserData'),
        body: {'user_id': id_user},
      );
      if (response.statusCode == 200) {
        // final answer = json.decode();
        return json.decode(response.body)['user'];
      } else {
        throw Exception(
            'Impossible de récupérer les données de l\'utilisateur');
      }
    } else {
      throw Exception(
          'Impossible d\'envoyer la requête pour récupèrer les données de l\'utilisateur');
    }
  }
}
