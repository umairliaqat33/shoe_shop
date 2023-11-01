import 'package:flutter/material.dart';

class CardSizesWidget extends StatelessWidget {
  const CardSizesWidget({
    super.key,
    required this.sizes,
  });
  final List<String> sizes;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        Text(
          "• ${sizes[0]}",
        ),
        Text(
          "• ${sizes[1]}",
        ),
        Text(
          "• ${sizes[2]}",
        ),
        Text(
          "• ${sizes[3]}",
        ),
        Text(
          "• ${sizes[4]}",
        ),
        Text(
          "• ${sizes[4]}",
        ),
        Text(
          "• ${sizes[4]}",
        ),
        Text(
          "• ${sizes[4]}",
        ),
      ],
    );
  }
}
