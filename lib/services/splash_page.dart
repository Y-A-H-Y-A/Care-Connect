import 'dart:async';

import 'package:care_connect/pages/main_page.dart';
import 'package:care_connect/pages/messages_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom_style.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const String pageRout = 'splash_page';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String role = 'patient';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkRole();
  }

  void _checkRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      role = snap['role'];
    });

    if (role == 'patient') {
      navigateNext(const MainPage());
    } else if (role == 'doctor') {
      navigateNext(const MainPage());
    }
  }

  void navigateNext(Widget route) {
    Timer(Duration(microseconds: 500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => route),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo2.png',
            width: 321,
          ),
          const SizedBox(
            height: 30,
          ),
          const CircularProgressIndicator(
            backgroundColor: CustomColors.primaryNormalBlue,
          ),
        ],
      )),
    );
  }
}
