import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_color_model/article_size_color_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/size_colors_adding_screen/components/size_color_name_widget.dart';
import 'package:shoe_shop/views/screens/size_colors_adding_screen/components/size_color_quantity_widget.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';

class SizeSalesDataAddingAlert extends StatelessWidget {
  const SizeSalesDataAddingAlert({
    super.key,
    required this.onDoneTap,
    required this.context,
    required this.description,
    required this.headingText,
    required this.colorModelList,
    required this.quantityControllerList,
  });
  final Function onDoneTap;
  final BuildContext context;
  final String description;
  final String headingText;
  final List<ArticleSizeColorModel> colorModelList;
  final List<TextEditingController> quantityControllerList;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      backgroundColor: backgroundColor,
      content: Padding(
        padding: EdgeInsets.only(top: SizeConfig.height8(context)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                headingText,
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
                  description,
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
                  itemCount: colorModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.height5(context),
                            right: SizeConfig.height5(context),
                            top: SizeConfig.height5(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizeColorNameWidget(
                              articleSizeColorModel: colorModelList[index],
                            ),
                            SizeColorQuantityWidget(
                              quantityController: quantityControllerList[index],
                            ),
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
            onPressed: () => onDoneTap(),
            title: 'NO',
          ),
        ),
      ],
    );
  }
}
