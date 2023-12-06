import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';
import 'package:shoe_shop/models/article_color_model/article_size_color_model.dart';
import 'package:shoe_shop/models/article_size_model/article_size_model.dart';
import 'package:shoe_shop/models/shoe_article_model/article_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/widgets/general_widgets/no_data_widget.dart';
import 'package:shoe_shop/views/screens/article_data_adding_screen.dart/data_adding_screen.dart';
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
          title: const Text("Home"),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.width8(context) * 2,
              right: SizeConfig.width8(context) * 2,
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
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.height8(context)),
                          child: ArticleCardWidget(
                            articleName:
                                articleModelList[articleIndex]!.articleNumber,
                            deleteFunction: () => _deleteArticle,
                            editFunction: () => _editArticle,
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
                      );
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }

  void _deleteArticle(String id, int length) {
    _firestoreController.deleteArticle(id);
    if (length == length--) {
      Fluttertoast.showToast(msg: "Article Deleted");
    }
  }

  void _editArticle(
    BuildContext context,
    ArticleModel shoeArticleModel,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DataAddingScreen(
          shoeArticleModel: shoeArticleModel,
        ),
      ),
    );
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
