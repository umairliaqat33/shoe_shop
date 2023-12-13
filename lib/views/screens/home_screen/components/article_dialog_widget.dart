import 'package:flutter/material.dart';

import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_size_model/article_size_model.dart';
import 'package:shoe_shop/views/screens/home_screen/components/color_container_widget.dart';
import 'package:shoe_shop/views/widgets/general_widgets/card_lable_and_data_widget.dart';
import 'package:shoe_shop/views/widgets/general_widgets/no_data_widget.dart';

class ArticleDialogWidget extends StatelessWidget {
  const ArticleDialogWidget({
    super.key,
    required this.articleSizeModelList,
    required this.articleName,
    required this.editFunction,
    required this.deleteFunction,
  });

  final List<ArticleSizeModel> articleSizeModelList;
  final String articleName;
  final Function editFunction;
  final Function deleteFunction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        articleName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => editFunction(),
                  child: const Text("Edit"),
                ),
                TextButton(
                  onPressed: () => deleteFunction(),
                  child: const Text("Delete"),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height20(context) * 10,
              child: ListView.builder(
                itemCount: articleSizeModelList.length,
                itemBuilder: (BuildContext context, int sizeIndex) {
                  if (articleSizeModelList.isEmpty) {
                    return const Center(
                      child: NoDataWidget(
                        alertText: "No articles added yet!",
                      ),
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                articleSizeModelList[sizeIndex].title,
                                style: TextStyle(
                                  fontSize: SizeConfig.font12(context),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              CardLabelAndItemDataWidget(
                                titleValue:
                                    articleSizeModelList[sizeIndex].salePrice,
                                title: 'Sale Price',
                              ),
                              CardLabelAndItemDataWidget(
                                titleValue: articleSizeModelList[sizeIndex]
                                    .purchasePrice,
                                title: 'Purchase Price',
                              ),
                            ],
                          ),
                          const Divider(),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              itemCount: articleSizeModelList[sizeIndex]
                                  .colorAndQuantityList
                                  .length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder:
                                  (BuildContext context, int colorListIndex) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ColorContainerWidget(
                                      color: Color(
                                        articleSizeModelList[sizeIndex]
                                            .colorAndQuantityList[
                                                colorListIndex]
                                            .color,
                                      ),
                                      quantity: articleSizeModelList[sizeIndex]
                                          .colorAndQuantityList[colorListIndex]
                                          .quantity,
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
