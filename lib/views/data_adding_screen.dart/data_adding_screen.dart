import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';
import 'package:shoe_shop/models/shoe_article_model/shoe_article_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/enums.dart';
import 'package:shoe_shop/utils/exceptions.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:shoe_shop/views/data_adding_screen.dart/components/colors_widget.dart';
import 'package:shoe_shop/views/data_adding_screen.dart/components/rate_field_widget.dart';
import 'package:shoe_shop/views/data_adding_screen.dart/components/size_check_box_widget.dart';
import 'package:shoe_shop/views/widgets/round_button.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class DataAddingScreen extends StatefulWidget {
  const DataAddingScreen({super.key});

  @override
  State<DataAddingScreen> createState() => _DataAddingScreenState();
}

class _DataAddingScreenState extends State<DataAddingScreen> {
  final TextEditingController _articleController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool blueCheckBox = false;
  bool blackCheckBox = false;
  bool redCheckBox = false;
  bool greenCheckBox = false;
  bool offWhiteCheckBox = false;
  bool yellowCheckBox = false;
  bool greyCheckBox = false;
  bool pinkCheckBox = false;
  bool whiteCheckBox = false;
  bool _isColorListEmpty = false;
  bool _isSizeListEmpty = false;
  bool _ismanufactureEmpty = false;
  bool _showSpinner = false;

  final List<int> _colorList = [];
  final List<String> _sizeList = [];
  final bool _size2125 = false;
  final bool _size2630 = false;
  final bool _size3136 = false;
  final bool _size3237 = false;
  final bool _size3641 = false;
  final bool _size1519 = false;

  bool _localBoxType = false;
  bool _chinaBoxType = false;
  bool _semiChinaBoxType = false;
  String _manufactureType = '';

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
                  const Center(
                    child: Text(
                      "*Please fill out all the fields Correctly*",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const Divider(
                    color: lightGrey,
                  ),
                  TextFormFieldWidget(
                    controller: _articleController,
                    validator: (value) => Utils.simpleValidator(value),
                    lable: 'Article Name',
                    hintText: "Enter your article number",
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                  ),
                  RateFieldWidget(
                    controller: _rateController,
                    fieldLabel: 'Set your rate',
                    hintText: "i.e. 1,000",
                  ),
                  RateFieldWidget(
                    controller: _quantityController,
                    fieldLabel: "Enter quantity",
                    hintText: "i.e. 10",
                  ),
                  SizedBox(
                    height: SizeConfig.height20(context),
                  ),
                  Visibility(
                    visible: _ismanufactureEmpty,
                    child: const Text(
                      "*Please select a Manufacture type*",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(
                      10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: lightGrey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Please select Manufacture type:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CheckboxListTile(
                          title: Text(ManufactureType.local.name),
                          value: _localBoxType,
                          onChanged: (bool? value) {
                            if (value == true) {
                              setState(() {
                                _localBoxType = true;
                                _manufactureType = ManufactureType.local.name;
                                _semiChinaBoxType = false;
                                _chinaBoxType = false;
                              });
                            } else {
                              setState(() {
                                _localBoxType = false;
                                _manufactureType = '';
                              });
                            }
                            log(_manufactureType);
                          },
                        ),
                        CheckboxListTile(
                          title: Text(ManufactureType.semiChinaMade.name),
                          value: _semiChinaBoxType,
                          onChanged: (bool? value) {
                            if (value == true) {
                              setState(() {
                                _semiChinaBoxType = true;
                                _manufactureType =
                                    ManufactureType.semiChinaMade.name;
                                _localBoxType = false;
                                _chinaBoxType = false;
                              });
                            } else {
                              setState(() {
                                _semiChinaBoxType = false;
                                _manufactureType = '';
                              });
                            }
                            log(_manufactureType);
                          },
                        ),
                        CheckboxListTile(
                          title: Text(ManufactureType.chinaMade.name),
                          value: _chinaBoxType,
                          onChanged: (bool? value) {
                            if (value == true) {
                              setState(() {
                                _chinaBoxType = true;
                                _manufactureType =
                                    ManufactureType.chinaMade.name;
                                _localBoxType = false;
                                _semiChinaBoxType = false;
                              });
                            } else {
                              setState(() {
                                _chinaBoxType = false;
                                _manufactureType = '';
                              });
                            }
                            log(_manufactureType);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.height8(context),
                  ),
                  Visibility(
                    visible: _isColorListEmpty,
                    child: const Text(
                      "*Please select a color*",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  ColorsWidget(
                    colorList: _colorList,
                    blueCheckBox: blueCheckBox,
                    greenCheckBox: greenCheckBox,
                    blackCheckBox: blackCheckBox,
                    redCheckBox: redCheckBox,
                    yellowCheckBox: yellowCheckBox,
                    offWhiteCheckBox: offWhiteCheckBox,
                    pinkCheckBox: pinkCheckBox,
                    whiteCheckBox: whiteCheckBox,
                  ),
                  SizedBox(
                    height: SizeConfig.height8(context),
                  ),
                  Visibility(
                    visible: _isSizeListEmpty,
                    child: const Text(
                      "*Please select a size*",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizeCheckBoxColumnWidget(
                    sizeList: _sizeList,
                    size2125: _size2125,
                    size2630: _size2630,
                    size3136: _size3136,
                    size3237: _size3237,
                    size3641: _size3641,
                    size1519: _size1519,
                  ),
                  SizedBox(
                    height: SizeConfig.height8(context),
                  ),
                  _showSpinner
                      ? Container(
                          margin: EdgeInsets.only(
                            left: SizeConfig.width12(context) * 10,
                            right: SizeConfig.width12(context) * 10,
                          ),
                          child: const CircularProgressIndicator(),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: RoundedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () => submitArticleData(),
                            title: 'Done',
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

  void submitArticleData() {
    final FirestoreController firestoreController = FirestoreController();
    setState(() {
      _showSpinner = true;
    });
    try {
      _checkColorsList();
      _checkManufacture();
      _checkSizeList();
      if (_formKey.currentState!.validate()) {
        firestoreController.uploadShoeArticle(
          ShoeArticleModel(
              articleNumber: _articleController.text,
              quantity: int.parse(_quantityController.text),
              sizeList: _sizeList,
              manufactureType: _manufactureType,
              rate: int.parse(_rateController.text),
              colorList: _colorList),
        );
        Fluttertoast.showToast(msg: "Article Data Uploaded");
        _sizeList.clear();
        _colorList.clear();
        setState(() {
          _manufactureType = '';
          _articleController.clear();
          _rateController.clear();
          _quantityController.clear();
        });
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const BottomAppBarScreen(
              screenIndex: 0,
            ),
          ),
          (route) => false,
        );
      }
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log("Data uploading failed");
      Fluttertoast.showToast(msg: 'Data uploading failed');
    }
    setState(() {
      _showSpinner = false;
    });
  }

  void _checkColorsList() {
    if (_colorList.isEmpty) {
      setState(() {
        _isColorListEmpty = true;
      });
    } else {
      setState(() {
        _isColorListEmpty = false;
      });
    }
  }

  void _checkSizeList() {
    if (_sizeList.isEmpty) {
      setState(() {
        _isSizeListEmpty = true;
      });
    } else {
      setState(() {
        _isSizeListEmpty = false;
      });
    }
  }

  void _checkManufacture() {
    if (_manufactureType.isEmpty) {
      setState(() {
        _ismanufactureEmpty = true;
      });
    } else {
      setState(() {
        _ismanufactureEmpty = false;
      });
    }
  }
}
