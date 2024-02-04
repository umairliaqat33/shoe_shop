import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shoe_shop/models/shoe_article_model/article_model.dart';
import 'package:shoe_shop/models/timestamp_converter/timestamp_converter.dart';

part 'shoe_article_sold_model.g.dart';

@JsonSerializable()
class ShoeArticleSoldModel {
  @TimestampConverter()
  DateTime saleDate;
  final ArticleModel soldArticleModel;

  ShoeArticleSoldModel({
    required this.saleDate,
    required this.soldArticleModel,
  });

  factory ShoeArticleSoldModel.fromJson(Map<String, dynamic> json) =>
      _$ShoeArticleSoldModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShoeArticleSoldModelToJson(this);
}
