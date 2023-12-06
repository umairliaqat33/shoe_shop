import 'package:flutter/material.dart';

class CardLabelWidget extends StatelessWidget {
  const CardLabelWidget({
    super.key,
    required this.label,
    this.fontWeight = FontWeight.w300,
    this.fontSize = 10,
  });
  final String label;
  final FontWeight fontWeight;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
