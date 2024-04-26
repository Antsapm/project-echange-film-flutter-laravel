import 'package:flutter/material.dart';
import 'package:ventefilms/model/auth/authentification.dart';
import 'package:ventefilms/src/auth/login_page.dart';
import 'package:ventefilms/model/auth/film.dart';
// import 'package:ventefilms/widget/imageBox.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic>? film;

  void openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  void initState() {
    super.initState();
    Film.recuperationFilm().then((data) {
      setState(() {
        film = data;
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
            content: Text('Impossible d\'accèder au données des films.'),
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     key: _scaffoldKey,
  //     appBar: AppBar(
  //       title: Text('Page d\'Accueil'),
  //       automaticallyImplyLeading: false,
  //       actions: [
  //         IconButton(
  //           icon: Icon(Icons.more_vert),
  //           onPressed: openDrawer,
  //         ),
  //       ],
  //     ),
  //     endDrawer: Drawer(
  //       child: ListView(
  //         padding: EdgeInsets.zero,
  //         children: [
  //           DrawerHeader(
  //             decoration: BoxDecoration(
  //               color: Colors.blue,
  //             ),
  //             child: Text('XenoPhobe'),
  //           ),
  //           ListTile(
  //             title: Text('Profil'),
  //             onTap: () {
  //               Navigator.pushNamed(context, '/profil');
  //             },
  //           ),
  //           ListTile(
  //             title: Text('Se déconnecter'),
  //             onTap: () {
  //               showDialog(
  //                 context: context,
  //                 builder: (BuildContext context) {
  //                   return AlertDialog(
  //                     title: Text('Déconnexion'),
  //                     content:
  //                         Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
  //                     actions: <Widget>[
  //                       TextButton(
  //                         child: Text('Annuler'),
  //                         onPressed: () {
  //                           Navigator.of(context)
  //                               .pop(); // Ferme la boîte de dialogue
  //                           Navigator.of(context).pop();
  //                         },
  //                       ),
  //                       TextButton(
  //                         child: Text('Déconnexion'),
  //                         onPressed: () {
  //                           Navigator.of(context).pop();
  //                           Navigator.of(context).pop();
  //                           Authentication.logoutUser(context);
  //                           if (Authentication.isAuthenticated) {
  //                             Navigator.of(context).pushReplacement(
  //                                 MaterialPageRoute(
  //                                     builder: (context) => LoginPage()));
  //                           }
  //                         },
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               );
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //     body: CustomScrollView(
  //       slivers: [
  //         SliverAppBar(
  //           expandedHeight: 200.0,
  //           automaticallyImplyLeading: false,
  //           flexibleSpace: FlexibleSpaceBar(
  //             title: Text(
  //                 'Bienvenue sur Xenophobe, une application associer à Xenophobe.com'),
  //           ),
  //         ),
  //         SliverToBoxAdapter(
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Card(
  //               child: ListTile(
  //                 leading: Icon(Icons.search),
  //                 title: TextField(
  //                   decoration: InputDecoration(
  //                     hintText: 'Recherche...',
  //                     border: InputBorder.none,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Page d\'Accueil'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: openDrawer,
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('XenoPhobe'),
            ),
            ListTile(
              title: Text('Profil'),
              onTap: () {
                Navigator.pushNamed(context, '/profil');
              },
            ),
            ListTile(
              title: Text('Se déconnecter'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Déconnexion'),
                      content:
                          Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Annuler'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Déconnexion'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Authentication.logoutUser(context);
                            if (Authentication.isAuthenticated) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                  'Bienvenue sur Xenophobe, une application associée à Xenophobe.com'),
            ),
          ),
          SliverAppBar(
            expandedHeight: 150.0,
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.search),
                      title: TextField(
                        controller:
                            _searchController, // Utilisez le contrôleur pour la recherche
                        onChanged: (text) {
                          Film.recuperationFilmTitled(_searchController.text)
                              .then((data) {
                            setState(() {
                              film = data;
                            });
                          }).catchError((error, stackTrace) {
                            // Gérer l'erreur, afficher une boîte de dialogue d'alerte, etc.
                            print("Erreur : $error"); // Affichez l'erreur
                            print(
                                "Stack trace : $stackTrace"); // Affichez le stack trace
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Erreur'),
                                  content: Text(
                                      'Impossible d\'accèder au données des films.'),
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
                          });
                          // Logique de recherche en temps réel ici
                          // Vous pouvez mettre à jour la liste des films en fonction du texte de recherche
                          // film = filterFilmBySearchText(text);
                          // setState(() {}); // Assurez-vous d'appeler setState pour mettre à jour l'interface utilisateur
                        },
                        decoration: InputDecoration(
                          hintText: 'Recherche...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (film != null) {
                  if (film!.isNotEmpty) {
                    return ListTile(
                      leading: Image(
                          image: AssetImage(film![index]['photo'].toString())),
                      title: Text(film![index]['titre'].toString()),
                      subtitle: Text(film![index]['qualite'].toString()),
                    );
                  } else {
                    return ListTile(
                      title: Text('Aucun film trouvé'),
                    );
                  }
                } else {
                  return ListTile(
                    title: Text('Aucun film trouvé'),
                  );
                }
              },
              childCount: (film != null && film!.isNotEmpty) ? film!.length : 1,
            ),
          )
        ],
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: await Authentication.authenticated() ? HomePage() : LoginPage(),
  ));
}
