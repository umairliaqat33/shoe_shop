import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/views/authentication_screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Noor Kids"),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              icon: const Icon(
                Icons.power_settings_new,
              ),
            ),
          ],
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
                // SingleChildScrollView(
                //   child: Row(
                //     children: [
                //       CategoryTile(),
                //     ],
                //   ),
                // ),
                SingleChildScrollView(
                  child: Column(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
