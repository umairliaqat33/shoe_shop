import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';
import 'package:shoe_shop/models/article_color_model/article_size_color_model.dart';
import 'package:shoe_shop/models/article_size_model/article_size_model.dart';
import 'package:shoe_shop/models/shoe_article_model/article_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/home_screen/components/article_card_widget.dart';
import 'package:shoe_shop/views/screens/home_screen/components/article_dialog_widget.dart';

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
          title: const Text("Home"),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              // left: SizeConfig.width8(context) * 2,
              // right: SizeConfig.width8(context) * 2,
              top: SizeConfig.height8(context) * 2,
              bottom: SizeConfig.height20(context) * 2,
            ),
            child: StreamBuilder<List<ArticleModel?>>(
                stream: _firestoreController.getArticleStreamList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // if (snapshot.data!.isEmpty) {
                  //   return const Center(
                  //     child: NoDataWidget(
                  //       alertText: "No articles added yet!",
                  //     ),
                  //   );
                  // }
                  List<ArticleModel?>? articleModelList = [
                    ArticleModel(
                      articleNumber: "articleNumber",
                      articleSizeModelList: [
                        ArticleSizeModel(
                          title: "Size title",
                          colorAndQuantityList: [
                            ArticleSizeColorModel(
                              color: blueColor.value,
                              quantity: 10,
                              colorName: 'blue color',
                            ),
                          ],
                          salePrice: 1000,
                          purchasePrice: 900,
                        ),
                      ],
                    ),
                  ];
                  return ListView.builder(
                    itemCount: articleModelList.length,
                    itemBuilder: (
                      BuildContext context,
                      int articleIndex,
                    ) {
                      return MaterialButton(
                        onPressed: () => _onArticleClicked(
                          articleModelList[articleIndex]!.articleNumber,
                          articleModelList[articleIndex]!.articleSizeModelList,
                          context,
                        ),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding:
                                EdgeInsets.all(SizeConfig.height8(context)),
                            child: ArticleCardWidget(
                              articleNumber:
                                  articleModelList[articleIndex]!.articleNumber,
                              totalColors: _calculateTotalColors(
                                articleModelList[articleIndex]!
                                    .articleSizeModelList,
                              ),
                              totalQuantity: _calculateTotalQuantity(
                                articleModelList[articleIndex]!
                                    .articleSizeModelList,
                              ),
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

  void _onArticleClicked(
    String articleName,
    List<ArticleSizeModel> articleSizeModelList,
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ArticleDialogWidget(
            articleSizeModelList: articleSizeModelList,
            articleName: articleName,
          );
        });
  }

  int _calculateTotalQuantity(List<ArticleSizeModel> sizeModelList) {
    int totalQuantity = 0;
    for (var sizes in sizeModelList) {
      for (var colors in sizes.colorAndQuantityList) {
        totalQuantity = colors.quantity + totalQuantity;
      }
    }
    return totalQuantity;
  }

  int _calculateTotalColors(List<ArticleSizeModel> sizeModelList) {
    int totalColors = 0;
    for (var sizes in sizeModelList) {
      totalColors = sizes.colorAndQuantityList.length + totalColors;
    }
    return totalColors;
  }
}
