import 'package:shoe_shop/models/article_color_model/article_size_color_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_size_model.g.dart';

@JsonSerializable()
class ArticleSizeModel {
  final String title;
  final List<ArticleSizeColorModel> colorAndQuantityList;
  final int salePrice;
  final int purchasePrice;
  ArticleSizeModel({
    required this.title,
    required this.colorAndQuantityList,
    required this.salePrice,
    required this.purchasePrice,
  });

  factory ArticleSizeModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleSizeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleSizeModelToJson(this);
}
