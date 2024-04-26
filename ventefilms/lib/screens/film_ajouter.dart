import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ventefilms/widget/custum_drowpdown.dart';
import 'package:ventefilms/model/auth/film.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:io';

class CreateFilmForm extends StatefulWidget {
  @override
  _CreateFilmFormState createState() => _CreateFilmFormState();
}

class _CreateFilmFormState extends State<CreateFilmForm> {
  FilePickerResult? result;
  String? _videoName;
  PlatformFile? pickedVideo;
  File? videoToDisplay;

  Map<String, dynamic>? bigInfo;
  final _formKey = GlobalKey<FormState>();
  TextEditingController titreController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  File? file;
  File? image;
  // Ajoutez des contrôleurs pour d'autres champs
  String? selectedGenre;
  String? selectedType;
  String? selectedLangue;

// Liste des genres de film (vous pouvez les charger depuis votre API)
  List<dynamic>? genres;

  List<dynamic>? types;

  List<dynamic>? defItem = [
    {"id": "1", "label": "item1"},
    {"id": "2", "label": "item2"},
    {"id": "3", "label": "item3"},
  ];

  List<dynamic>? langues;

  @override
  void initState() {
    super.initState();
    Film.recuperationInfo(context).then((data) {
      setState(() {
        bigInfo = data;
        genres = bigInfo?['genre'];
        types = bigInfo?['type'];
        langues = bigInfo?['langue'];
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
            content: Text('Impossible d\'accèder au données d\'insertion.'),
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
        title: Text('Ajouter un film'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: fileController,
                      decoration: InputDecoration(
                        labelText: 'Film',
                        hintText: 'Aucun fichier sélectionné',
                      ),
                      enabled: false, // Désactiver l'édition du champ
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Ce champ ne peut pas être vide';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // pickFile()
                      // FilePickerResult? result =
                      //     await FilePicker.platform.pickFiles();

                      // if (result != null) {
                      //   if (result.files.isNotEmpty) {
                      //     String? filePath = result.files.single.path;
                      //     if (filePath != null) {
                      //       File file = File(filePath);
                      //       String? fileName = file.path.split('/').last;
                      //       if (fileName != "") {
                      //         // Mettez à jour le contrôleur du champ "Fichier"
                      //         fileController.text = fileName;

                      //         // Mettez à jour le contrôleur du champ "Titre"
                      //         titreController.text = fileName;
                      //       }
                      //     }
                      //   }
                      // }
                    },
                    child: Text('Choisir un fichier'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: titreController,
                decoration: InputDecoration(
                  labelText: 'Titre',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ce champ ne peut pas être vide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomDropdown(
                value: selectedType,
                label: "Type",
                placeholder: "Choisir un type",
                items: types ?? defItem,
                onChanged: (value) {
                  setState(() {
                    selectedType = value;
                  });
                },
              ),
              SizedBox(height: 20),
              CustomDropdown(
                value: selectedGenre,
                label: "Genre",
                items: genres ?? defItem,
                placeholder: "Selectionner le genre du film",
                onChanged: (value) {
                  setState(() {
                    selectedGenre = value;
                  });
                },
              ),
              SizedBox(height: 20),
              CustomDropdown(
                value: selectedLangue,
                label: "Langue",
                items: langues ?? defItem,
                placeholder: "Ajouter un langue",
                onChanged: (value) {
                  setState(() {
                    selectedLangue = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: imageController,
                      decoration: InputDecoration(
                        labelText: 'Postaire',
                        hintText: 'Aucun image sélectionné',
                      ),
                      enabled: false, // Désactiver l'édition du champ
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Ce champ ne peut pas être vide';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? imageresult =
                          await FilePicker.platform.pickFiles();
                      if (imageresult != null) {
                        if (imageresult.files.isNotEmpty) {
                          String? imagePath = imageresult.files.single.path;
                          if (imagePath != null) {
                            File image = File(imagePath);
                            String? imageName = image.path.split('/').last;
                            if (imageName != "") {
                              imageController.text = imageName;
                            }
                          }
                        }
                      }
                    },
                    child: Text('Choisir une image'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    // Récupérer les données du formulaire
                    String titre = titreController.text;
                    String type = selectedType ?? "1";
                    String genre = selectedGenre ?? "1";
                    String langue = selectedLangue ?? "1";
                    String lien = "";
                    String photo = imageController.text;
                    String duration = "";
                    // Créer un objet de modèle de film
                    Film film = Film(
                      titre: titre,
                      type: type,
                      genre: genre,
                      langue: langue,
                      file: file,
                      image: image,
                      lien: lien,
                      photo: photo,
                      duration: duration,
                    );

                    // // Appeler une fonction pour soumettre le film
                    Film.submitFilm(film);

                    // Effacer les contrôleurs après la soumission
                    titreController.clear();
                    fileController.clear();
                    imageController.clear();
                    selectedType = null;
                    selectedGenre = null;
                    selectedLangue = null;
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Erreur'),
                          content: Text('Impossible de valider le formulaire.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Ferme la boîte de dialogue
                              },
                              child: Text('Fermer'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Enregistrer'),
              ),
            ],
          ),

          // Votre contenu ici
        ),
      ),
    );
  }

  void pickFile() async {
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
      );
      if (result != null) {
        _videoName = result!.files.first.name;
        pickedVideo = result!.files.first;
        videoToDisplay = File(pickedVideo!.path.toString());
        fileController.text = _videoName.toString();
        print("Video name : $_videoName");
      }
    } catch (e) {
      print(e);
    }
    // FilePickerResult? result = await FilePicker.platform.pickFiles();

    // if (result != null) {
    //   if (result.files.isNotEmpty) {
    //     String? filePath = result.files.single.path;
    //     if (filePath != null) {
    //       File file = File(filePath);
    //       String? fileName = file.path.split('/').last;
    //       if (fileName != "") {
    //         fileController.text = fileName;
    //       }
    //     }
    //   }
    // }
  }
}
