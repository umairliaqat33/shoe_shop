import 'package:flutter/material.dart';

class CardUpperValueWidget extends StatelessWidget {
  const CardUpperValueWidget({
    super.key,
    required this.rate,
  });
  final String rate;
  @override
  Widget build(BuildContext context) {
    return Text(
      rate,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
