import 'package:flutter/material.dart';

import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/constants.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class SizeColorQuantityWidget extends StatefulWidget {
  const SizeColorQuantityWidget({
    super.key,
    required this.quantityController,
  });
  final TextEditingController quantityController;

  @override
  State<SizeColorQuantityWidget> createState() =>
      _SizeColorQuantityWidgetState();
}

class _SizeColorQuantityWidgetState extends State<SizeColorQuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.height8(context),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                  onPressed: () {
                    int i = 0;
                    if (widget.quantityController.text.isNotEmpty) {
                      i = int.parse(widget.quantityController.text.toString());
                    }
                    i += 1;
                    setState(() {
                      widget.quantityController.text = i.toString();
                    });
                  },
                  child: Text(
                    incrementSymbol,
                    style: TextStyle(
                      fontSize: SizeConfig.font24(context),
                      color: lightGrey,
                    ),
                  )),
            ),
            Expanded(
              flex: 2,
              child: TextFormFieldWidget(
                controller: widget.quantityController,
                validator: (value) => Utils.quantityValidator(value),
                label: "Quantity",
                inputAction: TextInputAction.done,
                inputType: TextInputType.number,
                hintText: "0",
                isLabelGrey: true,
              ),
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () {
                  int i = 0;
                  if (widget.quantityController.text.isNotEmpty) {
                    i = int.parse(widget.quantityController.text.toString());
                  }
                  i -= 1;
                  setState(() {
                    widget.quantityController.text = i.toString();
                  });
                },
                child: Text(
                  decrementSymbol,
                  style: TextStyle(
                    fontSize: SizeConfig.font24(context),
                    color: lightGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
