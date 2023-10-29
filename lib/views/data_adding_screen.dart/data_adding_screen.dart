import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/enums.dart';
import 'package:shoe_shop/utils/utils.dart';
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

  bool blueCheckBox = false;
  bool blackCheckBox = false;
  bool redCheckBox = false;
  bool greenCheckBox = false;
  bool offWhiteCheckBox = false;
  bool yellowCheckBox = false;
  bool greyCheckBox = false;
  bool pinkCheckBox = false;
  bool whiteCheckBox = false;

  final List<Color> _colorList = [];
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
                  validator: (value) => Utils.articleValidator(value),
                  lable: 'Article Name',
                  hintText: "Enter your article number",
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                ),
                RateFieldWidget(controller: _rateController),
                SizedBox(
                  height: SizeConfig.height20(context),
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
                              _manufactureType = ManufactureType.chinaMade.name;
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
                SizedBox(
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
    );
  }

  void submitArticleData() {}
}
