import 'package:shoe_shop/models/article_size_model/article_size_model.dart';

class Calculations {
  static int calculateTotalQuantity(List<ArticleSizeModel> sizeModelList) {
    int totalQuantity = 0;
    for (var sizes in sizeModelList) {
      for (var colors in sizes.colorAndQuantityList) {
        totalQuantity = colors.quantity + totalQuantity;
      }
    }
    return totalQuantity;
  }

  static int calculateTotalColors(List<ArticleSizeModel> sizeModelList) {
    int totalColors = 0;
    for (var sizes in sizeModelList) {
      totalColors = sizes.colorAndQuantityList.length + totalColors;
    }
    return totalColors;
  }
}
