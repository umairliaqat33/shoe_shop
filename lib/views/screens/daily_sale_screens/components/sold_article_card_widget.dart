import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shoe_shop/views/widgets/general_widgets/card_lable_and_data_widget.dart';

class SoldArticleCardWidget extends StatelessWidget {
  const SoldArticleCardWidget({
    super.key,
    required this.articleNumber,
    required this.saleDate,
    required this.totalQuantity,
  });
  final String articleNumber;
  final DateTime saleDate;
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
          titleValue: totalQuantity.toString(),
          title: 'Sold Quantity',
        ),
        CardLabelAndItemDataWidget(
          titleValue: DateFormat.yMMMd().format(saleDate),
          title: 'Sole Date',
        ),
      ],
    );
  }
}
