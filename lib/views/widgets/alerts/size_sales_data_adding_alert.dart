import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';

class SizeSalesDataAddingAlert extends StatelessWidget {
  const SizeSalesDataAddingAlert({
    super.key,
    required this.onDoneTap,
    required this.context,
    required this.description,
    required this.headingText,
  });
  final Function onDoneTap;
  final BuildContext context;
  final String description;
  final String headingText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      backgroundColor: backgroundColor,
      contentPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      content: ConstrainedBox(
        constraints: BoxConstraints.tight(
          Size(
            (SizeConfig.width20(context) * 12.8),
            (SizeConfig.height20(context) * 10),
          ),
        ),
        child: Column(
          children: [
            Text(
              headingText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.font16(context),
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
          ],
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
