import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_size_model/article_size_model.dart';
import 'package:shoe_shop/views/screens/home_screen/components/color_container_widget.dart';

class SizeDataCard extends StatelessWidget {
  const SizeDataCard({
    super.key,
    required this.sizeModelList,
    required this.deleteSize,
    // required this.editSize,
  });

  final List<ArticleSizeModel> sizeModelList;
  final Function deleteSize;
  // final Function editSize;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: sizeModelList.length,
        itemBuilder: (BuildContext context, int sizeListIndex) {
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sizeModelList[sizeListIndex].title,
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
                      itemCount: sizeModelList[sizeListIndex]
                          .colorAndQuantityList
                          .length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int colorListIndex) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColorContainerWidget(
                              color: Color(
                                sizeModelList[sizeListIndex]
                                    .colorAndQuantityList[colorListIndex]
                                    .color,
                              ),
                              quantity: sizeModelList[sizeListIndex]
                                  .colorAndQuantityList[colorListIndex]
                                  .quantity,
                            ),
                            // Text(
                            //   sizeModelList[sizeListIndex]
                            //       .colorAndQuantityList[colorListIndex]
                            //       .quantity
                            //       .toString(),
                            //   style: const TextStyle(
                            //     fontSize: 10,
                            //     fontWeight: FontWeight.w600,
                            //     color: lightGrey,
                            //   ),
                            // )
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
                    // IconButton(
                    //   onPressed: () => _editSize(
                    //     sizeName: '',
                    //     context: context,
                    //     index: sizeListIndex,
                    //   ),
                    //   icon: const Icon(Icons.edit),
                    // ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  // void _editSize({
  //   required String sizeName,
  //   required BuildContext context,
  //   required int index,
  // }) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => SizeColorsAddingScreen(
  //         sizeName: sizeName,
  //         articleSizeModelList: sizeModelList,
  //         index: index,
  //       ),
  //     ),
  //   );
  //   editSize();
  // }

  void _deleteArticleSize(int index) {
    sizeModelList.removeAt(index);
    Fluttertoast.showToast(msg: "Size removed");
    deleteSize();
  }
}
