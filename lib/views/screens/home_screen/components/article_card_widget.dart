import 'package:flutter/material.dart';

import 'package:shoe_shop/views/widgets/general_widgets/card_lable_and_data_widget.dart';

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
            fontWeight: FontWeight.w400,
            fontSize: 20,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CardLabelAndItemDataWidget(
          titleValue: totalColors,
          title: 'Colors Available',
        ),
        CardLabelAndItemDataWidget(
          titleValue: totalQuantity,
          title: 'Total Quantity',
        ),
      ],
    );
  }
}
