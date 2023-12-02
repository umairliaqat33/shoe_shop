import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_color_model/article_size_color_model.dart';
import 'package:shoe_shop/models/article_model/article_size_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/data_adding_screen.dart/components/size_data_adding_screen/components/article_size_color_name_widget.dart';
import 'package:shoe_shop/views/screens/data_adding_screen.dart/components/size_data_adding_screen/components/article_size_color_quantity_widget.dart';
import 'package:shoe_shop/views/screens/data_adding_screen.dart/components/size_data_adding_screen/components/no_color_widget.dart';
import 'package:shoe_shop/views/widgets/round_button.dart';

class SizeDataAddingScreen extends StatefulWidget {
  const SizeDataAddingScreen({
    super.key,
    required this.sizeName,
    this.articleSizeModelList,
  });
  final String sizeName;
  final List<ArticleSizeModel>? articleSizeModelList;

  @override
  State<SizeDataAddingScreen> createState() => _SizeDataAddingScreenState();
}

class _SizeDataAddingScreenState extends State<SizeDataAddingScreen> {
  List<String> colorList = [
    'Select a Color',
    'Blue',
    'Black',
    'Brown',
    'Camel',
    'Yellow',
    'Green',
    'Orange',
    'Pink',
    'Sky Blue',
    'Parrot',
    'Maroon',
    'White',
  ];
  String _selectedItem = '';
  final List<ArticleSizeColorModel> _articleSizeColorModelList = [];
  final List<TextEditingController> _quantityControllerList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Size Data'),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width8(context) * 2,
            right: SizeConfig.width8(context) * 2,
            top: SizeConfig.height8(context) * 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Size Name",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                ),
              ),
              SizedBox(
                height: SizeConfig.height8(context),
              ),
              Text(
                widget.sizeName,
                style: TextStyle(
                  fontSize: SizeConfig.font20(context),
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
              ),
              SizedBox(
                height: SizeConfig.height8(context),
              ),
              const Text(
                "Please select a color",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                ),
              ),
              SizedBox(
                height: SizeConfig.height8(context),
              ),
              DropdownMenu<String>(
                initialSelection: colorList.first,
                onSelected: (String? value) {
                  setState(() {
                    _selectedItem = value!;
                  });
                  _articleSizeColorModelList.add(
                    ArticleSizeColorModel(
                      color: _checkColor(_selectedItem),
                      quantity: 1,
                      colorName: _selectedItem,
                    ),
                  );
                  _quantityControllerList.add(TextEditingController());
                  log(_selectedItem);
                },
                dropdownMenuEntries:
                    colorList.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              SizedBox(
                height: SizeConfig.height8(context),
              ),
              Flexible(
                child: _articleSizeColorModelList.isEmpty
                    ? const Center(child: NoColorWidget())
                    : ListView.builder(
                        itemCount: _articleSizeColorModelList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: SizeConfig.height8(context),
                                right: SizeConfig.height8(context),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ArticleSizeColorNameWidget(
                                    articleSizeColorModel:
                                        _articleSizeColorModelList[index],
                                  ),
                                  ArticleSizeColorQuantityWidget(
                                      quantityController:
                                          _quantityControllerList[index]),
                                  IconButton(
                                    onPressed: () {
                                      _quantityControllerList.removeAt(index);
                                      _articleSizeColorModelList
                                          .removeAt(index);
                                      setState(() {});
                                      Fluttertoast.showToast(
                                          msg: "Color deleted");
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _checkColor(String colorName) {
    if (colorName == 'Blue') {
      return blueColor.value;
    } else if (colorName == 'Black') {
      return blackColor.value;
    } else if (colorName == 'Brown') {
      return brownColor.value;
    } else if (colorName == 'Camel') {
      return camelColor.value;
    } else if (colorName == 'Yellow') {
      return yellowColor.value;
    } else if (colorName == 'Green') {
      return greenColor.value;
    } else if (colorName == 'Orange') {
      return orangeColor.value;
    } else if (colorName == 'Pink') {
      return pinkColor.value;
    } else if (colorName == 'Sky Blue') {
      return skyBlueColor.value;
    } else if (colorName == 'Parrot') {
      return parrotColor.value;
    } else if (colorName == 'Maroon') {
      return maroonColor.value;
    } else {
      return whiteColor.value;
    }
  }
}
