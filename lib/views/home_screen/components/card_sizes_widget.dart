import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';

class CardSizesWidget extends StatelessWidget {
  const CardSizesWidget({
    super.key,
    required this.sizes,
  });
  final List<String> sizes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height20(context),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Text(
            "• ${sizes[index]}",
          );
        },
      ),
    );
  }
}
