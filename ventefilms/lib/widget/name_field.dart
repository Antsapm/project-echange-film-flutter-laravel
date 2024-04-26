import 'package:flutter/material.dart';

class nameField extends StatelessWidget {
  final TextEditingController controller;
  nameField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: 'Nom complet'),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Veuillez entrer votre nom complet';
        }
        return null;
      },
    );
  }
}
