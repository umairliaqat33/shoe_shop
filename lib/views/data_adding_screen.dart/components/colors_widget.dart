import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/widgets/check_box_widgets/check_box_row_widget.dart';

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({
    super.key,
    required List<Color> colorList,
    required this.blueCheckBox,
    required this.greenCheckBox,
    required this.blackCheckBox,
    required this.redCheckBox,
    required this.yellowCheckBox,
    required this.offWhiteCheckBox,
    required this.pinkCheckBox,
    required this.whiteCheckBox,
  }) : _colorList = colorList;

  final List<Color> _colorList;
  final bool blueCheckBox;
  final bool greenCheckBox;
  final bool blackCheckBox;
  final bool redCheckBox;
  final bool yellowCheckBox;
  final bool offWhiteCheckBox;
  final bool pinkCheckBox;
  final bool whiteCheckBox;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please select your colors:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: SizeConfig.height8(context),
            ),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CheckBoxRowWidget(
                    boxName: "Blue",
                    list: _colorList,
                    value: blueCheckBox,
                    activeColor: blueColor,
                    checkColor: whiteColor,
                  ),
                  CheckBoxRowWidget(
                    boxName: "Green",
                    list: _colorList,
                    value: greenCheckBox,
                    activeColor: greenColor,
                    checkColor: whiteColor,
                  ),
                  CheckBoxRowWidget(
                    boxName: "Black",
                    list: _colorList,
                    value: blackCheckBox,
                    activeColor: blackColor,
                    checkColor: whiteColor,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CheckBoxRowWidget(
                    boxName: "Red",
                    list: _colorList,
                    value: redCheckBox,
                    activeColor: redColor,
                    checkColor: whiteColor,
                  ),
                  CheckBoxRowWidget(
                    boxName: "Yellow",
                    list: _colorList,
                    value: yellowCheckBox,
                    activeColor: yellowColor,
                    checkColor: blackColor,
                  ),
                  CheckBoxRowWidget(
                    boxName: "Grey",
                    list: _colorList,
                    value: greenCheckBox,
                    activeColor: greyColor,
                    checkColor: whiteColor,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CheckBoxRowWidget(
                    boxName: "Off White",
                    list: _colorList,
                    value: offWhiteCheckBox,
                    activeColor: offWhiteColor,
                    checkColor: whiteColor,
                  ),
                  CheckBoxRowWidget(
                    boxName: "Pink",
                    list: _colorList,
                    value: pinkCheckBox,
                    activeColor: pinkColor,
                    checkColor: whiteColor,
                  ),
                  CheckBoxRowWidget(
                    boxName: "White",
                    list: _colorList,
                    value: whiteCheckBox,
                    activeColor: whiteColor,
                    checkColor: blackColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
