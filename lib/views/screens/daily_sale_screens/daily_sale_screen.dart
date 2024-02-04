import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';
import 'package:shoe_shop/models/shoe_article_sold_model/shoe_article_sold_model.dart';
import 'package:shoe_shop/services/calculations.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/daily_sale_screens/components/add_sale_data_screen.dart';
import 'package:shoe_shop/views/screens/daily_sale_screens/components/sold_article_card_widget.dart';
import 'package:shoe_shop/views/screens/daily_sale_screens/components/sold_article_dialog_widget.dart';
import 'package:shoe_shop/views/widgets/general_widgets/no_data_widget.dart';

class DailySaleScreen extends StatefulWidget {
  const DailySaleScreen({super.key});

  @override
  State<DailySaleScreen> createState() => _DailySaleScreenState();
}

class _DailySaleScreenState extends State<DailySaleScreen> {
  List<ShoeArticleSoldModel> dailySaleData = [];
  final FirestoreController _firestoreController = FirestoreController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          elevation: 1,
          centerTitle: true,
          title: const Text(
            "Daily Sales",
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddSaleDataScreen(),
                ),
              );
            },
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            )),
        body: StreamBuilder<List<ShoeArticleSoldModel>?>(
          stream: _firestoreController.getSoldShoeArticleStreamList(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              const Center(
                child: NoDataWidget(
                  alertText: "No sales added yet!",
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            List<ShoeArticleSoldModel>? articleSoldModelList = snapshot.data;

            return ListView.builder(
              itemCount: articleSoldModelList!.length,
              itemBuilder: (BuildContext context, int soldArticleIndex) {
                return Padding(
                  padding: EdgeInsets.only(top: SizeConfig.height8(context)),
                  child: MaterialButton(
                    onPressed: () => _onItemClicked(
                      shoeArticleSoldModel:
                          articleSoldModelList[soldArticleIndex],
                      articleName: articleSoldModelList[soldArticleIndex]
                          .soldArticleModel
                          .articleNumber,
                    ),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.height8(context)),
                        child: SoldArticleCardWidget(
                          articleNumber: articleSoldModelList[soldArticleIndex]
                              .soldArticleModel
                              .articleNumber,
                          saleDate:
                              articleSoldModelList[soldArticleIndex].saleDate,
                          totalQuantity: Calculations.calculateTotalQuantity(
                            articleSoldModelList[soldArticleIndex]
                                .soldArticleModel
                                .articleSizeModelList,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _onItemClicked({
    required ShoeArticleSoldModel shoeArticleSoldModel,
    required String articleName,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SoldArticleDialogWidget(
            articleSizeModelList:
                shoeArticleSoldModel.soldArticleModel.articleSizeModelList,
            articleName: articleName,
            editFunction: () => _editSaleData(shoeArticleSoldModel),
            deleteFunction: () => _deleteSaleData(articleName),
          );
        });
  }

  void _editSaleData(ShoeArticleSoldModel shoeArticleSoldModel) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddSaleDataScreen(
          shoeArticleSoldModel: shoeArticleSoldModel,
        ),
      ),
    );
  }

  void _deleteSaleData(String articleName) {
    try {
      _firestoreController.deleteArticleSaleData(articleName);
      Fluttertoast.showToast(msg: "Successfuly deleted");
      Navigator.of(context).pop();
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong");
      log(e.toString());
    }
  }
}
