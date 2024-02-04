// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoe_article_sold_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoeArticleSoldModel _$ShoeArticleSoldModelFromJson(
        Map<String, dynamic> json) =>
    ShoeArticleSoldModel(
      saleDate:
          const TimestampConverter().fromJson(json['saleDate'] as Timestamp),
      soldArticleModel: ArticleModel.fromJson(
          json['soldArticleModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShoeArticleSoldModelToJson(
        ShoeArticleSoldModel instance) =>
    <String, dynamic>{
      'saleDate': const TimestampConverter().toJson(instance.saleDate),
      'soldArticleModel': instance.soldArticleModel.toJson(),
    };
