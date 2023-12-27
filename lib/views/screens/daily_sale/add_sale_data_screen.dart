// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';
import 'package:shoe_shop/models/article_color_model/article_size_color_model.dart';
import 'package:shoe_shop/models/article_size_model/article_size_model.dart';
import 'package:shoe_shop/models/shoe_article_model/article_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:shoe_shop/views/screens/home_screen/components/color_container_widget.dart';
import 'package:shoe_shop/views/widgets/alerts/size_sales_data_adding_alert.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';
import 'package:shoe_shop/views/widgets/general_widgets/no_data_widget.dart';

class AddSaleDataScreen extends StatefulWidget {
  const AddSaleDataScreen({super.key});

  @override
  State<AddSaleDataScreen> createState() => _AddSaleDataScreenState();
}

class _AddSaleDataScreenState extends State<AddSaleDataScreen> {
  final FirestoreController _firestoreController = FirestoreController();
  final List<String> _articleDropDownList = ['Select an article'];
  List<ArticleSizeModel> _articlSizeModelList = [];
  final List<String> _articlSizeDropDownList = ['Select a size'];
  final List<ArticleSizeModel> _soldSizes = [];
  String _selectedArticle = '';
  String _selectedSize = '';

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
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavigationBarScreen(
                                    screenIndex: 2,
                                  ),
                                ),
                                (route) => false,
                              );
                            },
                            title: 'Add articles',
                          ),
                        ],
                      ),
                    );
                  }
                  List<ArticleModel?>? articleModelList = snapshot.data;
                  for (int i = 0; i < articleModelList!.length; i++) {
                    _articleDropDownList
                        .add(articleModelList[i]!.articleNumber);
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButton<String>(
                          underline: Container(),
                          value: _articleDropDownList.first,
                          onChanged: (String? value) => _dropDownButtonOnTap(
                            value,
                            _checkArticleModel(value!, articleModelList),
                          ),
                          items: _articleDropDownList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Visibility(
                        visible: _selectedArticle.isNotEmpty,
                        child: Column(
                          children: [
                            const Text(
                              "Selected Article: ",
                              style: TextStyle(
                                fontSize: 12,
                                color: lightGrey,
                              ),
                            ),
                            Text(
                              _selectedArticle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
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
                    value: _articlSizeDropDownList.first,
                    onChanged: (String? value) =>
                        _articleSizeDropdownClicked(value),
                    items: _articlSizeDropDownList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.height8(context),
              ),
              Visibility(
                visible: _soldSizes.isNotEmpty,
                child: SizedBox(
                  height: SizeConfig.height20(context) * 17,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _soldSizes.length,
                      itemBuilder: (BuildContext context, int sizeListIndex) {
                        return GestureDetector(
                          onTap: () => _onSizeCardTap(
                            _soldSizes[sizeListIndex].title,
                            _soldSizes[sizeListIndex].colorAndQuantityList,
                          ),
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.width5(context)),
                                  child: Text(
                                    _soldSizes[sizeListIndex].title,
                                    style: TextStyle(
                                      fontSize: SizeConfig.font20(context),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.width20(context) * 8.22,
                                  height: SizeConfig.height20(context) * 2,
                                  child: ListView.builder(
                                    reverse: true,
                                    itemCount: _soldSizes[sizeListIndex]
                                        .colorAndQuantityList
                                        .length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context,
                                        int colorListIndex) {
                                      return ColorContainerWidget(
                                        color: Color(
                                          _soldSizes[sizeListIndex]
                                              .colorAndQuantityList[
                                                  colorListIndex]
                                              .color,
                                        ),
                                        quantity: _soldSizes[sizeListIndex]
                                            .colorAndQuantityList[
                                                colorListIndex]
                                            .quantity,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
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
    ArticleModel? articleModel,
  ) {
    if (articleModel != null) {
      _articlSizeModelList.clear();
      _articlSizeDropDownList.clear();
      _soldSizes.clear();
      setState(() {
        _selectedArticle = value!;
        _articlSizeModelList = articleModel.articleSizeModelList;
        _setArticleNames();
      });
      log(_selectedArticle);
    } else {
      Fluttertoast.showToast(msg: "Please select a valid article");
    }
  }

  void _setArticleNames() {
    _articlSizeDropDownList.add('Select a size');
    for (int i = 0; i < _articlSizeModelList.length; i++) {
      _articlSizeDropDownList.add(_articlSizeModelList[i].title);
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

  void _articleSizeDropdownClicked(String? value) {
    if (value != _articlSizeDropDownList.first) {
      setState(() {
        _selectedSize = value!;
      });
      log(_selectedSize);
      _addSoldSizeInList(_selectedSize);
    } else {
      Fluttertoast.showToast(msg: "Please select a valid size");
    }
  }

  void _addSoldSizeInList(String selectedSize) {
    for (int i = 0; i < _articlSizeModelList.length; i++) {
      if (_articlSizeModelList[i].title == selectedSize &&
          !_soldSizes.contains(_articlSizeModelList[i])) {
        _soldSizes.add(_articlSizeModelList[i]);
      }
    }
  }

  Future<void> _onSizeCardTap(
    String sizeName,
    List<ArticleSizeColorModel> colorModelList,
  ) async {
    final List<TextEditingController> colorQuantityListControllers = [];
    for (int i = 0; i < colorModelList.length; i++) {
      colorQuantityListControllers.add(TextEditingController());
      colorQuantityListControllers[i].text =
          colorModelList[i].quantity.toString();
    }
    var str = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SizeSalesDataAddingAlert(
          onDoneTap: () {},
          context: context,
          description: 'Please set sold quantities for every color',
          headingText: sizeName,
          colorModelList: colorModelList,
          quantityControllerList: colorQuantityListControllers,
        );
      },
    );
    log(str.toString());
  }
}