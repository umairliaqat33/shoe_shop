// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoe_article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoeArticleModel _$ShoeArticleModelFromJson(Map<String, dynamic> json) =>
    ShoeArticleModel(
      articleNumber: json['articleNumber'] as String,
      quantity: json['quantity'] as int,
      sizeList:
          (json['sizeList'] as List<dynamic>).map((e) => e as String).toList(),
      manufactureType: json['manufactureType'] as String,
      rate: json['rate'] as int,
      colorList:
          (json['colorList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$ShoeArticleModelToJson(ShoeArticleModel instance) =>
    <String, dynamic>{
      'articleNumber': instance.articleNumber,
      'quantity': instance.quantity,
      'sizeList': instance.sizeList,
      'manufactureType': instance.manufactureType,
      'rate': instance.rate,
      'colorList': instance.colorList,
    };
