import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_color_model/article_size_color_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/size_colors_adding_screen/components/size_color_name_widget.dart';
import 'package:shoe_shop/views/screens/size_colors_adding_screen/components/size_color_quantity_widget.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';

class SizeSalesDataAddingAlert extends StatefulWidget {
  const SizeSalesDataAddingAlert({
    super.key,
    required this.context,
    required this.description,
    required this.headingText,
    required this.colorModelList,
    required this.quantityControllerList,
    required this.highQuantityBorderEnabled,
  });
  final BuildContext context;
  final String description;
  final String headingText;
  final List<ArticleSizeColorModel> colorModelList;
  final List<TextEditingController> quantityControllerList;
  final List<bool> highQuantityBorderEnabled;

  @override
  State<SizeSalesDataAddingAlert> createState() =>
      _SizeSalesDataAddingAlertState();
}

class _SizeSalesDataAddingAlertState extends State<SizeSalesDataAddingAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      backgroundColor: backgroundColor,
      contentPadding: const EdgeInsets.all(0),
      content: Padding(
        padding: EdgeInsets.only(top: SizeConfig.height8(context)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.headingText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.font22(context),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.height8(context),
                  left: SizeConfig.width15(context) + 3,
                  right: SizeConfig.width15(context) + 3,
                ),
                child: Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: lightGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.font16(context),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.height20(context) * 10,
                child: ListView.builder(
                  itemCount: widget.colorModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,
                      shape: widget.highQuantityBorderEnabled[index]
                          ? const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              side: BorderSide(
                                color: redColor,
                              ),
                            )
                          : null,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.height5(context),
                            right: SizeConfig.height5(context),
                            top: SizeConfig.height5(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizeColorNameWidget(
                              textNameVisibility: false,
                              articleSizeColorModel:
                                  widget.colorModelList[index],
                            ),
                            SizeColorQuantityWidget(
                              quantityController:
                                  widget.quantityControllerList[index],
                            ),
                            IconButton(
                                onPressed: () => _removeColor(
                                      index: index,
                                    ),
                                icon: Icon(
                                  Icons.delete,
                                  size: SizeConfig.height20(context),
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: EdgeInsets.only(bottom: SizeConfig.height20(context) + 8),
      actions: [
        SizedBox(
          width: SizeConfig.width20(context) * 4.7,
          child: RoundedButton(
            buttonColor: greyColor,
            onPressed: () => _onDoneTap(),
            title: 'DONE',
          ),
        ),
      ],
    );
  }

  void _onDoneTap() {
    for (int i = 0; i < widget.colorModelList.length; i++) {
      if (widget.colorModelList[i].quantity <
          int.parse(widget.quantityControllerList[i].text)) {
        widget.highQuantityBorderEnabled[i] = true;
      } else if (int.parse(widget.quantityControllerList[i].text) < 0) {
        widget.highQuantityBorderEnabled[i] = true;
      } else {
        widget.highQuantityBorderEnabled[i] = false;
      }
      widget.colorModelList[i].quantity =
          int.parse(widget.quantityControllerList[i].text);
    }
    bool isQuantityHigh = false;
    for (var element in widget.highQuantityBorderEnabled) {
      if (element) {
        isQuantityHigh = true;
        break;
      }
    }
    setState(() {});
    if (isQuantityHigh) {
      Fluttertoast.showToast(msg: "Sale quantity is high then actual quantity");
      return;
    }
    Navigator.pop<List<ArticleSizeColorModel>>(context, widget.colorModelList);
  }

  void _removeColor({
    required int index,
  }) {
    setState(() {
      widget.highQuantityBorderEnabled.removeAt(index);
      widget.colorModelList.removeAt(index);
    });
    Fluttertoast.showToast(msg: "Color Removed");
  }
}
