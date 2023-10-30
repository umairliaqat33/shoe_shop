import 'package:json_annotation/json_annotation.dart';

part 'shoe_article_model.g.dart';

@JsonSerializable()
class ShoeArticleModel {
  final String articleNumber;
  final int quantity;
  final List<String> sizeList;
  final String manufactureType;
  final int rate;
  final List<int> colorList;

  ShoeArticleModel({
    required this.articleNumber,
    required this.quantity,
    required this.sizeList,
    required this.manufactureType,
    required this.rate,
    required this.colorList,
  });

  factory ShoeArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ShoeArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShoeArticleModelToJson(this);
}
