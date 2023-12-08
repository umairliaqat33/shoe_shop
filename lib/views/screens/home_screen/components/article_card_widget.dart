import 'package:flutter/material.dart';
import 'package:shoe_shop/views/screens/home_screen/components/card_label_widget.dart';
import 'package:shoe_shop/views/screens/home_screen/components/card_rate_widget.dart';

class ArticleCardWidget extends StatelessWidget {
  const ArticleCardWidget({
    super.key,
    required this.articleNumber,
    required this.totalColors,
    required this.totalQuantity,
  });
  final String articleNumber;
  final int totalColors;
  final int totalQuantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          articleNumber,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CardLabelWidget(
              label: 'Colors Available',
            ),
            CardUpperValueWidget(
              rate: totalColors.toString(),
            ),
          ],
        ),
        Column(
          children: [
            const CardLabelWidget(
              label: 'Total Quantity',
            ),
            CardUpperValueWidget(
              rate: totalQuantity.toString(),
            ),
          ],
        )
      ],
    );
  }
}
