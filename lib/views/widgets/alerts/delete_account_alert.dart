import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';

deleteAccountAlert({
  required final Function onDeleteTap,
  required final Function onCancelTap,
  bool dismissibleProperty = true,
  required BuildContext context,
  required String description,
  required String image,
  required String heading,
}) {
  return showDialog(
    barrierDismissible: dismissibleProperty,
    context: context,
    builder: (context) {
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
              Padding(
                padding: EdgeInsets.only(
                  top: (SizeConfig.height15(context) * 2) + 2,
                  bottom: (SizeConfig.height8(context) * 2),
                ),
                child: Image.asset(image),
              ),
              Text(
                heading,
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
        actionsPadding:
            EdgeInsets.only(bottom: SizeConfig.height20(context) + 8),
        actions: [
          SizedBox(
            width: SizeConfig.width20(context) * 4.7,
            child: RoundedButton(
              buttonColor: Theme.of(context).primaryColor,
              onPressed: () => onDeleteTap(),
              title: 'DELETE',
            ),
          ),
          SizedBox(
            width: SizeConfig.width20(context) * 4.7,
            child: RoundedButton(
              buttonColor: Theme.of(context).primaryColor,
              onPressed: () => onCancelTap(),
              title: 'CANCEL',
            ),
          ),
        ],
      );
    },
  );
}
