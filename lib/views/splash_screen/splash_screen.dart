import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/views/authentication_screens/login_screen.dart';
import 'package:shoe_shop/views/bottom_nav_bar/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _createSplash() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        log("I am in splash duration");
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          log('No user logged in');
        }
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                user == null ? const LoginScreen() : const BottomAppBarScreen(),
          ),
          (route) => false,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _createSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300.0,
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }
}