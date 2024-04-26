import 'package:flutter/material.dart';
// import 'dart:convert';

Future<void> showErrorDialog(BuildContext context, String errorMessage) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Erreur d\'authentification'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fermer'),
          ),
        ],
      );
    },
  );
}
