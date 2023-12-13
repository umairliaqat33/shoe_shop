// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';
import 'package:shoe_shop/models/article_size_model/article_size_model.dart';
import 'package:shoe_shop/models/shoe_article_model/article_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/exceptions.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/screens/article_data_adding_screen.dart/components/custom_article_size_widget.dart';
import 'package:shoe_shop/views/screens/article_data_adding_screen.dart/components/size_data_card.dart';
import 'package:shoe_shop/views/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:shoe_shop/views/screens/size_colors_adding_screen/size_colors_adding_screen.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';
import 'package:shoe_shop/views/widgets/general_widgets/no_data_widget.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class ArticleDataAddingScreen extends StatefulWidget {
  const ArticleDataAddingScreen({
    super.key,
    this.articleModel,
  });
  final ArticleModel? articleModel;

  @override
  State<ArticleDataAddingScreen> createState() =>
      _ArticleDataAddingScreenState();
}

class _ArticleDataAddingScreenState extends State<ArticleDataAddingScreen> {
  final TextEditingController _articleController = TextEditingController();
  final TextEditingController _customSizeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showLoader = false;
  String selectedItem = '';
  List<ArticleSizeModel> _sizeArticleModelList = [];
  List<String> sizeList = [
    'Select a Size',
    '15/19',
    '16/20',
    '21/25',
    '26/30',
    '31/36',
    '32/37',
    '36/41',
    'Custom Size',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.articleModel != null) {
      _setListValues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          elevation: 1,
          centerTitle: true,
          title: const Text(
            'Add Item Data',
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width12(context) + 4,
            right: SizeConfig.width12(context) + 4,
            top: SizeConfig.width12(context) + 4,
            bottom: SizeConfig.height20(context),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormFieldWidget(
                  controller: _articleController,
                  validator: (value) => Utils.simpleValidator(value),
                  label: 'Article Name',
                  hintText: "Enter your article name",
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  maxLength: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.height8(context),
                    bottom: SizeConfig.height8(context),
                  ),
                  child: const Text(
                    "Select a Size",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButton<String>(
                    underline: Container(),
                    value: sizeList.first,
                    onChanged: (String? value) => dropDownMenuOnChanged(value),
                    items:
                        sizeList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: _sizeArticleModelList.isEmpty
                      ? const Center(
                          child: NoDataWidget(
                            alertText: "No sizes selected yet!",
                          ),
                        )
                      : SizeDataCard(
                          sizeModelList: _sizeArticleModelList,
                          deleteSize: () => deleteArticleSetState(),
                          // editSize: () => editArticleSetState(),
                        ),
                ),
                showLoader
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: primaryColor,
                      ))
                    : Container(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.height15(context) + 1),
                        width: double.infinity,
                        child: RoundedButton(
                          buttonColor: primaryColor,
                          title: "Done",
                          onPressed: () => _uploadArticleData(),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dropDownMenuOnChanged(String? value) async {
    setState(() {
      selectedItem = value!;
    });
    FocusScope.of(context).unfocus();

    var result;
    if (selectedItem == 'Select a Size') {
      Fluttertoast.showToast(msg: "Please select a valid size");
      return;
    } else if (_checkIfColorExists(selectedItem)) {
      Fluttertoast.showToast(msg: "Size already exists");
    } else if (selectedItem != 'Custom Size') {
      result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SizeColorsAddingScreen(
            sizeName: selectedItem,
            articleSizeModelList: _sizeArticleModelList,
          ),
        ),
      );
    } else {
      var str = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return CustomArticleSizeWidget(
            customSizeController: _customSizeController,
          );
        },
      );
      selectedItem = _customSizeController.text;
      if (_checkIfColorExists(selectedItem)) {
        Fluttertoast.showToast(msg: "Size already exists");
      } else if (str!.isNotEmpty) {
        result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SizeColorsAddingScreen(
              sizeName: str,
              articleSizeModelList: _sizeArticleModelList,
            ),
          ),
        );
      }
    }
    if (result != null) {
      _sizeArticleModelList = result;
      setState(() {});
    }
    log(selectedItem);
  }

  void _uploadArticleData() {
    setState(() {
      showLoader = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        FirestoreController firestoreController = FirestoreController();
        if (_sizeArticleModelList.isEmpty) {
          Fluttertoast.showToast(msg: "Please select some articles first");
        } else {
          firestoreController.uploadArticle(
            ArticleModel(
              articleNumber: _articleController.text,
              articleSizeModelList: _sizeArticleModelList,
            ),
          );
          Fluttertoast.showToast(msg: "Article data uploaded successfully");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomNavigationBarScreen(),
            ),
            (route) => false,
          );
        }
      }
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.toString());
      Fluttertoast.showToast(msg: "Something went wrong please try again");
    }
    setState(() {
      showLoader = false;
    });
  }

  bool _checkIfColorExists(
    String value,
  ) {
    bool ifExist = false;
    for (var element in _sizeArticleModelList) {
      if (element.title == value) {
        ifExist = true;
      }
    }
    return ifExist;
  }

  void _setListValues() {
    setState(() {
      _articleController.text = widget.articleModel!.articleNumber;
      _sizeArticleModelList = widget.articleModel!.articleSizeModelList;
    });
  }

  void deleteArticleSetState() {
    setState(() {});
  }

  // void editArticleSetState() {
  //   setState(() {});
  // }
}
