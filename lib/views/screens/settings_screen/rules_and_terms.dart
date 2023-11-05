import 'package:flutter/material.dart';

class RulesAndTermsScreen extends StatelessWidget {
  const RulesAndTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Roles and terms"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Rules and terms screen",
        ),
      ),
    );
  }
}
