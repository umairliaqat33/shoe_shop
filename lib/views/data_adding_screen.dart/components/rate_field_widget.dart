import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/widgets/round_button.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class RateFieldWidget extends StatefulWidget {
  const RateFieldWidget({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  State<RateFieldWidget> createState() => _RateFieldWidgetState();
}

class _RateFieldWidgetState extends State<RateFieldWidget> {
  int _fieldNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.height20(context)),
              child: const Text(
                "Set your rate",
                style: TextStyle(
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
                child: Image.asset(
                  'assets/minus.png',
                  height: SizeConfig.height10(context),
                ),
              ),
            ),
            Expanded(
              child: TextFormFieldWidget(
                textAlign: TextAlign.center,
                controller: widget.controller,
                validator: (value) => Utils.articleValidator(value),
                lable: '',
                hintText: "i.e. 1,000",
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
                child: const Icon(
                  Icons.add,
                  color: lightGrey,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
