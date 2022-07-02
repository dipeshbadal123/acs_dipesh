// ignore_for_file: must_be_immutable

import 'package:advance_cyber_security/view/home/home_page.dart';
import 'package:advance_cyber_security/view/password/change_password.dart';
import 'package:advance_cyber_security/view/splash/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authunticate extends StatelessWidget {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Authunticate({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (firebaseAuth.currentUser != null) {
      return HomePage();
    } else {
      return const SplashScreen();
    }
  }
}
