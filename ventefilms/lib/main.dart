// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ventefilms/routes.dart';
import 'package:ventefilms/config.dart';
import 'package:ventefilms/model/auth/authentification.dart';

class TestPage extends StatefulWidget {
  @override
  createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String apiResult = 'Chargement...';

  Future<String> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://${AppConfig.serverIP}:${AppConfig.serverPort}/api/test'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (mounted) {
        setState(() {
          apiResult = data['message'];
        });
      }
    } else {
      if (mounted) {
        setState(() {
          apiResult = 'Échec de la requête API';
        });
      }
    }
    return apiResult;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String direction = '/';
  Future<String> controLogin() async {
    final isAuthenticated = await Authentication.authenticated();

    if (isAuthenticated) {
      direction = '/home';
    } else {
      direction = '/login';
    }
    return direction;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test de l\'API Laravel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Résultat de API : ${apiResult}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              apiResult,
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () async {
                final direction = await controLogin();
                Navigator.pushNamed(context, direction);
              },
              child: Text('Se Connecter'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context,
                    '/register'); // Rediriger vers la page d'inscription
              },
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() async {
  configureRoutes();
  WidgetsFlutterBinding.ensureInitialized();

  Future<String> controAuth() async {
    final isAuthenticated = await Authentication.authenticated();

    if (isAuthenticated) {
      return '/home';
    } else {
      return '/login';
    }
  }

  runApp(
    FutureBuilder<String>(
      future: controAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            initialRoute: snapshot.data,
            routes: AppRoutes.routes,
          );
        } else {
          return CircularProgressIndicator(); // Affichez une indication de chargement tant que le contrôle d'authentification est en cours.
        }
      },
    ),
  );
}
