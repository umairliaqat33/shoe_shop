import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shoe_shop/models/shoe_article_model/article_model.dart';

part 'shoe_article_sold_model.g.dart';

@JsonSerializable()
class ShoeArticleSoldModel {
  @TimestampConverter() // Apply the custom converter here
  final Timestamp saleDate;
  final ArticleModel soldArticleModel;

  ShoeArticleSoldModel({
    required this.saleDate,
    required this.soldArticleModel,
  });

  factory ShoeArticleSoldModel.fromJson(Map<String, dynamic> json) =>
      _$ShoeArticleSoldModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShoeArticleSoldModelToJson(this);
}

class TimestampConverter implements JsonConverter<Timestamp, int> {
  const TimestampConverter();

  @override
  Timestamp fromJson(int json) => Timestamp.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(Timestamp object) => object.millisecondsSinceEpoch;
}
