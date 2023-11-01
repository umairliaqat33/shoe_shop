import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/utils/enums.dart';
import 'package:shoe_shop/views/authentication_screens/login_screen.dart';
import 'package:shoe_shop/views/home_screen/components/article_card_widget.dart';

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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.width8(context) * 2,
              right: SizeConfig.width8(context) * 2,
              top: SizeConfig.height8(context) * 2,
            ),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.height8(context)),
                child: ArticleCardWidget(
                  articleName: "Article Numberd aytugdoiwekdewdt",
                  articleRate: 200,
                  articleQuantity: 20,
                  articleMade: ManufactureType.local.name,
                  sizeList: const [
                    "size 1",
                    "size 2",
                    "size 3",
                    "size 4",
                    'size 5',
                  ],
                  colorList: const [
                    10200,
                    40393,
                    028309,
                    028489,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
