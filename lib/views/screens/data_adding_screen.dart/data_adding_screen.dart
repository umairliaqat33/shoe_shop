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
import 'package:shoe_shop/views/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:shoe_shop/views/screens/data_adding_screen.dart/components/colors_widget.dart';
import 'package:shoe_shop/views/screens/data_adding_screen.dart/components/rate_field_widget.dart';
import 'package:shoe_shop/views/screens/data_adding_screen.dart/components/size_check_box_widget.dart';
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
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _blueCheckBox = false;
  bool _blackCheckBox = false;
  bool _redCheckBox = false;
  bool _greenCheckBox = false;
  bool _offWhiteCheckBox = false;
  bool _yellowCheckBox = false;
  bool _greyCheckBox = false;
  bool _pinkCheckBox = false;
  bool _whiteCheckBox = false;
  bool _isColorListEmpty = false;
  bool _isSizeListEmpty = false;
  bool _ismanufactureEmpty = false;
  bool _showSpinner = false;

  List<int> _colorList = [];
  List<String> _sizeList = [];
  bool _size2125 = false;
  bool _size2630 = false;
  bool _size3136 = false;
  bool _size3237 = false;
  bool _size3641 = false;
  bool _size1519 = false;

  bool _localBoxType = false;
  bool _chinaBoxType = false;
  bool _semiChinaBoxType = false;
  String _manufactureType = '';

  @override
  void initState() {
    super.initState();
    if (widget.shoeArticleModel != null) {
      _setValuesFromModel(widget.shoeArticleModel);
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
                    blueCheckBox: _blueCheckBox,
                    greenCheckBox: _greenCheckBox,
                    blackCheckBox: _blackCheckBox,
                    redCheckBox: _redCheckBox,
                    yellowCheckBox: _yellowCheckBox,
                    offWhiteCheckBox: _offWhiteCheckBox,
                    pinkCheckBox: _pinkCheckBox,
                    whiteCheckBox: _whiteCheckBox,
                    greyCheckBox: _greyCheckBox,
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
                            onPressed: () => widget.shoeArticleModel == null
                                ? submitArticleData()
                                : updateArticleData(),
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

  void _setValuesFromModel(ShoeArticleModel? shoeArticle) {
    ShoeArticleModel shoeArticleModel = shoeArticle!;
    _checkColorListFromModel(shoeArticleModel.colorList);
    _checkSizeListFromModel(shoeArticleModel.sizeList);
    _checkManufactureFromModel(shoeArticleModel.manufactureType);
    setState(() {
      _articleController.text = shoeArticleModel.articleNumber;
      _quantityController.text = shoeArticleModel.quantity.toString();
      _rateController.text = shoeArticleModel.rate.toString();
      _sizeList = shoeArticleModel.sizeList;
      _colorList = shoeArticleModel.colorList;
    });
  }

  void _checkColorListFromModel(List<int> colorList) {
    setState(() {
      if (colorList.contains(blackColor.value)) {
        _blackCheckBox = true;
      }
      if (colorList.contains(blueColor.value)) {
        _blueCheckBox = true;
      }
      if (colorList.contains(redColor.value)) {
        _redCheckBox = true;
      }
      if (colorList.contains(greenColor.value)) {
        _greenCheckBox = true;
      }
      if (colorList.contains(yellowColor.value)) {
        _yellowCheckBox = true;
      }
      if (colorList.contains(greyColor.value)) {
        _greyCheckBox = true;
      }
      if (colorList.contains(offWhiteColor.value)) {
        _offWhiteCheckBox = true;
      }
      if (colorList.contains(pinkColor.value)) {
        _pinkCheckBox = true;
      }
      if (colorList.contains(whiteColor.value)) {
        _whiteCheckBox = true;
      }
    });
  }

  void _checkSizeListFromModel(List<String> sizeList) {
    setState(() {
      if (sizeList.contains('21/25')) {
        _size2125 = true;
      }
      if (sizeList.contains('26/30')) {
        _size2630 = true;
      }
      if (sizeList.contains('31/36')) {
        _size3136 = true;
      }
      if (sizeList.contains('32/37')) {
        _size3237 = true;
      }
      if (sizeList.contains('36/41')) {
        _size3641 = true;
      }
      if (sizeList.contains('15/19')) {
        _size1519 = true;
      }
    });
  }

  void _checkManufactureFromModel(String articleMade) {
    setState(() {
      if (articleMade == ManufactureType.local.name) {
        _manufactureType = articleMade;
        _localBoxType = true;
        _chinaBoxType = false;
        _semiChinaBoxType = false;
      }
      if (articleMade == ManufactureType.chinaMade.name) {
        _manufactureType = articleMade;
        _localBoxType = false;
        _chinaBoxType = true;
        _semiChinaBoxType = false;
      }
      if (articleMade == ManufactureType.semiChinaMade.name) {
        _manufactureType = articleMade;
        _localBoxType = false;
        _chinaBoxType = false;
        _semiChinaBoxType = true;
      }
    });
  }

  void updateArticleData() {
    final FirestoreController firestoreController = FirestoreController();
    setState(() {
      _showSpinner = true;
    });
    try {
      _checkColorsList();
      _checkManufacture();
      _checkSizeList();
      if (_formKey.currentState!.validate()) {
        firestoreController.updateShoeArticle(
          ShoeArticleModel(
            articleNumber: _articleController.text,
            quantity: int.parse(_quantityController.text),
            sizeList: _sizeList,
            manufactureType: _manufactureType,
            rate: int.parse(_rateController.text),
            colorList: _colorList,
          ),
          widget.shoeArticleModel!.articleNumber,
        );
        Fluttertoast.showToast(msg: "Article Data Updated");
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
      log("Data updating failed");
      Fluttertoast.showToast(msg: 'Data updating failed');
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
