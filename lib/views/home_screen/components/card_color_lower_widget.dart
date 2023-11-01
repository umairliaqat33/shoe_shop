import 'package:flutter/material.dart';
import 'package:shoe_shop/utils/colors.dart';

class CardColorLowerWidget extends StatelessWidget {
  const CardColorLowerWidget({
    super.key,
    required this.color,
  });
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: blackColor,
        ),
      ),
    );
  }
}
