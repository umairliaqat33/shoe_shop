import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';
import 'package:shoe_shop/models/shoe_article_model/shoe_article_model.dart';
import 'package:shoe_shop/utils/assets.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/authentication_screens/login_screen.dart';
import 'package:shoe_shop/views/screens/data_adding_screen.dart/data_adding_screen.dart';
import 'package:shoe_shop/views/screens/home_screen/components/article_card_widget.dart';

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
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "No Articles found",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          Image.asset(
                            Assets.emptyScreenImage,
                            color: lightGrey,
                            height: SizeConfig.height20(context) * 8,
                          )
                        ],
                      ),
                    );
                  }
                  List<ShoeArticleModel?>? shoeArticleModelList = snapshot.data;
                  return ListView.builder(
                    itemCount: shoeArticleModelList!.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.height8(context)),
                          child: ArticleCardWidget(
                            articleName:
                                shoeArticleModelList[index]!.articleNumber,
                            articleRate: shoeArticleModelList[index]!.rate,
                            articleQuantity:
                                shoeArticleModelList[index]!.quantity,
                            articleMade:
                                shoeArticleModelList[index]!.manufactureType,
                            sizeList: shoeArticleModelList[index]!.sizeList,
                            colorList: shoeArticleModelList[index]!.colorList,
                            deleteFunction: () => deleteArticle(
                                shoeArticleModelList[index]!.articleNumber,
                                shoeArticleModelList.length),
                            editFunction: () => editArticle(
                              context,
                              shoeArticleModelList[index]!,
                            ),
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

  void editArticle(
    BuildContext context,
    ShoeArticleModel shoeArticleModel,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DataAddingScreen(
          shoeArticleModel: shoeArticleModel,
        ),
      ),
    );
  }
}
