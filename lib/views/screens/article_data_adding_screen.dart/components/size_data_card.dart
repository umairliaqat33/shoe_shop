import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_size_model/article_size_model.dart';
import 'package:shoe_shop/views/screens/home_screen/components/color_container_widget.dart';
import 'package:shoe_shop/views/screens/size_colors_adding_screen/size_colors_adding_screen.dart';

class SizeDataCard extends StatefulWidget {
  const SizeDataCard({
    super.key,
    required this.sizeModelList,
    required this.deleteSize,
  });

  final List<ArticleSizeModel> sizeModelList;
  final Function deleteSize;

  @override
  State<SizeDataCard> createState() => _SizeDataCardState();
}

class _SizeDataCardState extends State<SizeDataCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.sizeModelList.length,
        itemBuilder: (BuildContext context, int sizeListIndex) {
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.sizeModelList[sizeListIndex].title,
                  style: TextStyle(
                    fontSize: SizeConfig.font20(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: SizeConfig.height20(context) * 2,
                    child: ListView.builder(
                      reverse: true,
                      itemCount: widget.sizeModelList[sizeListIndex]
                          .colorAndQuantityList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int colorListIndex) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColorContainerWidget(
                              color: Color(
                                widget.sizeModelList[sizeListIndex]
                                    .colorAndQuantityList[colorListIndex].color,
                              ),
                              quantity: widget
                                  .sizeModelList[sizeListIndex]
                                  .colorAndQuantityList[colorListIndex]
                                  .quantity,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _deleteArticleSize(sizeListIndex),
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _editSize(
                        context: context,
                        articleSizeModel: widget.sizeModelList[sizeListIndex],
                        index: sizeListIndex,
                      ),
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<void> _editSize({
    required ArticleSizeModel articleSizeModel,
    required BuildContext context,
    required int index,
  }) async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SizeColorsAddingScreen(
          sizeName: articleSizeModel.title,
          articleSizeModel: articleSizeModel,
        ),
      ),
    );
    if (result != null) {
      widget.sizeModelList[index] = result;
    }
    setState(() {});
  }

  void _deleteArticleSize(int index) {
    widget.sizeModelList.removeAt(index);
    Fluttertoast.showToast(msg: "Size removed");
    widget.deleteSize();
  }
}
