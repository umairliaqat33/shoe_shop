import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_color_model/article_size_color_model.dart';
import 'package:shoe_shop/views/screens/home_screen/components/card_color_lower_widget.dart';

class ArticleSizeColorNameWidget extends StatelessWidget {
  const ArticleSizeColorNameWidget({
    super.key,
    required this.articleSizeColorModel,
  });

  final ArticleSizeColorModel articleSizeColorModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          CardColorLowerWidget(
            color: Color(articleSizeColorModel.color),
          ),
          SizedBox(
            width: SizeConfig.height8(context),
          ),
          Flexible(
            child: Text(
              articleSizeColorModel.colorName,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(
            width: SizeConfig.height8(context),
          ),
        ],
      ),
    );
  }
}
