import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialisez les contrôleurs de texte avec les données actuelles de l'utilisateur (si disponibles).
    // fullNameController.text = 'Nom complet actuel';
    // emailController.text = 'E-mail actuel';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(labelText: 'Nom complet'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Enregistrez les modifications du profil ici.
                  // Vous pouvez utiliser les valeurs des contrôleurs de texte (fullNameController.text et emailController.text).
                },
                child: Text('Enregistrer les modifications'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
