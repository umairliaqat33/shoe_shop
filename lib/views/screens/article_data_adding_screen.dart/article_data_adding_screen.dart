// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_size_model/article_size_model.dart';
import 'package:shoe_shop/models/shoe_article_model/article_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/screens/article_data_adding_screen.dart/components/custom_article_size_widget.dart';
import 'package:shoe_shop/views/screens/article_data_adding_screen.dart/components/size_data_card.dart';
import 'package:shoe_shop/views/screens/size_colors_adding_screen/size_colors_adding_screen.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';
import 'package:shoe_shop/views/widgets/general_widgets/no_data_widget.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class ArticleDataAddingScreen extends StatefulWidget {
  const ArticleDataAddingScreen({
    super.key,
    this.shoeArticleModel,
    this.list,
  });
  final ArticleModel? shoeArticleModel;
  final List<ArticleSizeModel>? list;

  @override
  State<ArticleDataAddingScreen> createState() =>
      _ArticleDataAddingScreenState();
}

class _ArticleDataAddingScreenState extends State<ArticleDataAddingScreen> {
  final TextEditingController _articleController = TextEditingController();
  final TextEditingController _customSizeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
  String selectedItem = '';
  List<ArticleSizeModel> _sizeArticleModelList = [];

  @override
  void initState() {
    super.initState();
    // if (widget.shoeArticleModel != null) {
    //   _setValuesFromModel(widget.shoeArticleModel);
    // }
    if (widget.list != null) {
      _setListValues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Item Data'),
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
                const Divider(
                  color: lightGrey,
                ),
                TextFormFieldWidget(
                  controller: _articleController,
                  validator: (value) => Utils.simpleValidator(value),
                  label: 'Article Name',
                  hintText: "Enter your article name",
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
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
                DropdownMenu<String>(
                  initialSelection: sizeList.first,
                  onSelected: (String? value) => dropDownMenuOnChanged(value),
                  dropdownMenuEntries: sizeList.map<DropdownMenuEntry<String>>(
                    (String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    },
                  ).toList(),
                ),
                Expanded(
                  child: _sizeArticleModelList.isEmpty
                      ? const Center(
                          child: NoDataWidget(
                            alertText: "No sizes selected yet!",
                          ),
                        )
                      : ListView.builder(
                          itemCount: _sizeArticleModelList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizeDataCard(
                              sizeModelList: _sizeArticleModelList[index],
                            );
                          },
                        ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(bottom: SizeConfig.height15(context) + 1),
                  width: double.infinity,
                  child: RoundedButton(
                    buttonColor: lightBlueColor,
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
    if (selectedItem != 'Custom Size') {
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
      if (str!.isNotEmpty) {
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

  void _uploadArticleData() {}
  void _setListValues() {
    setState(() {
      _sizeArticleModelList = widget.list!;
    });
  }
}
