import 'package:flutter/material.dart';

import 'package:ventefilms/widget/email_field.dart';
import 'package:ventefilms/config.dart';

import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
// import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mot de passe oublié'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Entrez votre adresse e-mail pour réinitialiser votre mot de passe.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            EmailField(controller: _emailController),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                recupPassWord(
                  _emailController.text,
                );
              },
              child: Text('Réinitialiser le mot de passe'),
            ),
          ],
        ),
      ),
    );
  }

  String generateRandomCode() {
    final random = Random();
    final code = random.nextInt(9000000) + 1000000;
    return code.toString();
  }

  void sendEmail(String userEmail, String code) async {
    final smtpServer = gmail(AppConfig.mailMy, AppConfig.passMy);

    final message = Message()
      ..from = Address(AppConfig.mailMy, AppConfig.passMy)
      ..recipients.add(userEmail)
      ..subject = 'Code de récupération de mot de passe'
      ..text = 'Votre code de récupération est : $code';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> recupPassWord(String email) async {
    final code = generateRandomCode();
    sendEmail(email, code);
  }

  Future<bool> sendCode(String code) async {
    final apiUrl = Uri.parse(
        'http://${AppConfig.serverIP}:${AppConfig.serverPort}/recovery');

    final response = await http.post(
      apiUrl,
      body: {'recovery_code': code},
    );

    if (response.statusCode == 200) {
      // Le code de récupération est valide
      return true;
    } else {
      // Le code de récupération est invalide
      return false;
    }
  }
}
