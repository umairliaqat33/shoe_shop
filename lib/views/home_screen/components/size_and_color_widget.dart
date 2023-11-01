import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/views/home_screen/components/card_color_lower_widget.dart';
import 'package:shoe_shop/views/home_screen/components/card_label_widget.dart';
import 'package:shoe_shop/views/home_screen/components/card_sizes_widget.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardColorLowerWidget(
                color: Color(
                  colorList[0],
                ),
              ),
              CardColorLowerWidget(
                color: Color(
                  colorList[1],
                ),
              ),
              CardColorLowerWidget(
                color: Color(
                  colorList[2],
                ),
              ),
              CardColorLowerWidget(
                color: Color(
                  colorList[3],
                ),
              ),
              CardColorLowerWidget(
                color: Color(
                  colorList[3],
                ),
              ),
              CardColorLowerWidget(
                color: Color(
                  colorList[3],
                ),
              ),
              CardColorLowerWidget(
                color: Color(
                  colorList[3],
                ),
              ),
              CardColorLowerWidget(
                color: Color(
                  colorList[3],
                ),
              ),
              CardColorLowerWidget(
                color: Color(
                  colorList[3],
                ),
              ),
              CardColorLowerWidget(
                color: Color(
                  colorList[3],
                ),
              ),
            ],
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
          CardSizesWidget(
            sizes: sizeList,
          ),
        ],
      ),
    );
  }
}
