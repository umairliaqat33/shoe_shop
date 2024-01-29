import 'package:flutter/material.dart';

import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_color_model/article_size_color_model.dart';
import 'package:shoe_shop/views/screens/home_screen/components/color_container_widget.dart';

class SizeColorNameWidget extends StatelessWidget {
  const SizeColorNameWidget({
    super.key,
    required this.articleSizeColorModel,
    this.textNameVisibility = true,
  });

  final ArticleSizeColorModel articleSizeColorModel;
  final bool textNameVisibility;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          ColorContainerWidget(
            color: Color(articleSizeColorModel.color),
          ),
          SizedBox(
            width: SizeConfig.height8(context),
          ),
          Flexible(
            child: Text(
              articleSizeColorModel.colorName,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: textNameVisibility
                    ? SizeConfig.font20(context)
                    : SizeConfig.font10(context),
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
