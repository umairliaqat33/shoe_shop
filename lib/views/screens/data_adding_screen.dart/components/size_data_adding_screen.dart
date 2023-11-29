import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/models/article_color_model/article_size_color_model.dart';
import 'package:shoe_shop/models/article_model/article_size_model.dart';
import 'package:shoe_shop/utils/colors.dart';

class SizeDataAddingScreen extends StatefulWidget {
  const SizeDataAddingScreen({
    super.key,
    required this.sizeName,
    this.articleSizeModelList,
  });
  final String sizeName;
  final List<ArticleSizeModel>? articleSizeModelList;

  @override
  State<SizeDataAddingScreen> createState() => _SizeDataAddingScreenState();
}

class _SizeDataAddingScreenState extends State<SizeDataAddingScreen> {
  List<String> colorList = [
    'Select a Size',
    'Blue',
    'Black',
    'Brown',
    'Camel',
    'Yellow',
    'Green',
    'Orange',
    'Pink',
    'Sky Blue',
    'Parrot',
    'White',
  ];
  String selectedItem = '';
  List<ArticleSizeColorModel> _articleSizeColorModelList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Size Data'),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width8(context) * 2,
            right: SizeConfig.width8(context) * 2,
            top: SizeConfig.height8(context) * 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Size Name",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                ),
              ),
              SizedBox(
                height: SizeConfig.height8(context),
              ),
              Text(
                widget.sizeName,
                style: TextStyle(
                  fontSize: SizeConfig.font20(context),
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
              ),
              SizedBox(
                height: SizeConfig.height8(context),
              ),
              const Text(
                "Please select a color",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                ),
              ),
              SizedBox(
                height: SizeConfig.height8(context),
              ),
              DropdownMenu<String>(
                initialSelection: colorList.first,
                onSelected: (String? value) {
                  setState(() {
                    selectedItem = value!;
                  });
                  // _articleSizeColorModelList.add(ArticleSizeColorModel(color: color, quantity: quantity));
                  log(selectedItem);
                },
                dropdownMenuEntries:
                    colorList.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
