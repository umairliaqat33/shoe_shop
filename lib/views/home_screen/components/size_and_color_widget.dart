import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/views/home_screen/components/card_color_lower_widget.dart';
import 'package:shoe_shop/views/home_screen/components/card_label_widget.dart';

class CardSizesAndColorsWidget extends StatelessWidget {
  const CardSizesAndColorsWidget({
    super.key,
    required this.colorList,
    required this.sizeList,
  });
  final List<int> colorList;
  final List<String> sizeList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardLabelWidget(
            label: "Colors: ",
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          SizedBox(
            height: SizeConfig.height8(context),
          ),
          SizedBox(
            height: SizeConfig.height20(context),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colorList.length,
              itemBuilder: (BuildContext context, int index) {
                return CardColorLowerWidget(
                  color: Color(
                    colorList[index],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: SizeConfig.height8(context),
          ),
          const CardLabelWidget(
            label: "Sizes: ",
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          SizedBox(
            height: SizeConfig.height8(context),
          ),
          SizedBox(
            height: SizeConfig.height20(context),
            child: ListView.builder(
              itemCount: sizeList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: Text(
                    "• ${sizeList[index]}",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
