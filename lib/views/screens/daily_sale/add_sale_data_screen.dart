// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';
import 'package:shoe_shop/models/article_size_model/article_size_model.dart';
import 'package:shoe_shop/models/shoe_article_model/article_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';
import 'package:shoe_shop/views/widgets/general_widgets/no_data_widget.dart';

class AddSaleDataScreen extends StatefulWidget {
  const AddSaleDataScreen({super.key});

  @override
  State<AddSaleDataScreen> createState() => _AddSaleDataScreenState();
}

class _AddSaleDataScreenState extends State<AddSaleDataScreen> {
  final List<String> articleList = ['Select an article'];
  final FirestoreController _firestoreController = FirestoreController();
  String _selectedArticle = '';
  List<ArticleSizeModel> _articlSizeModelList = [];
  final List<String> _articlSizeList = ['Select a size'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          elevation: 1,
          centerTitle: true,
          title: const Text(
            "Add sale data",
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.height8(context),
            left: SizeConfig.width15(context) + 1,
            right: SizeConfig.width15(context) + 1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.height8(context),
              ),
              StreamBuilder<List<ArticleModel?>>(
                  stream: _firestoreController.getArticleStreamList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            const NoDataWidget(
                              alertText: "Add some Articles first",
                            ),
                            SizedBox(
                              height: SizeConfig.height8(context),
                            ),
                            RoundedButton(
                              buttonColor: primaryColor,
                              onPressed: () {},
                              title: 'Go to home and add articles',
                            ),
                          ],
                        ),
                      );
                    }
                    List<ArticleModel?>? articleModelList = snapshot.data;
                    for (int i = 0; i < articleModelList!.length; i++) {
                      articleList.add(articleModelList[i]!.articleNumber);
                    }
                    return Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton<String>(
                        underline: Container(),
                        value: articleList.first,
                        onChanged: (String? value) => _dropDownButtonOnTap(
                          value,
                          _checkArticleModel(value!, articleModelList)!,
                        ),
                        items: articleList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    );
                  }),
              SizedBox(
                height: SizeConfig.height8(context),
              ),
              Visibility(
                visible: _articlSizeModelList.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButton<String>(
                    underline: Container(),
                    value: _articlSizeList.first,
                    onChanged: (String? value) =>
                        _articleSizeDropdownClicked(value),
                    items: _articlSizeList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _dropDownButtonOnTap(
    String? value,
    ArticleModel articleModel,
  ) {
    setState(() {
      _selectedArticle = value!;
      _articlSizeModelList = articleModel.articleSizeModelList;
      _setArticleNames();
    });
    log(_selectedArticle);
  }

  void _setArticleNames() {
    for (int i = 0; i < _articlSizeModelList.length; i++) {
      _articlSizeList.add(_articlSizeModelList[i].title);
    }
  }

  ArticleModel? _checkArticleModel(
    String value,
    List<ArticleModel?> articleModelList,
  ) {
    ArticleModel? articleModel;
    for (int i = 0; i < articleModelList.length; i++) {
      if (articleModelList[i]!.articleNumber == value) {
        articleModel = articleModelList[i];
      }
    }
    return articleModel;
  }

  void _articleSizeDropdownClicked(String? value) {}
}
