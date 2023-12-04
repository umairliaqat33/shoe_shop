import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_model/article_size_model.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/screens/data_adding_screen.dart/components/size_data_adding_screen/article_size_data_adding_screen.dart';
import 'package:shoe_shop/views/widgets/round_button.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class CustomArticleSizeWidget extends StatelessWidget {
  const CustomArticleSizeWidget({
    super.key,
    required TextEditingController customSizeController,
    required this.sizeArticleModelList,
  }) : _customSizeController = customSizeController;

  final TextEditingController _customSizeController;
  final List<ArticleSizeModel> sizeArticleModelList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AlertDialog(
          title: const Text(
            "Add Custom Size",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: [
              TextFormFieldWidget(
                controller: _customSizeController,
                validator: (value) => Utils.simpleValidator(value),
                label: "Add a custom size",
                hintText: "Enter size name",
                inputType: TextInputType.text,
                inputAction: TextInputAction.done,
              ),
              SizedBox(
                height: SizeConfig.height8(context) * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: SizeConfig.width20(context) * 5,
                    child: RoundedButton(
                      buttonColor: lightGrey,
                      title: 'Cancel',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.width20(context) * 5,
                    child: RoundedButton(
                      buttonColor: lightBlueColor,
                      title: 'DONE',
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ArticleSizeDataAddingScreen(
                              sizeName: _customSizeController.text,
                              articleSizeModelList: sizeArticleModelList,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
