import 'package:flutter/material.dart';

import 'src/auth/login_page.dart';
import 'src/auth/register_page.dart';
import 'src/auth/forgotPassword.dart';
import 'package:ventefilms/screens/home_page.dart';
import 'package:ventefilms/screens/profil_page.dart';
import 'package:ventefilms/screens/film_ajouter.dart';
import 'package:ventefilms/screens/changeProfil_page.dart';
import 'main.dart';

class AppRoutes {
  static final initialRoute = '/';
  static final routes = {
    '/': (context) => TestPage(),
    '/login': (context) => LoginPage(),
    '/register': (context) => RegisterPage(),
    '/forgotpass': (context) => ForgotPasswordPage(),
    '/profil': (context) => ProfilePage(),
    '/home': (context) => HomePage(),
    '/profil/change': (context) => ProfileEditPage(),
    '/film/ajouter': (context) => CreateFilmForm(),
  };
}

void configureRoutes() {
  runApp(MaterialApp(
    initialRoute: AppRoutes.initialRoute,
    routes: AppRoutes.routes,
  ));
}
