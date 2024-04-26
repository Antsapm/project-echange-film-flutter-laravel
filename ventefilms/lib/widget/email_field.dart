import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  EmailField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: 'Adresse e-mail'),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Veuillez entrer votre adresse e-mail';
        }
        if (!isValidEmail(value!)) {
          return 'Adresse e-mail invalide';
        }
        return null;
      },
    );
  }

  bool isValidEmail(String email) {
    // Vous pouvez ajouter une logique de validation d'e-mail plus avancée ici
    final emailRegExp = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$'); // Expression régulière basique pour la validation d'e-mail
    return emailRegExp.hasMatch(email);
  }
}
