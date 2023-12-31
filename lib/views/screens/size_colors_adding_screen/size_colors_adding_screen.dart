import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_color_model/article_size_color_model.dart';
import 'package:shoe_shop/models/article_size_model/article_size_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/screens/size_colors_adding_screen/components/size_color_name_widget.dart';
import 'package:shoe_shop/views/screens/size_colors_adding_screen/components/size_color_quantity_widget.dart';
import 'package:shoe_shop/views/widgets/general_widgets/no_data_widget.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class SizeColorsAddingScreen extends StatefulWidget {
  const SizeColorsAddingScreen({
    super.key,
    required this.sizeName,
    this.articleSizeModel,
  });
  final String sizeName;
  final ArticleSizeModel? articleSizeModel;

  @override
  State<SizeColorsAddingScreen> createState() => _SizeColorsAddingScreenState();
}

class _SizeColorsAddingScreenState extends State<SizeColorsAddingScreen> {
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
  List<ArticleSizeColorModel> _articleSizeColorModelList = [];
  final List<TextEditingController> _quantityControllerList = [];
  final TextEditingController _salePriceController = TextEditingController();
  final TextEditingController _purchasePriceController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.articleSizeModel != null) {
      _setValues();
    }
  }

  @override
  void dispose() {
    _salePriceController.dispose();
    _purchasePriceController.dispose();
    for (var element in _quantityControllerList) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          title: const Text('Add Size Data'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.width8(context) * 2,
              right: SizeConfig.width8(context) * 2,
              top: SizeConfig.height8(context) * 2,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
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
                    TextFormFieldWidget(
                      controller: _purchasePriceController,
                      validator: (value) => Utils.purchasePriceValidator(value),
                      label: "Purchase Price",
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      hintText: "i.e. 801",
                      maxLength: 7,
                      autofocus: true,
                    ),
                    SizedBox(
                      height: SizeConfig.height8(context),
                    ),
                    TextFormFieldWidget(
                      controller: _salePriceController,
                      validator: (value) => Utils.salePriceValidator(value),
                      label: "Sale Price",
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.done,
                      hintText: "i.e. 901",
                      maxLength: 7,
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
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        underline: Container(),
                        value: colorList.first,
                        onChanged: (String? value) => _dropDownButton(value),
                        items: colorList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.height8(context),
                    ),
                    SizedBox(
                      height: SizeConfig.height20(context) * 13,
                      child: _articleSizeColorModelList.isEmpty
                          ? const Center(
                              child: NoDataWidget(
                                alertText: "No colors selected yet!",
                              ),
                            )
                          : ListView.builder(
                              itemCount: _articleSizeColorModelList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.height5(context),
                                        right: SizeConfig.height5(context),
                                        top: SizeConfig.height5(context)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizeColorNameWidget(
                                          articleSizeColorModel:
                                              _articleSizeColorModelList[index],
                                        ),
                                        SizeColorQuantityWidget(
                                            quantityController:
                                                _quantityControllerList[index]),
                                        GestureDetector(
                                          onTap: () {
                                            _quantityControllerList
                                                .removeAt(index);
                                            _articleSizeColorModelList
                                                .removeAt(index);
                                            setState(() {});
                                            Fluttertoast.showToast(
                                                msg: "Color deleted");
                                          },
                                          child: const Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.height15(context) + 1),
                      width: double.infinity,
                      child: RoundedButton(
                        buttonColor: primaryColor,
                        title: "Done",
                        onPressed: () => _addArticleSize(),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void _dropDownButton(String? value) {
    setState(() {
      _selectedItem = value!;
    });
    if (_selectedItem == 'Select a Color') {
      Fluttertoast.showToast(msg: "Please select a valid color");
      return;
    } else if (!_checkIfColorExist(_selectedItem)) {
      _articleSizeColorModelList.add(
        ArticleSizeColorModel(
          color: _checkColor(_selectedItem),
          quantity: 1,
          colorName: _selectedItem,
        ),
      );
    } else {
      Fluttertoast.showToast(msg: "Color already exist");
    }
    _quantityControllerList.add(TextEditingController());
    log(_selectedItem);
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

  bool _checkIfColorExist(String colorName) {
    bool doExist = false;
    for (var element in _articleSizeColorModelList) {
      if (element.colorName == colorName) {
        doExist = true;
      }
    }
    return doExist;
  }

  void _addArticleSize() {
    if (_formKey.currentState!.validate()) {
      if (_articleSizeColorModelList.isNotEmpty) {
        for (int i = 0; i < _articleSizeColorModelList.length; i++) {
          _articleSizeColorModelList[i].quantity =
              int.parse(_quantityControllerList[i].text);
        }
      }
      Navigator.of(context).pop(
        ArticleSizeModel(
          title: widget.sizeName,
          colorAndQuantityList: _articleSizeColorModelList,
          salePrice: int.parse(_salePriceController.text),
          purchasePrice: int.parse(_purchasePriceController.text),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: "Please add some colors");
    }
  }

  void _setValues() {
    _purchasePriceController.text =
        widget.articleSizeModel!.purchasePrice.toString();
    _salePriceController.text = widget.articleSizeModel!.salePrice.toString();
    _articleSizeColorModelList = widget.articleSizeModel!.colorAndQuantityList;
    for (int i = 0;
        i < widget.articleSizeModel!.colorAndQuantityList.length;
        i++) {
      _quantityControllerList.add(TextEditingController());
    }
    for (int i = 0; i < _quantityControllerList.length; i++) {
      _quantityControllerList[i].text =
          _articleSizeColorModelList[i].quantity.toString();
    }
    setState(() {});
  }
}
