import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_color_model/article_size_color_model.dart';
import 'package:shoe_shop/models/article_model/article_size_model.dart';
import 'package:shoe_shop/models/shoe_article_model/shoe_article_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/screens/data_adding_screen.dart/components/size_data_adding_screen/size_data_adding_screen.dart';
import 'package:shoe_shop/views/screens/data_adding_screen.dart/components/size_data_card.dart';
import 'package:shoe_shop/views/widgets/round_button.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class DataAddingScreen extends StatefulWidget {
  const DataAddingScreen({
    super.key,
    this.shoeArticleModel,
  });
  final ShoeArticleModel? shoeArticleModel;

  @override
  State<DataAddingScreen> createState() => _DataAddingScreenState();
}

class _DataAddingScreenState extends State<DataAddingScreen> {
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
  List<ArticleSizeModel> sizeArticleModelList = [
    ArticleSizeModel(
      title: "title",
      colorAndQuantityList: [
        ArticleSizeColorModel(
          color: 4278222848,
          quantity: 10,
          colorName: 'yellow',
        )
      ],
      salePrice: 1000,
      purchasePrice: 800,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // if (widget.shoeArticleModel != null) {
    //   _setValuesFromModel(widget.shoeArticleModel);
    // }
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
            bottom: SizeConfig.height20(context) * 2,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: lightGrey,
                  ),
                  TextFormFieldWidget(
                    controller: _articleController,
                    validator: (value) => Utils.simpleValidator(value),
                    lable: 'Article Name',
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
                    onSelected: (String? value) {
                      setState(() {
                        selectedItem = value!;
                      });
                      if (selectedItem != 'Custom Size') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SizeDataAddingScreen(
                              sizeName: selectedItem,
                              articleSizeModelList: sizeArticleModelList,
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                AlertDialog(
                                  title: const Text(
                                    "Add Custom Size",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Column(
                                    children: [
                                      TextFormFieldWidget(
                                        controller: _customSizeController,
                                        validator: (value) =>
                                            Utils.simpleValidator(value),
                                        lable: "Add a custom size",
                                        hintText: "Enter size name",
                                        inputType: TextInputType.text,
                                        inputAction: TextInputAction.done,
                                      ),
                                      SizedBox(
                                        height: SizeConfig.height8(context) * 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width:
                                                SizeConfig.width20(context) * 5,
                                            child: RoundedButton(
                                              buttonColor: lightGrey,
                                              title: 'Cancel',
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                SizeConfig.width20(context) * 5,
                                            child: RoundedButton(
                                              buttonColor: lightBlueColor,
                                              title: 'DONE',
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SizeDataAddingScreen(
                                                      sizeName:
                                                          _customSizeController
                                                              .text,
                                                      articleSizeModelList:
                                                          sizeArticleModelList,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      log(selectedItem);
                    },
                    dropdownMenuEntries:
                        sizeList.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                  sizeArticleModelList.isEmpty
                      ? Text(
                          "No sizes selected yet",
                          style: TextStyle(
                            fontSize: SizeConfig.font18(context),
                          ),
                        )
                      : SizedBox(
                          height: SizeConfig.height20(context) * 10,
                          child: ListView.builder(
                            itemCount: sizeArticleModelList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizeDataCard(
                                sizeModelList: sizeArticleModelList[index],
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
