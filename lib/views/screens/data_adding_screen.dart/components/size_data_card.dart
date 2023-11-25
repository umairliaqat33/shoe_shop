import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_model/article_size_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/home_screen/components/card_color_lower_widget.dart';

class SizeDataCard extends StatelessWidget {
  const SizeDataCard({
    super.key,
    required this.sizeModelList,
  });

  final ArticleSizeModel sizeModelList;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          sizeModelList.title,
          style: TextStyle(
            fontSize: SizeConfig.font20(context),
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: SizedBox(
          width: SizeConfig.width20(context) * 5,
          height: SizeConfig.height20(context) * 2,
          child: ListView.builder(
            reverse: true,
            itemCount: sizeModelList.colorAndQuantityList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardColorLowerWidget(
                    color: Color(
                      sizeModelList.colorAndQuantityList[index].color,
                    ),
                  ),
                  Text(
                    sizeModelList.colorAndQuantityList[index].quantity
                        .toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: lightGrey,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
