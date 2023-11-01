import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';
import 'package:shoe_shop/models/shoe_article_model/shoe_article_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/authentication_screens/login_screen.dart';
import 'package:shoe_shop/views/home_screen/components/article_card_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final FirestoreController _firestoreController = FirestoreController();
  List<String> sizeList = [];
  List<int> colorList = [];

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
              bottom: SizeConfig.height20(context) * 2,
            ),
            child: StreamBuilder<List<ShoeArticleModel?>>(
                stream: _firestoreController.getArticleStreamList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Column(
                      children: [
                        const Text(
                          "No Articles available",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: lightGrey,
                          ),
                        ),
                        Image.asset('assets/waiting.png')
                      ],
                    );
                  }
                  List<ShoeArticleModel?>? dataList = snapshot.data;
                  return ListView.builder(
                    itemCount: dataList!.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.height8(context)),
                          child: ArticleCardWidget(
                            articleName: dataList[index]!.articleNumber,
                            articleRate: dataList[index]!.rate,
                            articleQuantity: dataList[index]!.quantity,
                            articleMade: dataList[index]!.manufactureType,
                            sizeList: dataList[index]!.sizeList,
                            colorList: dataList[index]!.colorList,
                            voidCallback: () => deleteArticle(
                                dataList[index]!.articleNumber,
                                dataList.length),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }

  void deleteArticle(String id, int length) {
    _firestoreController.deleteArticle(id);
    if (length == length--) {
      Fluttertoast.showToast(msg: "Article Deleted");
    }
  }
}
