import 'package:care_connect/pages/login_page.dart';
import 'package:care_connect/services/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class AuthenticationWapper extends StatelessWidget {
  const AuthenticationWapper({Key? key}) : super(key: key);
  static const String pageRout = 'auth_wapper';

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const SplashPage();
    }
    return const Login();
  }
}
