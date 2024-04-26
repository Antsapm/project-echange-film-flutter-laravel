import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:ventefilms/model/auth/authentification.dart';
// import 'package:ventefilms/widget/email_field.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  Map<String, dynamic>? userData;
  final GlobalKey<FormState> profilChangeKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  int selectedAvatarIndex = -1; // Index de l'avatar pré-défini sélectionné

  ImageProvider<Object>? _picture = AssetImage('lib/asset/images/aho.jpg');
  File? _image;
  List<ImageProvider<Object>> predefinedAvatars = [
    AssetImage('lib/asset/images/avatar1.jpg'),
    AssetImage('lib/asset/images/avatar2.jpg'),
    AssetImage('lib/asset/images/avatar3.jpg'),
    AssetImage('lib/asset/images/avatar4.jpg'),
    AssetImage('lib/asset/images/avatar5.jpg'),
    AssetImage('lib/asset/images/avatar6.jpg'),
    AssetImage('lib/asset/images/avatar7.jpg'),
    AssetImage('lib/asset/images/avatar8.jpg'),
    // AssetImage('lib/asset/images/avatar9.jpg'),
    // ...
  ];
  // List<String> predefinedAvatars = [
  //   'lib/asset/images/avatar1.jpg',
  //   'lib/asset/images/avatar2.jpg',
  //   'lib/asset/images/avatar3.jpg',
  //   'lib/asset/images/avatar4.jpg',
  //   'lib/asset/images/avatar5.jpg',
  //   'lib/asset/images/avatar6.jpg',
  //   'lib/asset/images/avatar7.jpg',
  //   'lib/asset/images/avatar8.jpg',
  // ];

  // ...
  @override
  void initState() {
    super.initState();
    Authentication.fetchUserData().then((data) {
      setState(() {
        userData = data;
        _picture = AssetImage(userData != null
            ? userData!['photo'] != null
                ? userData!['photo'].toString()
                : userData!['photo'].toString()
            : 'lib/asset/images/aho.jpg');
        emailController.text = userData != null
            ? userData!['email'] != null
                ? userData!['email'].toString()
                : userData!['email'].toString()
            : '';
        fullNameController.text = userData != null
            ? userData!['name'] != null
                ? userData!['name'].toString()
                : userData!['name'].toString()
            : '';
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
        title: Text('Modifier le Profil'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height:
                      10, // Espacement entre la photo de profil et le formulaire
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _picture,
                ),
                SizedBox(
                  height:
                      10, // Espacement entre la photo de profil et les avatars pré-définis
                ),
                Text(
                  'Cliquez sur la photo ci-dessus pour changer votre photo de profil.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: 200, // Largeur du conteneur
                  height: 200, // Hauteur du conteneur
                  padding: EdgeInsets.symmetric(
                      vertical:
                          20.0), // Espacement vertical autour des avatars pré-définis
                  child: Wrap(
                    alignment:
                        WrapAlignment.center, // Centrer les avatars pré-définis
                    spacing:
                        15.0, // Espacement horizontal entre les avatars pré-définis
                    runSpacing:
                        20.0, // Espacement vertical entre les lignes d'avatars
                    children: List.generate(
                        predefinedAvatars.length +
                            1, // +1 pour le GestureDetector
                        (index) {
                      if (index == predefinedAvatars.length) {
                        return GestureDetector(
                          onTap: () {
                            _requestGalleryPermissionAndSelectImage();
                          },
                          child: _image == null
                              ? Icon(Icons.add_a_photo,
                                  size: 35.0) // Icône par défaut
                              : Image.file(_image!, width: 100, height: 100),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _picture = predefinedAvatars[index];
                            });
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: predefinedAvatars[index],
                          ),
                        );
                      }
                    }),
                  ),
                ),
                SizedBox(
                  height:
                      10, // Espacement entre les avatars pré-définis et le formulaire
                ),
                TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Nom complet',
                    hintText: 'Entrez votre nom complet',
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'Entrez votre adresse e-mail',
                  ),
                ),
                SizedBox(
                  height:
                      10, // Espacement entre les avatars pré-définis et le formulaire
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Enregistrer'),
                          content: Text(
                              'Êtes-vous sûr de enregistrer les modifications ?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Annuler'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Ferme la boîte de dialogue
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Enregistrer'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                String newEmail = emailController.text;
                                String newFullName = fullNameController.text;

                                // Si une nouvelle image a été sélectionnée, vous pouvez également envoyer son chemin
                                String imagePath = _picture is AssetImage
                                    ? (_picture as AssetImage).assetName
                                    : (_picture as NetworkImage).url;

                                // Envoyez les données au backend (c'est ici que vous effectuez votre logique de communication avec le serveur)
                                Future<String> alert =
                                    Authentication.updateProfil(
                                        newFullName, newEmail, imagePath);

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Succès'),
                                      content: Text(
                                          "Modification enregistrée avec succès"),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.pushNamed(
                                                context, '/profil');
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );

                                // Navigator.pushNamed(context, '/profil');
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Enregistrer les modifications'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _requestGalleryPermissionAndSelectImage() async {
    var status = await Permission.photos.status;

    if (!status.isGranted) {
      final result = await Permission.photos.request();
      if (result.isGranted) {
        // L'autorisation a été accordée, vous pouvez maintenant appeler _selectImage().
        _selectImage();
      } else {
        // L'autorisation a été refusée par l'utilisateur, vous pouvez gérer cela en conséquence.
        // Affichez un message à l'utilisateur ou effectuez d'autres actions appropriées.
      }
    } else {
      // L'autorisation était déjà accordée, vous pouvez appeler _selectImage().
      _selectImage();
    }
  }
}
