import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/constants.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class RateFieldWidget extends StatefulWidget {
  const RateFieldWidget({
    super.key,
    required this.controller,
    required this.fieldLabel,
    required this.hintText,
  });
  final TextEditingController controller;
  final String fieldLabel;
  final String hintText;

  @override
  State<RateFieldWidget> createState() => _RateFieldWidgetState();
}

class _RateFieldWidgetState extends State<RateFieldWidget> {
  int _fieldNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.height20(context)),
          child: Text(
            widget.fieldLabel,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: SizeConfig.height20(context)),
          child: TextButton(
            onPressed: () {
              _fieldNumber -= 1;
              setState(() {
                widget.controller.text = _fieldNumber.toString();
              });
            },
            style: const ButtonStyle(
                splashFactory:
                    NoSplash.splashFactory //removing onClick splash color
                ),
            child: Text(
              decrementSymbol,
              style: TextStyle(
                fontSize: SizeConfig.font24(context),
                color: lightGrey,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextFormFieldWidget(
            textAlign: TextAlign.center,
            controller: widget.controller,
            validator: (value) => Utils.simpleValidator(value),
            lable: '',
            hintText: widget.hintText,
            inputType: TextInputType.number,
            inputAction: TextInputAction.done,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: SizeConfig.height20(context)),
          child: TextButton(
            onPressed: () {
              _fieldNumber += 1;
              setState(() {
                widget.controller.text = _fieldNumber.toString();
              });
            },
            style: const ButtonStyle(
                splashFactory:
                    NoSplash.splashFactory //removing onClick splash color
                ),
            child: Text(
              incrementSymbol,
              style: TextStyle(
                fontSize: SizeConfig.font24(context),
                color: lightGrey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
