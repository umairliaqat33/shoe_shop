import 'package:flutter/material.dart';

import 'package:shoe_shop/utils/colors.dart';

class ColorContainerWidget extends StatelessWidget {
  const ColorContainerWidget({
    super.key,
    required this.color,
    this.quantity,
  });
  final Color color;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(
        left: 2.5,
        right: 2.5,
      ),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: blackColor,
        ),
        shape: BoxShape.circle,
      ),
      child: quantity == null
          ? null
          : Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _setTextColor(color),
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  Color _setTextColor(Color color) {
    if (color == blueColor) {
      return whiteColor;
    } else if (color == blackColor) {
      return whiteColor;
    } else if (color == brownColor) {
      return whiteColor;
    } else if (color == camelColor) {
      return blackColor;
    } else if (color == yellowColor) {
      return blackColor;
    } else if (color == greenColor) {
      return whiteColor;
    } else if (color == orangeColor) {
      return whiteColor;
    } else if (color == pinkColor) {
      return blackColor;
    } else if (color == skyBlueColor) {
      return blackColor;
    } else if (color == parrotColor) {
      return blackColor;
    } else if (color == maroonColor) {
      return whiteColor;
    } else {
      return blackColor;
    }
  }
}

List<String> colorList = [
  'Select a Color',
  'Blue',
  'Black',
  'Brown',
  'Camel',
  'Yellow',
  'Green',
  'Orange',
  'Pink',
  'Sky Blue',
  'Parrot',
  'Maroon',
  'White',
];
