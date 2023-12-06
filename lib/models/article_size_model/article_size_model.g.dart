// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_size_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleSizeModel _$ArticleSizeModelFromJson(Map<String, dynamic> json) =>
    ArticleSizeModel(
      title: json['title'] as String,
      colorAndQuantityList: (json['colorAndQuantityList'] as List<dynamic>)
          .map((e) => ArticleSizeColorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      salePrice: json['salePrice'] as int,
      purchasePrice: json['purchasePrice'] as int,
    );

Map<String, dynamic> _$ArticleSizeModelToJson(ArticleSizeModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'colorAndQuantityList': instance.colorAndQuantityList,
      'salePrice': instance.salePrice,
      'purchasePrice': instance.purchasePrice,
    };
