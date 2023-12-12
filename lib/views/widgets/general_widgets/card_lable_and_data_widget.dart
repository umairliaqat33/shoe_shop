import 'package:flutter/material.dart';

import 'package:shoe_shop/views/screens/home_screen/components/card_label_widget.dart';
import 'package:shoe_shop/views/screens/home_screen/components/card_rate_widget.dart';

class CardLabelAndItemDataWidget extends StatelessWidget {
  const CardLabelAndItemDataWidget({
    super.key,
    required this.titleValue,
    required this.title,
  });

  final int titleValue;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CardLabelWidget(
          label: title,
        ),
        CardUpperValueWidget(
          rate: titleValue.toString(),
        ),
      ],
    );
  }
}
