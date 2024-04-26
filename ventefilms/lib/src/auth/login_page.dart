import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:ventefilms/config.dart';

import 'package:http/http.dart' as http;
import 'package:ventefilms/model/auth/authentification.dart';

import 'package:ventefilms/widget/password_field.dart';
import 'package:ventefilms/widget/email_field.dart';
import 'package:ventefilms/widget/show_alert.dart';

import 'package:ventefilms/screens/home_page.dart';

import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

  // afficheLogin
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              EmailField(controller: _emailController),
              PasswordField(controller: _passwordController),
              RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  text: 'Mot de passe oublié ?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Cliquez ici',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/forgotpass');
                        },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    loginUser(
                      _emailController.text,
                      _passwordController.text,
                    );
                  }
                },
                child: Text('Se connecter'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text("S'inscrire"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(
          'http://${AppConfig.serverIP}:${AppConfig.serverPort}/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Authentification réussie
      final responseData = json.decode(response.body);
      final dataTokens = responseData['tokens'];
      String apiToken = dataTokens['token'];
      int api = dataTokens['user_id'];

      await Authentication.saveToken(apiToken, api);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      final errorMessage = json.decode(response.body)['error'];
      showErrorDialog(context, errorMessage);
    }
  }
}
