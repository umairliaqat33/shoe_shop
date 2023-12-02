import 'package:flutter/material.dart';
import 'package:shoe_shop/utils/assets.dart';

class NoColorWidget extends StatelessWidget {
  const NoColorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "No Colors selected yet!",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: 200,
          child: Image.asset(
            Assets.emptyScreenImage,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
