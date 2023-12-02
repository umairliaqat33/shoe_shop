// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_size_color_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleSizeColorModel _$ArticleSizeColorModelFromJson(
        Map<String, dynamic> json) =>
    ArticleSizeColorModel(
      color: json['color'] as int,
      quantity: json['quantity'] as int,
      colorName: json['colorName'] as String,
    );

Map<String, dynamic> _$ArticleSizeColorModelToJson(
        ArticleSizeColorModel instance) =>
    <String, dynamic>{
      'color': instance.color,
      'quantity': instance.quantity,
      'colorName': instance.colorName,
    };
