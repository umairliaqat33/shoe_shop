import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/enums.dart';
import 'package:shoe_shop/views/home_screen/components/article_card_upper_widget.dart';
import 'package:shoe_shop/views/home_screen/components/size_and_color_widget.dart';

class ArticleCardWidget extends StatelessWidget {
  const ArticleCardWidget({
    super.key,
    required this.articleName,
    required this.articleRate,
    required this.articleQuantity,
    required this.articleMade,
    required this.sizeList,
    required this.colorList,
    required this.voidCallback,
  });
  final String articleName;
  final int articleRate;
  final int articleQuantity;
  final String articleMade;
  final List<String> sizeList;
  final List<int> colorList;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ArcticleCardUpperWidget(
          articleNumber: articleName,
          articleRate: articleRate,
          articleQuantity: articleQuantity,
          articleMade: checkArticleMade(),
        ),
        const Divider(
          color: lightGrey,
        ),
        SizedBox(
          width: 300,
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardSizesAndColorsWidget(
                  sizeList: sizeList,
                  colorList: colorList,
                ),
                SizedBox(
                  height: SizeConfig.height20(context) * 4,
                  child: const VerticalDivider(
                    thickness: 1,
                    color: lightGrey,
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () => voidCallback(),
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: lightGrey,
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(
                      //     Icons.edit,
                      //     color: lightGrey,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String checkArticleMade() {
    if (articleMade == ManufactureType.local.name) {
      return "Local";
    } else if (articleMade == ManufactureType.semiChinaMade.name) {
      return "Semi China Made";
    } else {
      return "China Made";
    }
  }
}
