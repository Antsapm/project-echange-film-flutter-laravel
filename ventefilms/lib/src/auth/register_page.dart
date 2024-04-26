import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:ventefilms/widget/name_field.dart';
import 'package:ventefilms/widget/password_field.dart';
import 'package:ventefilms/widget/email_field.dart';
import 'package:http/http.dart' as http;
// import 'package:ventefilms/model/auth/authentification.dart';
import 'package:ventefilms/config.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  Future<void> submitForm(
      String fullName, String email, String password) async {
    final url = Uri.parse(
        'http://${AppConfig.serverIP}:${AppConfig.serverPort}/api/register'); // Remplacez par l'URL de votre backend

    final response = await http.post(
      url,
      body: {
        'fullName': fullName,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // La requête a réussi

      final responseData = json.decode(response.body);
      String message = responseData['message'];
      print(message);
      String apiToken = responseData['token'];

      // Stockage du token localement
      // await Authentication.saveToken(apiToken);
      Navigator.pushNamed(context, '/register');
    } else {
      // La requête a échoué
      print('Échec de l\'inscription : ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              nameField(controller: _fullNameController),
              EmailField(controller: _emailController),
              PasswordField(controller: _passwordController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    submitForm(
                      _fullNameController.text,
                      _emailController.text,
                      _passwordController.text,
                    );
                  }
                },
                child: Text('S\'inscrire'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
