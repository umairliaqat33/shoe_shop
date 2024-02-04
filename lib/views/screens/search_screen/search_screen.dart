import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';
import 'package:shoe_shop/models/article_size_model/article_size_model.dart';
import 'package:shoe_shop/models/shoe_article_model/article_model.dart';
import 'package:shoe_shop/services/calculations.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/screens/article_data_adding_screen.dart/article_data_adding_screen.dart';
import 'package:shoe_shop/views/screens/home_screen/components/article_card_widget.dart';
import 'package:shoe_shop/views/screens/home_screen/components/article_dialog_widget.dart';
import 'package:shoe_shop/views/widgets/general_widgets/no_data_widget.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchFieldcontroller = TextEditingController();

  final FirestoreController _firestoreController = FirestoreController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          iconTheme: const IconThemeData(
            color: whiteColor,
          ),
          title: const Text(
            "Search",
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.width15(context) + 1,
                  right: SizeConfig.width15(context) + 1,
                ),
                child: TextFormFieldWidget(
                  controller: _searchFieldcontroller,
                  validator: (value) => Utils.simpleValidator(value),
                  label: "",
                  hintText: "Enter article name to search",
                  inputAction: TextInputAction.done,
                  autofocus: true,
                  suffixIcon: Icons.search,
                  suffixIconFunction: () {
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.height8(context),
              ),
              Container(
                height: SizeConfig.height20(context) * 32,
                padding: EdgeInsets.only(
                  bottom: SizeConfig.height20(context) * 4,
                ),
                child: StreamBuilder(
                  stream: _firestoreController.getSearchResultArticleStreamList(
                      _searchFieldcontroller.text),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: NoDataWidget(
                          alertText: "No match found!",
                        ),
                      );
                    }
                    List<ArticleModel?>? articleModelList = snapshot.data;
                    return ListView.builder(
                      itemCount: articleModelList!.length,
                      itemBuilder: (
                        BuildContext context,
                        int articleIndex,
                      ) {
                        return Padding(
                          padding:
                              EdgeInsets.only(top: SizeConfig.height8(context)),
                          child: MaterialButton(
                            onPressed: () => _onArticleClicked(
                              articleModelList[articleIndex]!.articleNumber,
                              articleModelList[articleIndex]!
                                  .articleSizeModelList,
                              articleModelList[articleIndex]!,
                              context,
                            ),
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(SizeConfig.height8(context)),
                                child: ArticleCardWidget(
                                  articleNumber: articleModelList[articleIndex]!
                                      .articleNumber,
                                  totalColors:
                                      Calculations.calculateTotalColors(
                                    articleModelList[articleIndex]!
                                        .articleSizeModelList,
                                  ),
                                  totalQuantity:
                                      Calculations.calculateTotalQuantity(
                                    articleModelList[articleIndex]!
                                        .articleSizeModelList,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onArticleClicked(
    String articleName,
    List<ArticleSizeModel> articleSizeModelList,
    ArticleModel articleModel,
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ArticleDialogWidget(
            articleSizeModelList: articleSizeModelList,
            articleName: articleName,
            editFunction: () => editArticle(
              context,
              articleModel,
            ),
            deleteFunction: () => _deleteArticle(
              articleName,
              context,
            ),
          );
        });
  }

  void editArticle(
    BuildContext context,
    ArticleModel articleModel,
  ) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ArticleDataAddingScreen(
          articleModel: articleModel,
        ),
      ),
    );
  }

  void _deleteArticle(
    String id,
    BuildContext context,
  ) {
    try {
      _firestoreController.deleteArticle(id);
      Fluttertoast.showToast(msg: "Article Deleted");
      Navigator.of(context).pop();
    } catch (e) {
      log("Article Deletion failed");
      log(e.toString());
      Fluttertoast.showToast(msg: "Article deletion failed");
    }
  }
}
