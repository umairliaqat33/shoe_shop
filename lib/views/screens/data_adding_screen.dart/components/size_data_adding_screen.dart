import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_model/article_size_model.dart';
import 'package:shoe_shop/utils/colors.dart';

class SizeDataAddingScreen extends StatelessWidget {
  const SizeDataAddingScreen({
    super.key,
    required this.sizeName,
    this.articleSizeModelList,
  });
  final String sizeName;
  final List<ArticleSizeModel>? articleSizeModelList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width8(context) * 2,
            right: SizeConfig.width8(context) * 2,
            top: SizeConfig.height8(context) * 2,
          ),
          child: Column(
            children: [
              Text(
                sizeName,
                style: TextStyle(
                  fontSize: SizeConfig.font20(context),
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
