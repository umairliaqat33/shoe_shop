import 'package:flutter/material.dart';
import 'package:shoe_shop/views/screens/home_screen/components/card_label_widget.dart';
import 'package:shoe_shop/views/screens/home_screen/components/card_rate_widget.dart';

class ArcticleCardUpperWidget extends StatelessWidget {
  const ArcticleCardUpperWidget({
    super.key,
    required this.articleNumber,
    required this.articleRate,
    required this.articleQuantity,
    required this.articleMade,
  });
  final String articleNumber;
  final int articleRate;
  final int articleQuantity;
  final String articleMade;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              articleNumber,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const CardLabelWidget(
              label: 'Rate:',
            ),
            CardUpperValueWidget(
              rate: articleRate.toString(),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CardLabelWidget(
              label: 'Quantity:',
            ),
            CardUpperValueWidget(
              rate: articleQuantity.toString(),
            ),
            const CardLabelWidget(
              label: 'Manufacture type:',
            ),
            CardUpperValueWidget(
              rate: articleMade,
            ),
          ],
        )
      ],
    );
  }
}
